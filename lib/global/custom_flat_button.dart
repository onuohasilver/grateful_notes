import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grateful_notes/global/custom_text.dart';

class CustomFlatButton extends StatelessWidget {
  const CustomFlatButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.hasBorder = false,
    this.icon,
    this.expand = false,
    this.alignment,
    this.color,
    this.bgColor,
    this.suffix,
  }) : super(key: key);
  final String label;
  final String? icon;
  final MainAxisAlignment? alignment;
  final bool hasBorder, expand;
  final Color? color, bgColor;
  final Function() onTap;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(153, 48)),
          shape: MaterialStateProperty.all(const RoundedRectangleBorder()),
          side: hasBorder
              ? MaterialStateProperty.all(
                  const BorderSide(color: Colors.grey, width: 2))
              : null,
          splashFactory: NoSplash.splashFactory,
          backgroundColor: MaterialStateProperty.all(bgColor ?? Colors.white)),
      child: Row(
        mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: alignment ??
            (expand ? MainAxisAlignment.center : MainAxisAlignment.start),
        children: [
          CustomText(label, size: 14, color: color ?? Colors.black),
          if (suffix != null) suffix!,
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SvgPicture.asset(icon!),
            )
        ],
      ),
    );
  }
}
