import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grateful_notes/global/box_sizing.dart';

import '../../../global/custom_text.dart';

class RecapStoryBuilder extends StatelessWidget {
  const RecapStoryBuilder({
    Key? key,
    required this.image,
    required this.text,
    required this.value,
    required this.unit,
    required this.color,
  }) : super(key: key);
  final String image, text, value, unit;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Center(
                child: SizedBox(
                  height: 250,
                  child: Stack(
                    children: [
                      Center(child: Image.asset(image)),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(value,
                                size: 64, weight: FontWeight.bold),
                            CustomText(unit, size: 25, weight: FontWeight.bold),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const YSpace(30),
          SizedBox(
            width: 250.w,
            child: CustomText(text,
                size: 20, height: 1.2, align: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
