import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:bridgestate/bridges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grateful_notes/core/asset_files.dart';
import 'package:grateful_notes/core/utilities/colors.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_flat_button.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/global/display/state_aware_builder.dart';
import 'package:grateful_notes/global/generic/flower_backdrop.dart';
import 'package:grateful_notes/global/overlays/custom_modal_sheet.dart';
import 'package:grateful_notes/modules/gratitudes/controllers/gratitude_controller.dart';
import 'package:grateful_notes/modules/gratitudes/controllers/gratitude_variables.dart';
import 'package:grateful_notes/modules/gratitudes/data/gratitude_edit_model.dart';
import 'package:grateful_notes/modules/gratitudes/views/add_new_gratitude.dart';
import 'package:grateful_notes/modules/home/widgets/date_button.dart';
import 'package:grateful_notes/modules/home/widgets/gratitude_display_card.dart';
import 'package:grateful_notes/modules/home/widgets/recap_available_button.dart';
import 'package:grateful_notes/modules/user/controllers/user_variables.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class Home extends StatelessWidget {
  final GroupedItemScrollController isc = GroupedItemScrollController();
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);
    UserVariables uv = UserVariables(state);
    GratitudeController gc = GratitudeController(state);
    GratitudeVariables gv = GratitudeVariables(state);

    return BridgeBuilder(
      controllers: [gc],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FadeInRightBig(
          child: FloatingActionButton.extended(
              onPressed: () => CustomOverlays().showSheet(
                    height: 600.h,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const YSpace(53),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CustomText("Hi,", size: 24),
                        CustomText(" ${uv.user?.username}",
                            size: 24, weight: FontWeight.bold),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => CustomOverlays().showSheet(
                            height: 400.h,
                            color: Colors.white,
                            child: const SettingsModal(),
                          ),
                          child: const Icon(Icons.more_vert_rounded),
                        )
                      ],
                    ),
                    const YSpace(8),
                    const CustomText("Gratitude turns what we have into enough",
                        size: 14, color: Colors.grey),
                  ],
                ),
              ),
              const YSpace(8),
              const RecapAvailableButton(),
              const YSpace(12),
              Flexible(
                  child: SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => DateButton(
                      date: DateTime(2023).add(Duration(days: index)),
                      onTap: () {
                        if (gv.allGratitudes.any((gem) => DateTime(
                                gem.date.year, gem.date.month, gem.date.day)
                            .isAtSameMomentAs(
                                DateTime(2023).add(Duration(days: index))))) {
                          isc.scrollToElement(
                              identifier:
                                  DateTime(2023).add(Duration(days: index)),
                              duration: const Duration(seconds: 1));
                        } else {
                          Logger().i("New aa");
                        }
                      }),
                ),
              )),
              const YSpace(15),
              StateAwareBuilder(
                currentState: gv.currentState,
                error: const Center(
                    child: CustomText("An error occured", size: 12)),
                loading: Center(
                  child: LottieBuilder.asset(
                    const AnimationAssets().loading,
                    height: 300,
                  ),
                ),
                done: Expanded(
                  flex: 8,
                  child: StickyGroupedListView(
                    itemScrollController: isc,
                    order: StickyGroupedListOrder.DESC,
                    physics: const ClampingScrollPhysics(),
                    elements: gv.allGratitudes.reversed.toList(),
                    elementIdentifier: (GratitudeEditModel gem) => gem.date,
                    groupBy: (GratitudeEditModel gem) =>
                        DateTime(gem.date.year, gem.date.month, gem.date.day),
                    padding: EdgeInsets.zero,
                    groupSeparatorBuilder: (GratitudeEditModel gem) => Padding(
                      padding:
                          EdgeInsets.only(left: 15.w, top: 15.h, bottom: 15.h),
                      child: CustomText(
                          DateFormat.yMMMMEEEEd().format(gem.date),
                          size: 16,
                          weight: FontWeight.bold),
                    ),
                    itemBuilder: (context, GratitudeEditModel gem) => ElasticIn(
                      duration: Duration(
                          milliseconds: 100 * gv.allGratitudes.indexOf(gem)),
                      child: GratitudeDisplayCard(gem: gem),
                    ),
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

class SettingsModal extends StatelessWidget {
  const SettingsModal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText("Settings", size: 18, weight: FontWeight.bold),
          const YSpace(24),
          ElasticInLeft(
            child: CustomFlatButton(
                alignment: MainAxisAlignment.start,
                label: "Set Reminder Frequency",
                hasBorder: true,
                expand: true,
                onTap: () {
                  CustomOverlays().showSheet(
                    height: 350.h,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                            "How often do you want\nto be reminded to take\nyour happy notes?",
                            size: 18,
                            weight: FontWeight.bold,
                            height: 1.5,
                          ),
                          const YSpace(24),
                          ElasticInLeft(
                            child: CustomFlatButton(
                                label: "Daily",
                                onTap: () {},
                                expand: true,
                                hasBorder: true,
                                alignment: MainAxisAlignment.start),
                          ),
                          const YSpace(12),
                          ElasticInRight(
                            child: CustomFlatButton(
                                label: "Weekly",
                                onTap: () {},
                                expand: true,
                                hasBorder: true,
                                alignment: MainAxisAlignment.start),
                          ),
                          const YSpace(12),
                          ElasticInUp(
                            child: CustomFlatButton(
                                label: "Monthly",
                                onTap: () {},
                                expand: true,
                                hasBorder: true,
                                alignment: MainAxisAlignment.start),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
