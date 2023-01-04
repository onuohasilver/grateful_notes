import 'package:bridgestate/state/bridge_state/bridge_methods.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grateful_notes/core/asset_files.dart';
import 'package:grateful_notes/core/utilities/colors.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_flat_button.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/global/overlays/custom_modal_sheet.dart';
import 'package:grateful_notes/modules/gratitudes/controllers/gratitude_controller.dart';
import 'package:grateful_notes/modules/gratitudes/views/edit_gratitude.dart';

class AddNewGratitude extends StatelessWidget {
  const AddNewGratitude({super.key});

  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);
    GratitudeController gc = GratitudeController(state);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(const ImageAssets().blackWoman),
        const YSpace(34),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText("What are you \nhappy about?", size: 34),
              const YSpace(20),
              CustomFlatButton(
                  label: "Something that I did",
                  icon: const IconAssets().person,
                  hasBorder: true,
                  onTap: () => {
                        gc.createNew("Something that I did"),
                        CustomOverlays().showSheet(
                            height: 600.h,
                            color: AppColors.superLightGreen,
                            child: const EditGratitude(
                                header: "Something that I did..."),
                            popPrevious: true),
                      }),
              const YSpace(10),
              CustomFlatButton(
                  label: "Something that was done for me",
                  hasBorder: true,
                  icon: const IconAssets().people,
                  onTap: () => {
                        gc.createNew("Something that was done for me"),
                        CustomOverlays().showSheet(
                            height: 600.h,
                            color: AppColors.fadedYellow,
                            child: const EditGratitude(
                                header: "Something done for me..."),
                            popPrevious: true),
                      }),
              const YSpace(10),
              CustomFlatButton(
                  label: "Something around me",
                  hasBorder: true,
                  icon: const IconAssets().around,
                  onTap: () => {
                        gc.createNew("Something around me"),
                        CustomOverlays().showSheet(
                            height: 600.h,
                            color: AppColors.fadedPink,
                            child: const EditGratitude(
                                header: "Something around me.."),
                            popPrevious: true),
                      })
            ],
          ),
        )
      ],
    );
  }
}
