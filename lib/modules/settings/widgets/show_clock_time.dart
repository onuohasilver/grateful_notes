import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grateful_notes/core/asset_files.dart';
import 'package:grateful_notes/core/utilities/navigator.dart';
import 'package:grateful_notes/global/overlays/custom_modal_sheet.dart';
import 'package:grateful_notes/modules/settings/controllers/settings_controller.dart';
import 'package:grateful_notes/modules/settings/controllers/settings_variables.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';

Widget showTime(SettingsVariables sv, SettingsController sc, frequency,
    [String? dayOfWeek]) {
  return Container();
  // return createInlinePicker(
  //     value: TimeOfDay(
  //         hour: sv.reminderFrequency.hour, minute: sv.reminderFrequency.minute),
  //     onChange: (_) {
  //       Logger().i(_);
  //       sc.setReminderFrequency(frequency, timeOfDay: _, dayOfWeek: dayOfWeek);
  //     },
  //     elevation: 0,
  //     is24HrFormat: true,
  //     buttonsSpacing: 12.w,
  //     buttonStyle: ButtonStyle(
  //         minimumSize: MaterialStateProperty.all(Size(130.w, 48.h)),
  //         side: MaterialStateProperty.all(
  //             const BorderSide(color: Colors.grey, width: 2)),
  //         splashFactory: NoSplash.splashFactory,
  //         backgroundColor: MaterialStateProperty.all(Colors.white)),
  //     accentColor: Colors.black,
  //     onCancel: () => {
  //           CustomOverlays().showSheet(
  //               height: 350,
  //               color: Colors.white,
  //               child: SizedBox(
  //                 width: double.infinity,
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     LottieBuilder.asset(
  //                       const AnimationAssets().done,
  //                       height: 100,
  //                     ),
  //                     Padding(
  //                       padding: EdgeInsets.symmetric(horizontal: 15.0.w),
  //                       child: TextButton(
  //                           child: Text("Back to home",
  //                               style: GoogleFonts.inconsolata(
  //                                   color: Colors.black,
  //                                   decoration: TextDecoration.underline)),
  //                           onPressed: () {
  //                             if (sv.reminderFrequency.frequency == "Weekly") {
  //                               Navigate.pop(number: 5);
  //                             } else {
  //                               Navigate.pop(number: 4);
  //                             }
  //                           }),
  //                     )
  //                   ],
  //                 ),
  //               ))
  //           // Navigate.pop(),
  //         },

  //     // iosStylePicker: true,
  //     borderRadius: 0);
}
