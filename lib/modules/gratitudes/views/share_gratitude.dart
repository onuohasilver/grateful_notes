import 'package:animate_do/animate_do.dart';
import 'package:bridgestate/state/bridge_state/bridge_methods.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:cube_transition_plus/cube_transition_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grateful_notes/core/asset_files.dart';
import 'package:grateful_notes/core/utilities/colors.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/global/display/custom_image.dart';
import 'package:grateful_notes/global/display/state_aware_builder.dart';
import 'package:grateful_notes/modules/gratitudes/controllers/gratitude_controller.dart';
import 'package:grateful_notes/modules/gratitudes/controllers/gratitude_variables.dart';
import 'package:grateful_notes/modules/gratitudes/data/gratitude_edit_model.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:screenshot/screenshot.dart';

import '../../../core/utilities/navigator.dart';

class ShareGratitude extends StatelessWidget {
  ShareGratitude({super.key, required this.gem});

  final ScreenshotController ssc = ScreenshotController();
  final GratitudeEditModel gem;

  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);
    GratitudeController gc = GratitudeController(state);
    GratitudeVariables gv = GratitudeVariables(state);
    return Container(
      height: 875.h,
      color: Colors.black,
      child: Stack(
        children: [
          Screenshot(
            controller: ssc,
            child: Material(
              child: SizedBox(
                height: 700.h,
                width: 375.w,
                child: Column(
                  children: [
                    Expanded(
                      child: CubePageView(
                        children: [
                          ShareableGratitudePicture(
                              gem: gem, color: AppColors.hulkYellow),
                          ShareableGratitudePicture(
                            gem: gem,
                            color: AppColors.lightBlue,
                          ),
                          ShareableGratitudePicture(
                              gem: gem, color: AppColors.fadedGreen),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          StateAwareBuilder(
              currentState: gv.currentState,
              done: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 38.0.h),
                  child: Material(
                    color: Colors.transparent,
                    child: GestureDetector(
                      onTap: () async {
                        gc.shareGratitude(ssc);
                      },
                      child: const CustomText(
                        "Tap Here to share",
                        size: 18,
                        decoration: TextDecoration.underline,
                        weight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              loading: Align(
                alignment: Alignment.bottomCenter,
                child: LottieBuilder.asset(
                  const AnimationAssets().loading,
                  height: 150,
                ),
              ),
              error: Bounce(child: const Icon(Icons.error, color: Colors.red))),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => Navigate.pop(),
              child: const Padding(
                padding: EdgeInsets.only(top: 48.0, right: 20),
                child: Icon(
                  Icons.close,
                  size: 36,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ShareableGratitudePicture extends StatelessWidget {
  const ShareableGratitudePicture(
      {Key? key, required this.gem, required this.color})
      : super(key: key);
  final Color color;
  final GratitudeEditModel gem;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w) +
                const EdgeInsets.only(top: 70),
            child: Image.asset(
              const ImageAssets().happy1,
              height: 200,
            ),
          ),
          const YSpace(12),
          Padding(
            padding: const EdgeInsets.only(left: 19),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SlideInLeft(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 25.w),
                    // const EdgeInsets.only(top: 70),,
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(width: 3),
                          right: BorderSide(width: 3),
                          bottom: BorderSide(width: 3)),
                    ),
                    child: CustomText(DateFormat.yMMMMEEEEd().format(gem.date),
                        size: 15),
                  ),
                ),
                const YSpace(20),
                Spin(
                  child: Container(
                    height: 300,
                    margin: EdgeInsets.symmetric(horizontal: 25.w),
                    width: double.infinity,
                    padding: EdgeInsets.all(18.w),
                    decoration: BoxDecoration(
                        color: Colors.white, border: Border.all(width: 3)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomText(gem.texts.first, size: 14, height: 1.3),
                        if (gem.imagePaths.isNotEmpty)
                          SizedBox(
                            width: 375.w,
                            height: 120.h,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: List.generate(
                                  gem.imagePaths.length,
                                  (index) => Container(
                                        color: Colors.black,
                                        margin: const EdgeInsets.only(right: 7),
                                        width: 120,
                                        height: 129,
                                        child: CustomImage(
                                            src: gem.imagePaths[index]),
                                      )),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                // const Spacer(),
                const YSpace(10),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 30.w),
                    child: const CustomText("Happy Notes App", size: 12),
                  ),
                ),
                const YSpace(24),
              ],
            ),
          )
        ],
      ),
    );
  }
}
