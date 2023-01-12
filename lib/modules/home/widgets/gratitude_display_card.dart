import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
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
import 'package:grateful_notes/modules/home/widgets/gratitude_display_modal.dart';
import 'package:grateful_notes/modules/user/controllers/user_variables.dart';
import 'package:grateful_notes/unhinged_controllers/audio/audio_controller.dart';
import 'package:grateful_notes/unhinged_controllers/audio/audio_variables.dart';
import 'package:logger/logger.dart';

class GratitudeDisplayCard extends StatelessWidget {
  const GratitudeDisplayCard({Key? key, required this.gem}) : super(key: key);
  final GratitudeEditModel gem;

  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);
    UserVariables uv = UserVariables(state);
    GratitudeController gc = GratitudeController(state);
    AudioVariables auv = AudioVariables(state);
    AudioController auc = AudioController(state);
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
              const YSpace(5),
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
              const YSpace(12),
              if (gem.audio != null)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 350,
                            child: StreamBuilder<Duration>(
                                stream: auc.getDurationState(),
                                builder: (context, snapshot) {
                                  final duration = snapshot.data;
                                  final progress = duration ?? Duration.zero;
                                  return ProgressBar(
                                    progress:
                                        Duration(seconds: progress.inSeconds),
                                    total:
                                        Duration(seconds: gem.audioDuration!),
                                    progressBarColor: Colors.black,
                                    baseBarColor: Colors.grey.withOpacity(0.24),
                                    thumbColor: Colors.black,
                                    barHeight: 3.0,
                                    thumbRadius: 5.0,
                                    onSeek: (duration) {
                                      Logger().i(
                                          'User selected a new time: $duration');
                                    },
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: 50,
                        alignment: Alignment.topCenter,
                        child: auv.isPlaying &&
                                auv.currentlyBeingPlayed == gem.audio
                            ? Container(
                                padding: const EdgeInsets.all(8),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () => auc.pauseAudio(),
                                    child: const Icon(Icons.pause),
                                  ),
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.all(8),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () => auc.playAudio(
                                        source: "url", url: gem.audio),
                                    child:
                                        const Icon(Icons.play_arrow, size: 30),
                                  ),
                                ),
                              )),
                  ],
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
