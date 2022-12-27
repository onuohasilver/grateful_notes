import 'package:bridgestate/bridges.dart';
import 'package:flutter/material.dart';
import 'package:grateful_notes/core/utilities/colors.dart';
import 'package:grateful_notes/core/utilities/navigator.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/global/display/success_loading.dart';
import 'package:grateful_notes/modules/authentication/controllers/auth_input.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 33),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(label, size: 34, color: Colors.white),
          const YSpace(31),
          TextField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              onChanged: (value) => ai.onPasswordChanged(value),
              textAlign: TextAlign.center),
          const YSpace(250),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
                onPressed: () => Navigate.to(
                      SuccessLoading(
                        texts: label.contains('secret')
                            ? signUpTexts
                            : signInTexts,
                        colors: signUpColors,
                      ),
                    ),
                icon: const Icon(Icons.arrow_forward)),
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
