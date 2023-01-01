import 'package:bridgestate/bridges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grateful_notes/core/asset_files.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_flat_button.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/modules/gratitudes/controllers/gratitude_controller.dart';
import 'package:grateful_notes/modules/gratitudes/controllers/gratitude_variables.dart';
import 'package:grateful_notes/modules/gratitudes/widgets/custom_text_area.dart';

class EditGratitude extends StatelessWidget {
  const EditGratitude({super.key, required this.header});
  final String header;
  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);
    GratitudeVariables gv = GratitudeVariables(state);
    GratitudeController gc = GratitudeController(state);
    return SizedBox(
      height: 600.h,
      child: Stack(
        children: [
          SizedBox(
            height: 600.h,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    header,
                    size: 20,
                    weight: FontWeight.bold,
                  ),
                  const YSpace(12),
                  if (gv.currentEdit != null)
                    ...gv.currentEdit!.texts
                        .map(
                            (e) => CustomTextArea(onChanged: gc.addTextToModel))
                        .toList(),
                  const YSpace(12),
                  if (gv.currentEdit!.imagePaths.isNotEmpty)
                    // SizedBox(
                    //   height: 200,
                    //   child: Image.file(File(gv.currentEdit!.imagePaths.first)),
                    // ),
                    const YSpace(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => gc.addImageToModel(),
                        child: Row(
                          children: [
                            SvgPicture.asset(const IconAssets().gallery),
                            const CustomText("Add Photo", size: 14)
                          ],
                        ),
                      ),
                      const XSpace(10),
                      const XSpace(10),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: CustomFlatButton(
                label: "Save",
                hasBorder: true,
                expand: true,
                onTap: () {
                  gc.saveGratitude();
                  // gc.getGratitudes();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
