import 'package:animate_do/animate_do.dart';
import 'package:bridgestate/bridges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:grateful_notes/core/asset_files.dart';
import 'package:grateful_notes/core/utilities/navigator.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/global/overlays/custom_modal_sheet.dart';
import 'package:grateful_notes/modules/gratitudes/controllers/gratitude_controller.dart';
import 'package:grateful_notes/modules/gratitudes/controllers/gratitude_variables.dart';
import 'package:grateful_notes/modules/gratitudes/data/gratitude_edit_model.dart';
import 'package:grateful_notes/modules/gratitudes/views/share_gratitude.dart';
import 'package:grateful_notes/modules/home/widgets/gratitude_display_card.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class MyNotes extends StatelessWidget {
  const MyNotes({
    Key? key,
    required this.gv,
    required this.isc,
  }) : super(key: key);

  final GratitudeVariables gv;
  final GroupedItemScrollController isc;

  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);
    GratitudeController gc = GratitudeController(state);

    return Expanded(
      flex: 8,
      child: gv.allGratitudes.isEmpty
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
                      "You don't have any happy notes yet",
                      size: 18,
                    ),
                  ),
                ],
              ),
            )
          : StickyGroupedListView(
              itemScrollController: isc,
              order: StickyGroupedListOrder.DESC,
              physics: const BouncingScrollPhysics(),
              elements: gv.allGratitudes.reversed.toList(),
              elementIdentifier: (GratitudeEditModel gem) => gem.date,
              groupBy: (GratitudeEditModel gem) =>
                  DateTime(gem.date.year, gem.date.month, gem.date.day),
              padding: EdgeInsets.zero,
              groupSeparatorBuilder: (GratitudeEditModel gem) => Padding(
                padding: EdgeInsets.only(left: 15.w, top: 15.h, bottom: 15.h),
                child: CustomText(DateFormat.yMMMMEEEEd().format(gem.date),
                    size: 16, weight: FontWeight.bold),
              ),
              itemBuilder: (context, GratitudeEditModel gem) => ElasticIn(
                duration:
                    Duration(milliseconds: 100 * gv.allGratitudes.indexOf(gem)),
                child: Slidable(
                  // key: const ValueKey(0),
                  endActionPane: ActionPane(
                    // A motion is a widget used to control how the pane animates.
                    motion: const ScrollMotion(),

                    children: [
                      SlidableAction(
                        onPressed: (context) => {
                          gc.updateGratitude(gem.copyWith(
                              privacy: gem.privacy == "Private"
                                  ? "Open"
                                  : "Private")),
                          CustomOverlays().showSnackBar(
                              "Privacy changed to ${gem.privacy == "Private" ? "Open" : "Private"}")
                        },
                        backgroundColor: Colors.white,
                        foregroundColor: colorMapper(gem.type),
                        icon: Icons.visibility_outlined,
                        label: gem.privacy == "Private" ? "Open" : "Private",
                      ),
                    ],
                  ),
                  // The start action pane is the one at the left or the top side.
                  startActionPane: ActionPane(
                    // A motion is a widget used to control how the pane animates.
                    motion: const ScrollMotion(),

                    children: [
                      SlidableAction(
                        onPressed: (context) => {
                          CustomOverlays().showSnackBar("Deleting..",
                              duration: const Duration(milliseconds: 1400)),
                          gc.updateGratitude(gem.copyWith(delete: true))
                        },
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.red,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                      SlidableAction(
                        onPressed: (_) => Navigate.to(
                          ShareGratitude(gem: gem),
                        ),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        icon: Icons.share,
                        label: 'Share',
                      ),
                    ],
                  ),
                  child: GratitudeDisplayCard(
                    gem: gem,
                  ),
                ),
              ),
            ),
    );
  }
}
