import 'package:bridgestate/state/bridge_state/bridge_methods.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:flutter/material.dart';
import 'package:grateful_notes/core/utilities/colors.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/global/overlays/custom_modal_sheet.dart';
import 'package:grateful_notes/modules/authentication/controllers/auth_input.dart';
import 'package:grateful_notes/modules/authentication/widgets/enter_email.dart';

class EnterName extends StatelessWidget {
  const EnterName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);
    AuthInputs ai = AuthInputs(state);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 33),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText("What's your\nname?", size: 34, color: Colors.white),
          const YSpace(31),
          TextField(onChanged: (value) => ai.onUsernameChanged(value)),
          const YSpace(250),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
                onPressed: () => CustomOverlays().showSheet(
                    height: 603,
                    color: AppColors.purple,
                    child: const EnterEmail()),
                icon: const Icon(Icons.arrow_forward)),
          )
        ],
      ),
    );
  }
}
