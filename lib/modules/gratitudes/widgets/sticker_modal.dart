import 'package:bridgestate/bridges.dart';
import 'package:flutter/material.dart';
import 'package:grateful_notes/core/utilities/navigator.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/global/display/custom_image.dart';
import 'package:grateful_notes/modules/gratitudes/controllers/gratitude_controller.dart';
import 'package:grateful_notes/modules/settings/controllers/settings_variables.dart';

class StickerModal extends StatelessWidget {
  const StickerModal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);
    SettingsVariables sv = SettingsVariables(state);
    GratitudeController gc = GratitudeController(state);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        height: 400,
        child: Column(
          children: [
            const CustomText("Select Sticker",
                size: 18, weight: FontWeight.bold, height: 1.5),
            Expanded(
              child: GridView.builder(
                  padding: const EdgeInsets.only(bottom: 140),
                  itemCount: sv.config!.stickers!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => {
                        gc.addStickerToModel(sv.config!.stickers![index]!),
                        Navigate.pop()
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CustomImage(src: sv.config!.stickers![index]!),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
