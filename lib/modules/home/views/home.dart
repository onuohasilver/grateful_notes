import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:bridgestate/state/bridge_state/bridge_methods.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grateful_notes/core/utilities/colors.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/global/generic/flower_backdrop.dart';
import 'package:grateful_notes/global/overlays/custom_modal_sheet.dart';
import 'package:grateful_notes/modules/authentication/controllers/auth_variables.dart';
import 'package:grateful_notes/modules/gratitudes/views/add_new_gratitude.dart';
import 'package:grateful_notes/modules/home/widgets/gratitude_display_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);
    AuthVariables av = AuthVariables(state);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FadeInRightBig(
        child: FloatingActionButton.extended(
            onPressed: () => CustomOverlays().showSheet(
                  height: 700.h,
                  color: AppColors.superLightGreen,
                  child: const AddNewGratitude(),
                ),
            shape: const RoundedRectangleBorder(),
            backgroundColor: Colors.black,
            label: const CustomText("Add New", size: 14, color: Colors.white),
            icon: Roulette(child: const Icon(Icons.add))),
      ),
      body: FlowerBackdrop(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const YSpace(53),
              Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CustomText("Hi,", size: 24),
                        CustomText(
                          " ${av.username}",
                          size: 24,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                    const YSpace(8),
                    const CustomText("Gratitude turns what we have into enough",
                        size: 12, color: Colors.grey),
                  ],
                ),
              ),
              const YSpace(35),
              const GratitudeDisplayCard(),
              const YSpace(12),
              const GratitudeDisplayCard(),
            ],
          ),
        ),
      ),
    );
  }
}
