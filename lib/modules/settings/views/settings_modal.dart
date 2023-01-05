import 'package:animate_do/animate_do.dart';
import 'package:bridgestate/bridges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_flat_button.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/global/overlays/custom_modal_sheet.dart';
import 'package:grateful_notes/modules/authentication/controllers/auth_controller.dart';
import 'package:grateful_notes/modules/settings/views/reminder_frequency_modal.dart';

class SettingsModal extends StatelessWidget {
  const SettingsModal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);
    AuthController ac = AuthController(state);
    // SettingsInputs si = SettingsInputs(state);
    // SettingsVariables sv = SettingsVariables(state);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText("More", size: 18, weight: FontWeight.bold),
          const YSpace(24),
          ElasticIn(
            child: CustomFlatButton(
                alignment: MainAxisAlignment.start,
                label: "Set Reminder Frequency",
                hasBorder: true,
                expand: true,
                onTap: () {
                  CustomOverlays().showSheet(
                    height: 380.h,
                    color: Colors.white,
                    child: const ReminderFrequencyModal(),
                  );
                }),
          ),
          const YSpace(12),
          ElasticInLeft(
            child: CustomFlatButton(
                alignment: MainAxisAlignment.start,
                label: "Set My Close Circle",
                hasBorder: true,
                expand: true,
                onTap: () {
                  ac.logout();
                }),
          ),
          const YSpace(12),
          ElasticInRight(
            child: CustomFlatButton(
                alignment: MainAxisAlignment.start,
                label: "Set Privacy",
                hasBorder: true,
                expand: true,
                onTap: () {
                  ac.logout();
                }),
          ),
          const YSpace(12),
          ElasticInLeft(
            child: CustomFlatButton(
                alignment: MainAxisAlignment.start,
                label: "Logout",
                hasBorder: true,
                expand: true,
                color: Colors.red,
                onTap: () {
                  ac.logout();
                }),
          )
        ],
      ),
    );
  }
}
