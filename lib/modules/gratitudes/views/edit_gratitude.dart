import 'package:bridgestate/bridges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grateful_notes/core/asset_files.dart';
import 'package:grateful_notes/core/utilities/colors.dart';
import 'package:grateful_notes/core/utilities/navigator.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_flat_button.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/global/display/success_loading.dart';
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
                        .map((e) => const CustomTextArea())
                        .toList(),
                  const YSpace(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(const IconAssets().gallery),
                          const CustomText("Add Photo", size: 14)
                        ],
                      ),
                      const XSpace(10),
                      if (gv.currentEdit!.texts.length < 2)
                        GestureDetector(
                          onTap: () => gc.addNewField(),
                          child: Row(
                            children: [
                              SvgPicture.asset(const IconAssets().text),
                              const CustomText("Add Text", size: 14)
                            ],
                          ),
                        ),
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
                  Navigate.to(
                    const SuccessLoading(
                      texts: [
                        "You have saved a moment",
                        "Be proud of what you have done"
                      ],
                      colors: [AppColors.greyGreen, AppColors.chatreuse],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
