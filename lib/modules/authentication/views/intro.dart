import 'package:animate_do/animate_do.dart';
import 'package:bridgestate/state/bridge_builder.dart';
import 'package:bridgestate/state/bridge_state/bridge_methods.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grateful_notes/core/asset_files.dart';
import 'package:grateful_notes/core/utilities/navigator.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/modules/authentication/controllers/auth_controller.dart';
import 'package:grateful_notes/modules/authentication/controllers/auth_variables.dart';
import 'package:grateful_notes/modules/authentication/views/have_an_account.dart';
import 'package:grateful_notes/modules/recaps/controllers/recap_controller.dart';
import 'package:grateful_notes/modules/settings/controllers/settings_controller.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);
    AuthVariables av = AuthVariables(state);
    AuthController ac = AuthController(state);
    SettingsController sc = SettingsController(state);
    RecapController rc = RecapController(state);
    return BridgeBuilder(
      controllers: [ac, sc, rc],
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Positioned.fill(
                  top: 283.h, child: Image.asset(const ImageAssets().flower)),
              Positioned.fill(
                  top: 187.h,
                  left: 111.w,
                  child: ElasticIn(
                    child: Flash(
                      infinite: true,
                      delay: const Duration(milliseconds: 300),
                      child: const CustomText(
                        'H A P P Y\nN O T E S',
                        size: 34,
                      ),
                    ),
                  )),
              if (av.returningUser == "New")
                Positioned(
                  top: 597.h,
                  left: 201.w,
                  child: GestureDetector(
                    onTap: () => Navigate.to(const HaveAnAccount()),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Pulse(
                          infinite: true,
                          child: SvgPicture.asset(const IconAssets().target),
                        ),
                        const YSpace(10),
                        const CustomText("Tap here",
                            size: 8, color: Colors.white)
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
