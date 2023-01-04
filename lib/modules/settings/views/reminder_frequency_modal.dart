import 'package:animate_do/animate_do.dart';
import 'package:bridgestate/state/bridge_state/bridge_methods.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grateful_notes/core/utilities/navigator.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_flat_button.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/global/overlays/custom_modal_sheet.dart';
import 'package:grateful_notes/modules/settings/controllers/settings_controller.dart';
import 'package:grateful_notes/modules/settings/controllers/settings_variables.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';

class ReminderFrequencyModal extends StatefulWidget {
  const ReminderFrequencyModal({
    Key? key,
  }) : super(key: key);

  @override
  State<ReminderFrequencyModal> createState() => _ReminderFrequencyModalState();
}

class _ReminderFrequencyModalState extends State<ReminderFrequencyModal> {
  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);
    // SettingsInputs si = SettingsInputs(state);
    SettingsController sc = SettingsController(state);
    SettingsVariables sv = SettingsVariables(state);
    return Padding(
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
            child: Stack(
              children: [
                CustomFlatButton(
                    label: "Daily",
                    onTap: () => {
                          CustomOverlays().showSheet(
                              height: 500,
                              color: Colors.white,
                              child: createInlinePicker(
                                  value: TimeOfDay(
                                      hour: sv.reminderFrequency.hour,
                                      minute: sv.reminderFrequency.minute),
                                  onChange: (_) {
                                    Logger().i(_);
                                    sc.setReminderFrequency("Daily",
                                        timeOfDay: _);
                                  },
                                  elevation: 0,
                                  is24HrFormat: true,
                                  buttonsSpacing: 12.w,
                                  buttonStyle: ButtonStyle(
                                      minimumSize: MaterialStateProperty.all(
                                          Size(130.w, 48.h)),
                                      side: MaterialStateProperty.all(
                                          const BorderSide(
                                              color: Colors.grey, width: 2)),
                                      splashFactory: NoSplash.splashFactory,
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white)),
                                  accentColor: Colors.black,
                                  onCancel: () => {
                                        CustomOverlays().showSheet(
                                            height: 350,
                                            color: Colors.white,
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  LottieBuilder.network(
                                                    "https://assets4.lottiefiles.com/temp/lf20_5tgmik.json",
                                                    height: 100,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15.0.w),
                                                    child: TextButton(
                                                        child: Text(
                                                            "Back to home",
                                                            style: GoogleFonts
                                                                .inconsolata(
                                                                    color: Colors
                                                                        .black,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .underline)),
                                                        onPressed: () {
                                                          Navigate.pop(
                                                              number: 4);
                                                        }),
                                                  )
                                                ],
                                              ),
                                            ))
                                        // Navigate.pop(),
                                      },

                                  // iosStylePicker: true,
                                  borderRadius: 0))
                        },
                    expand: true,
                    hasBorder: true,
                    alignment: MainAxisAlignment.start),
                if (sv.reminderFrequency.frequency == "Daily")
                  Align(
                      alignment: Alignment.centerRight,
                      child: BounceInUp(
                        child: Pulse(
                          child: Padding(
                            padding: EdgeInsets.all(8.0.h),
                            child: const Icon(Icons.check),
                          ),
                        ),
                      ))
              ],
            ),
          ),
          const YSpace(12),
          ElasticInRight(
            child: Stack(
              children: [
                CustomFlatButton(
                    label: "Weekly",
                    onTap: () => sc.setReminderFrequency("Weekly"),
                    expand: true,
                    hasBorder: true,
                    alignment: MainAxisAlignment.start),
                if (sv.reminderFrequency.frequency == "Weekly")
                  Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.all(8.0.h),
                        child: const Icon(Icons.check),
                      ))
              ],
            ),
          ),
          const YSpace(12),
          ElasticInUp(
            child: Stack(
              children: [
                CustomFlatButton(
                    label: "Monthly",
                    onTap: () => {
                          sc.setReminderFrequency("Monthly"),
                        },
                    expand: true,
                    hasBorder: true,
                    alignment: MainAxisAlignment.start),
                if (sv.reminderFrequency.frequency == "Monthly")
                  Align(
                      alignment: Alignment.centerRight,
                      child: BounceInDown(
                        child: Padding(
                          padding: EdgeInsets.all(8.0.h),
                          child: const Icon(Icons.check),
                        ),
                      ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
