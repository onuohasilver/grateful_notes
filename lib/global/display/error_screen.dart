import 'package:animate_do/animate_do.dart';
import 'package:bridgestate/state/bridge_builder.dart';
import 'package:bridgestate/state/bridge_state/bridge_methods.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:flutter/material.dart';
import 'package:grateful_notes/core/utilities/colors.dart';
import 'package:grateful_notes/core/utilities/navigator.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_flat_button.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/global/generic/flower_backdrop.dart';
import 'package:lottie/lottie.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key, required this.errorMessage}) : super(key: key);
  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);

    return BounceInDown(
      child: BridgeBuilder(
        controllers: const [],
        dispose: true,
        child: FlowerBackdrop(
            color: AppColors.deepRed,
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
                        child: LottieBuilder.network(
                          'https://assets5.lottiefiles.com/packages/lf20_ddxv3rxw.json',
                          height: 70,
                        ),
                      ),
                      const YSpace(12),
                      Center(
                        child: CustomText(
                          errorMessage,
                          size: 20,
                          align: TextAlign.center,
                          color: Colors.white,
                          height: 1.3,
                        ),
                      ),
                      const YSpace(20),
                      CustomFlatButton(
                          label: "Retry", onTap: () => Navigate.pop())
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
