import 'package:bridgestate/state/bridge_state/bridge_methods.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/global/display/custom_image.dart';
import 'package:grateful_notes/modules/gratitudes/controllers/gratitude_controller.dart';
import 'package:grateful_notes/modules/gratitudes/data/gratitude_edit_model.dart';
import 'package:grateful_notes/unhinged_controllers/audio/audio_controller.dart';
import 'package:grateful_notes/unhinged_controllers/audio/audio_variables.dart';

import 'gratitude_display_card.dart';

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
    AudioVariables auv = AudioVariables(state);
    AudioController auc = AudioController(state);

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
