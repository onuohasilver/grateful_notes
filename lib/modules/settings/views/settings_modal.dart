import 'package:animate_do/animate_do.dart';
import 'package:bridgestate/bridges.dart';
import 'package:flutter/material.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_flat_button.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/global/overlays/custom_modal_sheet.dart';
import 'package:grateful_notes/modules/authentication/controllers/auth_controller.dart';
import 'package:grateful_notes/modules/circles/controllers/circle_controller.dart';
import 'package:grateful_notes/modules/circles/views/close_circle_modal.dart';
import 'package:grateful_notes/modules/settings/controllers/settings_variables.dart';
import 'package:grateful_notes/modules/settings/views/privacy_modal.dart';
import 'package:grateful_notes/modules/settings/views/reminder_frequency_modal.dart';

class SettingsModal extends StatelessWidget {
  const SettingsModal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);
    AuthController ac = AuthController(state);
    SettingsVariables sv = SettingsVariables(state);
    CircleController cc = CircleController(state);
    return BridgeBuilder(
      controllers: [cc],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText("More", size: 18, weight: FontWeight.bold),
            const YSpace(24),
            ElasticIn(
              child: CustomFlatButton(
                  alignment: MainAxisAlignment.spaceBetween,
                  label: "Set Reminder Frequency",
                  hasBorder: true,
                  expand: true,
                  suffix: CustomText(
                    sv.reminderFrequency.frequency,
                    size: 12,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    CustomOverlays().showSheet(
                      height: 450,
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
                    CustomOverlays().showSheet(
                      height: 550,
                      color: Colors.white,
                      child: const CloseCircleModal(),
                    );
                  }),
            ),
            const YSpace(12),
            ElasticInRight(
              child: CustomFlatButton(
                  alignment: MainAxisAlignment.spaceBetween,
                  label: "Set Privacy",
                  hasBorder: true,
                  expand: true,
                  suffix: CustomText(
                    sv.privacy,
                    size: 12,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    CustomOverlays().showSheet(
                      height: 400,
                      color: Colors.white,
                      child: const PrivacyModal(),
                    );
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
      ),
    );
  }
}
