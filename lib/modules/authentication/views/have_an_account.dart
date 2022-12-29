import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:grateful_notes/core/utilities/colors.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_flat_button.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/global/generic/flower_backdrop.dart';
import 'package:grateful_notes/global/overlays/custom_modal_sheet.dart';
import 'package:grateful_notes/modules/authentication/widgets/enter_email.dart';
import 'package:grateful_notes/modules/authentication/widgets/enter_name.dart';

class HaveAnAccount extends StatelessWidget {
  const HaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowerBackdrop(
        color: AppColors.lemon,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const YSpace(304),
                  const CustomText("Do you have \nan account?",
                      animate: true,
                      size: 20,
                      color: Colors.white,
                      height: 1.3),
                  const YSpace(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BounceInUp(
                          delay: const Duration(milliseconds: 100),
                          child: CustomFlatButton(
                            label: 'Yes',
                            onTap: () {
                              CustomOverlays().showSheet(
                                  height: 603,
                                  color: AppColors.lightBlue,
                                  child: const EnterEmail(
                                    label: "What’s your email\naddress?",
                                  ));
                            },
                          )),
                      BounceInLeft(
                        delay: const Duration(milliseconds: 100),
                        child: CustomFlatButton(
                          label: 'No',
                          onTap: () {
                            CustomOverlays().showSheet(
                                height: 603,
                                color: AppColors.lightBlue,
                                child: const EnterName());
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const YSpace(40),
            // const CustomKeyboard()
          ],
        ));
  }
}
