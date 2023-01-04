import 'package:bridgestate/state/bridge_builder.dart';
import 'package:bridgestate/state/bridge_state/bridge_methods.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:flutter/material.dart';
import 'package:grateful_notes/core/asset_files.dart';
import 'package:grateful_notes/core/utilities/colors.dart';
import 'package:grateful_notes/core/utilities/navigator.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/modules/recaps/controllers/recap_controller.dart';
import 'package:grateful_notes/modules/recaps/controllers/recap_variables.dart';
import 'package:grateful_notes/modules/recaps/views/recap_story_builder.dart';
import 'package:intl/intl.dart';
import 'package:story_view/story_view.dart';

class RecapStory extends StatelessWidget {
  final sc = StoryController();
  RecapStory({super.key});

  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);
    RecapController rc = RecapController(state);
    RecapVariables rv = RecapVariables(state);
    return BridgeBuilder(
      controllers: [rc],
      child: Material(
        child: StoryView(
          // onStoryShow: (_) => ,
          indicatorColor: Colors.black,
          onComplete: () => Navigate.pop(),
          onVerticalSwipeComplete: (direction) {
            if (direction!.index == 0) {
              Navigate.pop();
            }
          },
          controller: sc,
          storyItems: [
            StoryItem(
                Stack(
                  children: [
                    Image.asset(const ImageAssets().blob1),
                    Center(
                      child: SizedBox(
                        height: 250,
                        child: Stack(
                          children: [
                            Center(
                                child: Image.asset(const ImageAssets().shape2)),
                            Center(
                                child: Image.asset(const ImageAssets().shape1)),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(
                                      DateFormat('MMMM').format(DateTime.now()),
                                      size: 64,
                                      weight: FontWeight.bold),
                                  CustomText("${DateTime.now().year}",
                                      size: 25, weight: FontWeight.bold),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                duration: const Duration(seconds: 2)),
            StoryItem(
                RecapStoryBuilder(
                  color: AppColors.fadedPink,
                  image: const ImageAssets().shape5,
                  text:
                      "that’s how many minutes you spent writing down your happiest moments of the month...",
                  unit: 'minutes',
                  value: '25',
                ),
                duration: const Duration(seconds: 10)),
            StoryItem(
                RecapStoryBuilder(
                  color: AppColors.superLightGreen,
                  image: const ImageAssets().shape4,
                  text:
                      "You recorded your happy moments ${rv.currentRecap?.numberOfMoments} times and we are so happy you found happiness in this month.",
                  unit: 'moments',
                  value: '${rv.currentRecap?.numberOfMoments}',
                ),
                duration: const Duration(seconds: 10)),
            StoryItem(
                RecapStoryBuilder(
                  color: AppColors.fadedYellow,
                  image: const ImageAssets().shape6,
                  text:
                      "The word you used most commonly as you wrote your happy moments",
                  unit: '✍️',
                  value: '${rv.currentRecap?.mostCommonWord}',
                ),
                duration: const Duration(seconds: 10)),
          ],
        ),
      ),
    );
  }
}
