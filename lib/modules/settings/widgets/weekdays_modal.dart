import 'package:bridgestate/bridges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_flat_button.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/global/overlays/custom_modal_sheet.dart';
import 'package:grateful_notes/modules/settings/controllers/settings_controller.dart';
import 'package:grateful_notes/modules/settings/controllers/settings_variables.dart';
import 'package:grateful_notes/modules/settings/widgets/show_clock_time.dart';

class WeeklyFrequencyModal extends StatelessWidget {
  const WeeklyFrequencyModal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);
    // SettingsInputs si = SettingsInputs(state);
    SettingsController sc = SettingsController(state);
    SettingsVariables sv = SettingsVariables(state);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: const CustomText(
            "Which day of the week\nare you thinking about?",
            size: 18,
            weight: FontWeight.bold,
            height: 1.5,
          ),
        ),
        const YSpace(24),
        ...days
            .map(
              (e) => Padding(
                padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.h),
                child: CustomFlatButton(
                  label: e,
                  alignment: MainAxisAlignment.start,
                  onTap: () => CustomOverlays().showSheet(
                    height: 560,
                    color: Colors.white,
                    // child: const WeeklyFrequencyModal(),
                    child: showTime(sv, sc, "Weekly", e),
                  ),
                  hasBorder: true,
                  expand: true,
                ),
              ),
            )
            .toList()
      ],
    );
  }
}

List<String> days = [
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday"
];
