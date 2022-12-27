import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grateful_notes/core/asset_files.dart';

class FlowerBackdrop extends StatelessWidget {
  const FlowerBackdrop(
      {super.key, required this.child, required this.color, this.filter});
  final Widget child;
  final Color color;
  final ImageFilter? filter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: color,
        body: Stack(
          children: [
            Positioned.fill(
                left: 122.w,
                top: 300.h,
                child: Image.asset(const ImageAssets().flower)),
            BackdropFilter(
              filter: filter ?? ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: child,
            )
          ],
        ));
  }
}
