import 'package:animate_do/animate_do.dart';
import 'package:bridgestate/state/bridge_builder.dart';
import 'package:bridgestate/state/bridge_state/bridge_methods.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:flutter/material.dart';
import 'package:grateful_notes/core/utilities/navigator.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/global/display/success_loading_controller/success_loading_controller.dart';
import 'package:grateful_notes/global/display/success_loading_controller/success_loading_input.dart';
import 'package:grateful_notes/global/display/success_loading_controller/success_loading_variables.dart';
import 'package:grateful_notes/global/generic/flower_backdrop.dart';
import 'package:grateful_notes/modules/home/views/home.dart';
import 'package:lottie/lottie.dart';

class SuccessLoading extends StatelessWidget {
  const SuccessLoading({Key? key, required this.texts, required this.colors})
      : super(key: key);
  final List<String> texts;
  final List<Color> colors;
  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);
    SuccessLoadingController slc = SuccessLoadingController(state);
    SuccessLoadingVariables slv = SuccessLoadingVariables(state);
    SuccessLoadingInput sli = SuccessLoadingInput(state);

    return BounceInDown(
      child: BridgeBuilder(
        controllers: [slc],
        initMethods: [
          () => sli.onTextsChanged(texts),
          () => sli.onColorsChanged(colors),
          () => slc.updateIndex(),
          () => Future.delayed(const Duration(seconds: 5), () {
                Navigate.to(const Home());
                slc.dispose();
              })
        ],
        disposeMethods: [() => slc.dispose()],
        dispose: true,
        child: AnimatedContainer(
          color: slv.colors[slv.index],
          duration: const Duration(seconds: 1),
          child: FlowerBackdrop(
              color: Colors.transparent,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const YSpace(40),
                        LottieBuilder.network(
                          'https://assets8.lottiefiles.com/packages/lf20_lz5srsyo.json',
                          height: 300,
                        ),
                        if (slv.texts.isNotEmpty)
                          Center(
                            child: CustomText(
                              slv.texts[slv.index],
                              // animate: true,
                              key: Key("${slv.texts[slv.index]}${slv.index}"),
                              size: 20,
                              align: TextAlign.center,
                              color: Colors.white,
                              height: 1.3,
                            ),
                          ),
                        const YSpace(20),
                      ],
                    ),
                  ),
                  const YSpace(40),
                  // const CustomKeyboard()
                ],
              )),
        ),
      ),
    );
  }
}
