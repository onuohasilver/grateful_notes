import 'package:animate_do/animate_do.dart';
import 'package:bridgestate/state/bridge_state/bridge_methods.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/modules/home/controllers/home_inputs.dart';
import 'package:grateful_notes/modules/home/controllers/home_variables.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class DateButton extends StatelessWidget {
  const DateButton({
    Key? key,
    required this.date,
    this.onTap,
  }) : super(key: key);

  final DateTime date;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);
    HomeInputs hi = HomeInputs(state);
    HomeVariables hv = HomeVariables(state);
    return GestureDetector(
      onTap: () {
        // Logger().i();
        if (date.isBefore(DateTime.now())) {
          hi.onCurrentDateChanged(date);
          Logger().i(date.toIso8601String());
          onTap?.call();
        }
      },
      child: ElasticIn(
        child: Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: Container(
            height: 40.h,
            width: 50.w,
            decoration: BoxDecoration(
              color: hv.currentDate.isAtSameMomentAs(date)
                  ? Colors.black
                  : Colors.transparent,
              border: hv.currentDate.isAtSameMomentAs(date)
                  ? Border.all()
                  : Border.all(color: Colors.grey.shade500),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  DateFormat('MMM').format(date),
                  size: 12,
                  color: hv.currentDate.isAtSameMomentAs(date)
                      ? Colors.white
                      : Colors.grey.shade400,
                ),
                CustomText(date.day.toString(),
                    size: 16,
                    color: hv.currentDate.isAtSameMomentAs(date)
                        ? Colors.white
                        : Colors.grey.shade400)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
