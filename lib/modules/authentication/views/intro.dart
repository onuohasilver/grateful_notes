import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grateful_notes/core/asset_files.dart';
import 'package:grateful_notes/core/utilities/navigator.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/modules/authentication/views/have_an_account.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Positioned.fill(
                top: 83.h, child: Image.asset(const ImageAssets().flower)),
            Positioned(
              top: 597.h,
              left: 201.w,
              child: GestureDetector(
                onTap: () => Navigate.to(const HaveAnAccount()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Pulse(
                      infinite: true,
                      child: SvgPicture.asset(const IconAssets().target),
                    ),
                    const YSpace(10),
                    const CustomText("Tap here", size: 8, color: Colors.white)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
