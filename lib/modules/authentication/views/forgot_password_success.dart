import 'package:animate_do/animate_do.dart';
import 'package:bridgestate/state/bridge_builder.dart';
import 'package:bridgestate/state/bridge_state/bridge_methods.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:flutter/material.dart';
import 'package:grateful_notes/core/asset_files.dart';
import 'package:grateful_notes/core/utilities/colors.dart';
import 'package:grateful_notes/core/utilities/navigator.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_flat_button.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/global/generic/flower_backdrop.dart';
import 'package:lottie/lottie.dart';

class ForgotPasswordSuccess extends StatelessWidget {
  const ForgotPasswordSuccess({Key? key, this.secondary}) : super(key: key);

  final Widget? secondary;
  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);

    return BounceInDown(
      child: BridgeBuilder(
        controllers: const [],
        dispose: true,
        child: FlowerBackdrop(
            color: AppColors.green,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const YSpace(80),
                      Pulse(
                        infinite: true,
                        child: LottieBuilder.asset(const AnimationAssets().done,
                            height: 100),
                      ),
                      const YSpace(12),
                      const Center(
                        child: CustomText(
                            "We have successfully sent the email to you, now check your email and follow the link to change your password",
                            size: 20,
                            align: TextAlign.center,
                            color: Colors.white,
                            height: 1.3),
                      ),
                      const YSpace(20),
                      CustomFlatButton(
                          label: "Go back", onTap: () => Navigate.pop()),
                      const YSpace(30),
                    ],
                  ),
                ),
                const YSpace(40),
                // const CustomKeyboard()
              ],
            )),
      ),
    );
  }
}
