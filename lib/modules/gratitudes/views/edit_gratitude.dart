import 'package:bridgestate/bridges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grateful_notes/core/utilities/navigator.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_flat_button.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/global/display/custom_image.dart';
import 'package:grateful_notes/global/overlays/custom_modal_sheet.dart';
import 'package:grateful_notes/modules/gratitudes/controllers/gratitude_controller.dart';
import 'package:grateful_notes/modules/gratitudes/controllers/gratitude_variables.dart';
import 'package:grateful_notes/modules/gratitudes/widgets/custom_text_area.dart';
import 'package:grateful_notes/modules/settings/controllers/settings_variables.dart';
import 'package:grateful_notes/unhinged_controllers/audio/audio_controller.dart';
import 'package:grateful_notes/unhinged_controllers/audio/audio_variables.dart';
import 'package:lottie/lottie.dart';

class EditGratitude extends StatelessWidget {
  const EditGratitude({super.key, required this.header});
  final String header;
  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);
    GratitudeVariables gv = GratitudeVariables(state);
    GratitudeController gc = GratitudeController(state);

    AudioVariables auv = AudioVariables(state);
    AudioController auc = AudioController(state);

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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: CustomText(
                      title(header),
                      size: 20,
                      height: 1.5,
                      weight: FontWeight.bold,
                    ),
                  ),
                  const YSpace(12),
                  if (gv.currentEdit != null)
                    ...gv.currentEdit!.texts
                        .map((e) => CustomTextArea(
                              onChanged: gc.addTextToModel,
                              autofocus: true,
                            ))
                        .toList(),
                  const YSpace(12),

                  const YSpace(12),
                  Row(
                    children: [
                      const XSpace(10),
                      GestureDetector(
                        onTap: () => gc.addPrivacyToModel(
                          gv.currentEdit!.privacy! == "Private"
                              ? "Open"
                              : "Private",
                        ),
                        child: Container(
                          decoration: BoxDecoration(border: Border.all()),
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            children: [
                              Icon(
                                  gv.currentEdit!.privacy! == "Private"
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  size: 12),
                              const YSpace(12),
                              CustomText(
                                  gv.currentEdit!.privacy! == "Private"
                                      ? "Set to Private"
                                      : "Set to Open",
                                  size: 14,
                                  weight: FontWeight.bold)
                            ],
                          ),
                        ),
                      ),
                      const XSpace(10),
                      Visibility(
                        visible: gv.currentEdit!.imagePaths.isEmpty,
                        child: GestureDetector(
                          onTap: () => CustomOverlays().showSheet(
                            height: 400,
                            color: Colors.white,
                            child: const StickerModal(),
                          ),
                          child: Container(
                            decoration: BoxDecoration(border: Border.all()),
                            padding: const EdgeInsets.all(4),
                            child: Row(
                              children: const [
                                Icon(Icons.add, size: 12),
                                CustomText(
                                  "Add Sticker",
                                  size: 14,
                                  weight: FontWeight.bold,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const XSpace(10),
                      Visibility(
                        visible: gv.currentEdit!.stickers!.isEmpty,
                        child: GestureDetector(
                          onTap: () => gc.addImageToModel(),
                          child: Container(
                            decoration: BoxDecoration(border: Border.all()),
                            padding: const EdgeInsets.all(4),
                            child: Row(
                              children: const [
                                Icon(Icons.add, size: 12),
                                CustomText("Add Photo",
                                    size: 14, weight: FontWeight.bold)
                              ],
                            ),
                          ),
                        ),
                      ),
                      const XSpace(10),
                      Visibility(
                        visible: gv.currentEdit!.texts.first == "",
                        child: GestureDetector(
                          onTap: () => {
                            auc.record(),
                            CustomOverlays().showSheet(
                              height: 400.h,
                              child: const AudioRecordingModal(),
                              color: Colors.white,
                            ),
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(1000)),
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              children: const [
                                Icon(Icons.mic, size: 24, color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const YSpace(12),
                  if (auv.currentAudio != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          auv.isPlaying
                              ? Container(
                                  padding: const EdgeInsets.all(8),
                                  child: GestureDetector(
                                    onTap: () => auc.pauseAudio(),
                                    child: const Icon(Icons.pause),
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.all(8),
                                  child: GestureDetector(
                                    onTap: () => auc.playAudio(),
                                    child: const Icon(Icons.play_arrow),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      XSpace(10),
                    ],
                  ),
                  const YSpace(12),
                  if (gv.currentEdit!.stickers!.isNotEmpty)
                    Row(
                      children: List.generate(
                          gv.currentEdit!.stickers!.length,
                          (index) => Container(
                                color: Colors.transparent,
                                margin: const EdgeInsets.only(right: 7),
                                width: 130,
                                height: 189,
                                child: CachedNetworkImage(
                                    imageUrl: gv.currentEdit!.stickers![index]),
                              )),
                    ),
                  // SizedBox(
                  //   width: 200.w,
                  //   height: 189,
                  //   child: Row(

                  //   ),
                  // ),
                  if (gv.currentEdit!.imagePaths.isNotEmpty)
                    SizedBox(
                      width: 375.w,
                      height: 189,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                            gv.currentEdit!.imagePaths.length,
                            (index) => Container(
                                  color: Colors.black,
                                  margin: const EdgeInsets.only(right: 7),
                                  width: 180,
                                  height: 189,
                                  child: CustomImage(
                                      src: gv.currentEdit!.imagePaths[index]),
                                )),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0) +
                  const EdgeInsets.only(bottom: 50),
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

class AudioRecordingModal extends StatelessWidget {
  const AudioRecordingModal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);

    AudioVariables auv = AudioVariables(state);
    AudioController auc = AudioController(state);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomText(
              "Recording",
              size: 18,
              weight: FontWeight.bold,
            ),
            const YSpace(10),
            LottieBuilder.network(
              "https://assets8.lottiefiles.com/packages/lf20_jguzhokp.json",
              height: 100,
            ),
            const YSpace(10),
            if (auv.timeStartedRecording != null)
              StreamBuilder(
                  stream: Stream.periodic(const Duration(seconds: 1)),
                  builder: (context, snapshot) {
                    return Text(
                        "${DateTime.now().difference(auv.timeStartedRecording!).format()}");
                  }),
            const YSpace(10),
            CustomFlatButton(
              label: "Stop",
              // bgColor: Colors.red,
              hasBorder: true,
              onTap: () {
                Navigate.pop();
                auc.stopRecord();
              },
            )
          ],
        ),
      ),
    );
  }
}

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

String title(String header) {
  switch (header) {
    case "Something that I did...":
      return "What did you do that made you smile?";
    case "Something done for me...":
      return "What did someone do for you that made you smile?";
    case "Something around me..":
      return "What happened that made you smile?";
    default:
      return "What did you do that made you smile?";
  }
}
