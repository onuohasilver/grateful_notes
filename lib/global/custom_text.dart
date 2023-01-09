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
      this.animate = false,
      this.decoration})
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
  final TextDecoration? decoration;
  @override
  Widget build(BuildContext context) {
    return !animate
        ? Text(text,
            textAlign: align,
            style: GoogleFonts.inconsolata(
                fontSize: size.sp,
                fontWeight: weight,
                decoration: decoration,
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

// Places a stroke around text to make it appear outlined
///
/// Adapted from https://stackoverflow.com/a/55559435/11846040
class OutlinedText extends StatelessWidget {
  /// Text to display
  final String text;

  /// Original text style (if you weren't outlining)
  ///
  /// Do not specify `color` inside this: use [textColor] instead.
  final TextStyle style;

  /// Text color
  final Color textColor;

  /// Outline stroke color
  final Color strokeColor;

  /// Outline stroke width
  final double strokeWidth;

  /// Places a stroke around text to make it appear outlined
  ///
  /// Adapted from https://stackoverflow.com/a/55559435/11846040
  const OutlinedText(
    this.text, {
    Key? key,
    this.style = const TextStyle(),
    required this.textColor,
    required this.strokeColor,
    required this.strokeWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: style.copyWith(foreground: Paint()..color = textColor),
        ),
        Text(
          text,
          style: style.copyWith(
            foreground: Paint()
              ..strokeWidth = strokeWidth
              ..color = strokeColor
              ..style = PaintingStyle.stroke,
          ),
        ),
      ],
    );
  }
}
