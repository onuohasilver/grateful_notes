import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grateful_notes/core/asset_files.dart';
import 'package:grateful_notes/core/utilities/colors.dart';
import 'package:grateful_notes/core/utilities/navigator.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:story_view/story_view.dart';

class RecapStory extends StatelessWidget {
  final sc = StoryController();
  RecapStory({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: StoryView(
        onComplete: () => Navigate.pop(),
        controller: sc,
        storyItems: [
          StoryItem(
              Container(
                child: Stack(
                  children: [
                    Image.asset(const ImageAssets().blob1),
                    Center(
                      child: SizedBox(
                        height: 250,
                        child: Stack(
                          children: [
                            Center(
                              child: Image.asset(const ImageAssets().shape2),
                            ),
                            Center(
                              child: Image.asset(const ImageAssets().shape1),
                            ),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  CustomText("OCT",
                                      size: 64, weight: FontWeight.bold),
                                  CustomText("2023",
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
              ),
              duration: const Duration(seconds: 4)),
          StoryItem(
              Container(
                color: AppColors.superLightGreen,
                child: Stack(
                  children: [
                    // Image.asset(const ImageAssets().blob1),
                    Center(
                      child: SizedBox(
                        height: 250,
                        child: Stack(
                          children: [
                            Center(
                              child: Image.asset(const ImageAssets().shape2),
                            ),
                            Center(
                              child: Image.asset(const ImageAssets().shape1),
                            ),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  CustomText("OCT",
                                      size: 64, weight: FontWeight.bold),
                                  CustomText("2023",
                                      size: 25, weight: FontWeight.bold),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 560,
                      child: Center(
                        child: SizedBox(
                          width: 250.w,
                          child: const CustomText(
                              "that’s how many minutes you spent writing down your happiest moments of the months...",
                              size: 16,
                              align: TextAlign.center),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              duration: const Duration(seconds: 300)),
          StoryItem.text(
              title: "tit x x xle", backgroundColor: AppColors.green),
          StoryItem.text(
              title: "ta a a a aitle", backgroundColor: AppColors.green)
        ],
      ),
    );
  }
}
