import 'package:bridgestate/state/bridge_state/bridge_methods.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grateful_notes/core/utilities/colors.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/global/display/custom_image.dart';
import 'package:grateful_notes/global/overlays/custom_modal_sheet.dart';
import 'package:grateful_notes/modules/gratitudes/controllers/gratitude_controller.dart';
import 'package:grateful_notes/modules/gratitudes/data/gratitude_edit_model.dart';
import 'package:grateful_notes/modules/user/controllers/user_variables.dart';

class GratitudeDisplayCard extends StatelessWidget {
  const GratitudeDisplayCard({Key? key, required this.gem}) : super(key: key);
  final GratitudeEditModel gem;

  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);
    UserVariables uv = UserVariables(state);
    GratitudeController gc = GratitudeController(state);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: () => CustomOverlays().showSheet(
            height: gem.imagePaths.isNotEmpty ? 500 : 350,
            color: Colors.white,
            child: GratitudeDisplayCardModal(gem: gem)),
        child: Container(
          width: 375.w,
          // height: 200,
          color: Colors.white54,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: colorMapper(gem.type).withOpacity(.25),
                width: double.infinity,
                height: 5.h,
                // padding: const EdgeInsets.all(5),
              ),
              const YSpace(5),
              CustomText(gem.texts.first, size: 14, height: 1.3),
              const YSpace(12),
              if (gem.imagePaths.isNotEmpty)
                SizedBox(
                  width: 375.w,
                  height: 120.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                        gem.imagePaths.length,
                        (index) => Container(
                              color: Colors.transparent,
                              margin: const EdgeInsets.only(right: 7),
                              width: 120,
                              height: 129,
                              child: CustomImage(src: gem.imagePaths[index]),
                            )),
                  ),
                ),
              if (gem.name != null)
                Align(
                    alignment: Alignment.bottomRight,
                    child: CustomText("${gem.name}",
                        size: 12, height: 1.3, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}

class GratitudeDisplayCardModal extends StatelessWidget {
  const GratitudeDisplayCardModal({
    Key? key,
    required this.gem,
  }) : super(key: key);

  final GratitudeEditModel gem;

  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);

    GratitudeController gc = GratitudeController(state);

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(gem.type, size: 20, weight: FontWeight.bold),
          const YSpace(12),
          CustomText(gem.privacy!, size: 12),
          const YSpace(12),
          Container(
            color: colorMapper(gem.type).withOpacity(.25),
            width: double.infinity,
            height: 3.h,
            // padding: const EdgeInsets.all(5),
          ),
          const YSpace(12),
          if (gem.imagePaths.isNotEmpty)
            SizedBox(
                width: 375.w,
                height: 170.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      gem.imagePaths.length,
                      (index) => Container(
                            color: Colors.transparent,
                            margin: const EdgeInsets.only(right: 7),
                            width: 180,
                            height: 189,
                            child: CustomImage(src: gem.imagePaths[index]),
                          )),
                )),
          const YSpace(12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: CustomText(
              gem.texts.first,
              size: 16,
              height: 1.5,
              align: TextAlign.center,
            ),
          ),
          if (gem.name != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CustomText("${gem.name}",
                  size: 12, height: 1.3, color: Colors.grey),
            ),
        ],
      ),
    );
  }
}

Color colorMapper(String type) {
  switch (type) {
    case "Something around me":
      return AppColors.purple;
    case "Something that I did":
      return AppColors.green;
    case "Something that was done for me":
      return const Color.fromARGB(255, 187, 32, 149);
    default:
      return AppColors.fadedPink;
  }
}

Color secondColorMapper(String type) {
  switch (type) {
    case "Something around me":
      return AppColors.lightBlue;
    case "Something that I did":
      return AppColors.superLightGreen;
    case "Something that was done for me":
      return AppColors.fadedPink;
    default:
      return AppColors.fadedPink;
  }
}
