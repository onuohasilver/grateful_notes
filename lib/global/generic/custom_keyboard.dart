import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_flat_button.dart';
import 'package:grateful_notes/global/custom_text.dart';

class CustomKeyboard extends StatelessWidget {
  const CustomKeyboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: const BoxDecoration(
        color: Colors.white54,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [...row0.map((e) => KeyboardButton(e))],
          ),
          const YSpace(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [...row1.map((e) => KeyboardButton(e))],
          ),
          const YSpace(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [...row2.map((e) => KeyboardButton(e))],
          ),
          const YSpace(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(5),
                child: CustomFlatButton(label: "space", onTap: () {}),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class KeyboardButton extends StatelessWidget {
  const KeyboardButton(
    this.letter, {
    Key? key,
  }) : super(key: key);
  final String letter;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(5),
      elevation: 5,
      child: SizedBox(
        width: 35.w,
        height: 40.w,
        child: Center(child: CustomText(letter, size: 18)),
      ),
    );
  }
}

List<String> row0 = ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'];
List<String> row1 = ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'];
List<String> row2 = ['⇧', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'DEL'];
