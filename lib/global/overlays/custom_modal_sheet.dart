import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grateful_notes/core/utilities/navigator.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/main.dart';

class CustomOverlays {
  showPopup(child) {
    showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) {
          return child;
        });
  }

  showSheet(
      {required double height,
      required Color color,
      required child,
      bool popPrevious = false}) {
    if (popPrevious) Navigate.pop();
    showModalBottomSheet(
      isScrollControlled: true,
      context: navigatorKey.currentContext!,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: BounceInUp(
                child: Container(
                  height: height.h,
                  color: color,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 18.w),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                                onPressed: () => Navigate.pop(),
                                icon: const Icon(Icons.close)),
                          ),
                        ),
                        const YSpace(45),
                        child,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
