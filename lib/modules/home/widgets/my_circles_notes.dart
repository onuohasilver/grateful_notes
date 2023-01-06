import 'package:animate_do/animate_do.dart';
import 'package:bridgestate/bridges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grateful_notes/core/asset_files.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/modules/gratitudes/controllers/gratitude_variables.dart';
import 'package:grateful_notes/modules/gratitudes/data/gratitude_edit_model.dart';
import 'package:grateful_notes/modules/home/widgets/gratitude_display_card.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class MyCircleNotes extends StatelessWidget {
  const MyCircleNotes({
    Key? key,
    required this.isc,
  }) : super(key: key);

  final GroupedItemScrollController isc;

  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);

    GratitudeVariables gv = GratitudeVariables(state);

    return Expanded(
      flex: 8,
      child: gv.allCircleGratitudes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottieBuilder.asset(const AnimationAssets().write,
                      height: 90, width: 90),
                  Flash(
                    infinite: true,
                    duration: const Duration(seconds: 10),
                    child: const CustomText(
                      "No shared happy notes from your circle",
                      size: 18,
                    ),
                  ),
                ],
              ),
            )
          :
          // CustomText(gv.allCircleGratitudes.toString(), size: 12)
          StickyGroupedListView(
              itemScrollController: isc,
              order: StickyGroupedListOrder.DESC,
              physics: const ClampingScrollPhysics(),
              elements: gv.allCircleGratitudes.reversed.toList(),
              elementIdentifier: (GratitudeEditModel gem) => gem.date,
              groupBy: (GratitudeEditModel gem) =>
                  DateTime(gem.date.year, gem.date.month, gem.date.day),
              // gem.date,
              padding: EdgeInsets.zero,
              groupSeparatorBuilder: (GratitudeEditModel gem) => Padding(
                padding: EdgeInsets.only(left: 15.w, top: 15.h, bottom: 15.h),
                child: CustomText(DateFormat.yMMMMEEEEd().format(gem.date),
                    size: 16, weight: FontWeight.bold),
              ),
              itemBuilder: (context, GratitudeEditModel gem) => ElasticIn(
                duration: Duration(
                    milliseconds: 100 * gv.allCircleGratitudes.indexOf(gem)),
                child: GratitudeDisplayCard(gem: gem),
              ),
            ),
    );
  }
}
