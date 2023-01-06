import 'package:bridgestate/state/bridge_state/bridge_methods.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:flutter/material.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_flat_button.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/modules/settings/controllers/settings_controller.dart';
import 'package:grateful_notes/modules/settings/controllers/settings_variables.dart';

class PrivacyModal extends StatelessWidget {
  const PrivacyModal({Key? key, PrivacyModal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);
    SettingsVariables sv = SettingsVariables(state);
    SettingsController sc = SettingsController(state);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            "Privacy",
            size: 18,
            weight: FontWeight.bold,
            height: 1.5,
          ),
          const YSpace(12),
          const CustomText(
              "Your notes will default to the privacy selection you choose",
              height: 1.4,
              size: 14),
          const YSpace(24),
          CustomFlatButton(
              label: "Open",
              onTap: () => sc.setPrivacy("Open"),
              hasBorder: true,
              expand: true,
              suffix: Visibility(
                visible: sv.privacy == "Open",
                child: const Icon(Icons.check, color: Colors.black),
              ),
              alignment: MainAxisAlignment.spaceBetween),
          const YSpace(24),
          CustomFlatButton(
              label: "Private",
              onTap: () => sc.setPrivacy("Private"),
              suffix: Visibility(
                visible: sv.privacy == "Private",
                child: const Icon(Icons.check, color: Colors.black),
              ),
              hasBorder: true,
              expand: true,
              alignment: MainAxisAlignment.spaceBetween),
          const YSpace(24),
        ],
      ),
    );
  }
}
