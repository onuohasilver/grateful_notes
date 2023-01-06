import 'package:animate_do/animate_do.dart';
import 'package:bridgestate/state/bridge_state/bridge_methods.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_flat_button.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/global/overlays/custom_modal_sheet.dart';
import 'package:grateful_notes/modules/settings/controllers/settings_controller.dart';
import 'package:grateful_notes/modules/settings/controllers/settings_variables.dart';
import 'package:grateful_notes/modules/settings/widgets/show_clock_time.dart';
import 'package:grateful_notes/modules/settings/widgets/weekdays_modal.dart';

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
                              child: showTime(sv, sc, 'Daily'))
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
                    onTap: () => CustomOverlays().showSheet(
                          height: 650,
                          color: Colors.white,
                          child: const WeeklyFrequencyModal(),
                        ),
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
                    onTap: () => CustomOverlays().showSheet(
                        height: 500,
                        color: Colors.white,
                        child: showTime(sv, sc, "Monthly")),
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
