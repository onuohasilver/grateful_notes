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
      padding: const EdgeInsets.only(bottom: 8.0),
      child: GestureDetector(
        onTap: () => CustomOverlays().showSheet(
            height: 400,
            color: AppColors.fadedPink,
            child: Column(
              children: [
                const CustomText(
                  "Something done for me!",
                  size: 20,
                  weight: FontWeight.bold,
                ),
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
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: CustomText(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna",
                      size: 12),
                ),
              ],
            )),
        child: ElasticIn(
          child: Container(
            width: 375.w,
            height: 200,
            color: AppColors.fadedPink,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(gem.texts.first, size: 14, height: 1.3),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
