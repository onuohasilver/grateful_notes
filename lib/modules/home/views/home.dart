import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:bridgestate/bridges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grateful_notes/core/asset_files.dart';
import 'package:grateful_notes/core/utilities/colors.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/global/display/state_aware_builder.dart';
import 'package:grateful_notes/global/generic/flower_backdrop.dart';
import 'package:grateful_notes/global/overlays/custom_modal_sheet.dart';
import 'package:grateful_notes/modules/circles/controllers/circle_controller.dart';
import 'package:grateful_notes/modules/gratitudes/controllers/gratitude_controller.dart';
import 'package:grateful_notes/modules/gratitudes/controllers/gratitude_variables.dart';
import 'package:grateful_notes/modules/gratitudes/views/add_new_gratitude.dart';
import 'package:grateful_notes/modules/home/controllers/home_inputs.dart';
import 'package:grateful_notes/modules/home/controllers/home_variables.dart';
import 'package:grateful_notes/modules/home/data/circle_enum.dart';
import 'package:grateful_notes/modules/home/widgets/date_button.dart';
import 'package:grateful_notes/modules/home/widgets/my_circles_notes.dart';
import 'package:grateful_notes/modules/home/widgets/my_notes.dart';
import 'package:grateful_notes/modules/home/widgets/recap_available_button.dart';
import 'package:grateful_notes/modules/settings/views/settings_modal.dart';
import 'package:grateful_notes/modules/user/controllers/user_controller.dart';
import 'package:grateful_notes/modules/user/controllers/user_variables.dart';
import 'package:lottie/lottie.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class Home extends StatelessWidget {
  final GroupedItemScrollController isc = GroupedItemScrollController();
  final GroupedItemScrollController isc1 = GroupedItemScrollController();

  final ScrollController lsc = ScrollController();
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);
    UserVariables uv = UserVariables(state);
    GratitudeController gc = GratitudeController(state);
    GratitudeVariables gv = GratitudeVariables(state);

    CircleController cc = CircleController(state);
    UserController uc = UserController(state);
    HomeInputs hi = HomeInputs(state);
    HomeVariables hv = HomeVariables(state);

    return BridgeBuilder(
      controllers: [gc, cc],
      initMethods: [
        () => lsc.jumpTo(
              -68.0 * DateTime(2023).difference(DateTime.now()).inDays,
            )
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FadeInRightBig(
          child: FloatingActionButton.extended(
              // onPressed: () => uc.findUser("dev@gmail.com"),
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
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const YSpace(67),
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
                              child: const SettingsModal()),
                          child: Icon(
                            Icons.settings,
                            size: 24.h,
                          ),
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
                  controller: lsc,
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
                        }
                        if (gv.allCircleGratitudes.any((gem) => DateTime(
                                gem.date.year, gem.date.month, gem.date.day)
                            .isAtSameMomentAs(
                                DateTime(2023).add(Duration(days: index))))) {
                          isc1.scrollToElement(
                              identifier:
                                  DateTime(2023).add(Duration(days: index)),
                              duration: const Duration(seconds: 1));
                        }
                      }),
                ),
              )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () =>
                            hi.onCurrentViewChanged(CurrentView.myNotes),
                        child: CustomText(
                          "My Notes",
                          weight: hv.currentView == CurrentView.myNotes
                              ? FontWeight.bold
                              : FontWeight.normal,
                          size: 12,
                          decoration: hv.currentView == CurrentView.myNotes
                              ? TextDecoration.underline
                              : null,
                        )),
                    TextButton(
                        onPressed: () =>
                            hi.onCurrentViewChanged(CurrentView.myCircle),
                        child: CustomText(
                          "My Circle",
                          weight: hv.currentView == CurrentView.myCircle
                              ? FontWeight.bold
                              : FontWeight.normal,
                          size: 12,
                          decoration: hv.currentView == CurrentView.myCircle
                              ? TextDecoration.underline
                              : null,
                        ))
                  ],
                ),
              ),
              StateAwareBuilder(
                currentState: gv.currentState,
                error: const Center(
                    child: CustomText("An error occured", size: 12)),
                loading: Expanded(
                  child: Center(
                    child: LottieBuilder.asset(
                      const AnimationAssets().loading,
                      height: 300,
                    ),
                  ),
                ),
                done: hv.currentView == CurrentView.myNotes
                    ? MyNotes(gv: gv, isc: isc)
                    : MyCircleNotes(isc: isc1),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class KamelToast {
//   KamelToast();

//   static error(String message) async {
//     BuildContext context = navigatorKey.currentContext!;
//     OverlayEntry overlayEntry;

//     overlayEntry = OverlayEntry(
//         builder: (context) => Container(
//               key: UniqueKey(),
//               child: const Text("data"),
//             ));
// // check if widget with key 'error_toast' exists in the widget tree
//     Logger().i(overlayEntry);
//     Overlay.of(context)?.insert(overlayEntry);

//     Timer(const Duration(seconds: 3), () => overlayEntry.remove());
//   }
// }
