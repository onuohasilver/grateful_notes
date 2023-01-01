import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grateful_notes/core/utilities/colors.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/global/display/custom_image.dart';
import 'package:grateful_notes/global/overlays/custom_modal_sheet.dart';
import 'package:grateful_notes/modules/gratitudes/data/gratitude_edit_model.dart';

class GratitudeDisplayCard extends StatelessWidget {
  const GratitudeDisplayCard({Key? key, required this.gem}) : super(key: key);
  final GratitudeEditModel gem;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: GestureDetector(
        onTap: () => CustomOverlays().showSheet(
            height: 400,
            color: colorMapper(gem.type),
            child: Column(
              children: [
                CustomText(gem.type, size: 20, weight: FontWeight.bold),
                const YSpace(12),
                SizedBox(
                  width: 375.w,
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      CustomImage(),
                      CustomImage(),
                      CustomImage()
                    ],
                  ),
                ),
                const YSpace(12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: CustomText(gem.texts.first, size: 14),
                ),
              ],
            )),
        child: ElasticIn(
          child: Container(
            width: 375.w,
            // height: 200,
            color: colorMapper(gem.type),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(gem.texts.first, size: 16, height: 1.3),
                if (gem.imagePaths.isNotEmpty)
                  SizedBox(
                    width: 375.w,
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                          gem.imagePaths.length,
                          (index) => CustomImage(
                                src: gem.imagePaths[index],
                              )),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Color colorMapper(String type) {
  switch (type) {
    case "Something around me":
      return AppColors.fadedPink;
    case "Something that I did":
      return AppColors.superLightGreen;
    case "Something that was done for me":
      return AppColors.fadedYellow;
    default:
      return AppColors.fadedPink;
  }
}
