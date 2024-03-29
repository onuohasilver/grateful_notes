import 'package:animate_do/animate_do.dart';
import 'package:bridgestate/state/bridge_state/bridge_methods.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grateful_notes/core/asset_files.dart';
import 'package:grateful_notes/core/utilities/navigator.dart';
import 'package:grateful_notes/global/custom_flat_button.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/modules/recaps/controllers/recap_variables.dart';
import 'package:grateful_notes/modules/recaps/views/recap_story.dart';

class RecapDialog extends StatefulWidget {
  const RecapDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<RecapDialog> createState() => _RecapDialogState();
}

class _RecapDialogState extends State<RecapDialog> {
  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);
    RecapVariables rv = RecapVariables(state);
    return Material(
      color: Colors.transparent,
      child: Container(
        color: Colors.white,
        height: 600.h,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 700.h,
              child: Stack(
                children: [
                  Center(
                    child: SizedBox(
                      height: 250,
                      child: Stack(
                        children: [
                          Center(
                            child: Spin(
                              infinite: true,
                              delay: const Duration(seconds: 2),
                              duration: const Duration(seconds: 2),
                              child: Image.asset(const ImageAssets().shape3),
                            ),
                          ),
                          Center(
                            child: Spin(
                                infinite: true,
                                duration: const Duration(seconds: 4),
                                child: Image.asset(const ImageAssets().shape2)),
                          ),
                          Center(
                            child: Swing(
                                infinite: true,
                                duration: const Duration(seconds: 3),
                                child: Image.asset(const ImageAssets().shape1)),
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText("${(rv.currentRecap?.month)}",
                                    size: 64, weight: FontWeight.bold),
                                const CustomText("2023",
                                    size: 25, weight: FontWeight.bold),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElasticIn(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        // top: 630,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: CustomFlatButton(
                            label: 'View Recap',
                            expand: true,
                            onTap: () {
                              Navigate.pop();
                              Navigate.to(RecapStory());
                            },
                            hasBorder: true,
                          ),
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
