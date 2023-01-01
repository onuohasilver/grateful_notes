import 'package:bridgestate/bridges.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grateful_notes/core/utilities/colors.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/modules/authentication/controllers/auth_controller.dart';
import 'package:grateful_notes/modules/authentication/controllers/auth_input.dart';
import 'package:grateful_notes/modules/authentication/controllers/auth_variables.dart';

class EnterPassword extends StatelessWidget {
  const EnterPassword({
    Key? key,
    this.label = "add 6 secret letters for your password",
  }) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);
    AuthInputs ai = AuthInputs(state);
    AuthController ac = AuthController(state);
    AuthVariables av = AuthVariables(state);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 33),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(label, size: 20, color: Colors.white),
          const YSpace(31),
          TextField(
            keyboardType: TextInputType.visiblePassword,
            autofocus: true,
            obscureText: true,
            style: GoogleFonts.inconsolata(color: Colors.white),
            onChanged: (value) => ai.onPasswordChanged(value),
          ),
          const YSpace(250),
          Align(
            alignment: Alignment.bottomRight,
            child: Visibility(
              visible: av.password.length >= 6,
              child: IconButton(
                  onPressed: () =>
                      {label.contains('secret') ? ac.signup() : ac.signin()},
                  icon: const Icon(Icons.arrow_forward)),
            ),
          )
        ],
      ),
    );
  }
}

List<Color> signUpColors = [
  AppColors.green,
  AppColors.yellowGreen,
  AppColors.greyGreen,
  AppColors.chatreuse
];

List<String> signUpTexts = [
  "Spinning up your account",
  "We are grateful to have you",
  "The little things matter",
  "Moments are beautiful"
];
List<Color> signInColors = [
  AppColors.green,
  AppColors.greyGreen,
  AppColors.yellowGreen,
  AppColors.chatreuse
];

List<String> signInTexts = [
  "Getting all your grateful moments",
  "Welcoming you back to your awesomeness",
  "The little things matter",
  "We are happy you came back"
];
