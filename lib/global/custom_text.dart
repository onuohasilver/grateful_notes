import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText(this.text,
      {Key? key,
      required this.size,
      this.weight = FontWeight.normal,
      this.height = 1,
      this.color = Colors.black,
      this.align = TextAlign.left,
      this.isMoney = false,
      this.overflow,
      this.fontStyle,
      this.animate = false})
      : super(key: key);
  final String text;
  final num size;
  final double height;
  final FontWeight weight;
  final Color color;
  final TextAlign align;
  final TextOverflow? overflow;
  final FontStyle? fontStyle;
  final bool isMoney;
  final bool animate;
  @override
  Widget build(BuildContext context) {
    return !animate
        ? Text(text,
            textAlign: align,
            style: GoogleFonts.inconsolata(
                fontSize: size.sp,
                fontWeight: weight,
                color: color,
                height: height))
        : AnimatedTextKit(
            isRepeatingAnimation: false,
            animatedTexts: [
              TypewriterAnimatedText(text,
                  textStyle: GoogleFonts.inconsolata(
                      fontSize: size.sm,
                      fontWeight: weight,
                      color: color,
                      height: height),
                  speed: const Duration(milliseconds: 100)),
            ],
          );
  }
}
