import 'package:bridgestate/bridges.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grateful_notes/core/utilities/colors.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/global/overlays/custom_modal_sheet.dart';
import 'package:grateful_notes/modules/authentication/controllers/auth_input.dart';
import 'package:grateful_notes/modules/authentication/widgets/enter_password.dart';

class EnterEmail extends StatelessWidget {
  const EnterEmail({
    Key? key,
    this.label = "and your Email\naddress?",
  }) : super(key: key);
  final String label;
  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);
    AuthInputs ai = AuthInputs(state);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 33),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(label, size: 34, color: Colors.white),
          const YSpace(31),
          TextField(
            onChanged: (value) => ai.onEmailChanged(value),
            style: GoogleFonts.inconsolata(color: Colors.white),
          ),
          const YSpace(250),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
                onPressed: () => CustomOverlays().showSheet(
                    height: 603,
                    color: AppColors.chatreuse,
                    child: EnterPassword(
                        label: label.contains("and your")
                            ? "add 6 secret letters for your password"
                            : "and your password?")),
                icon: const Icon(Icons.arrow_forward)),
          )
        ],
      ),
    );
  }
}
