import 'package:bridgestate/state/bridge_state/bridge_methods.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grateful_notes/core/utilities/colors.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_flat_button.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/global/overlays/custom_modal_sheet.dart';
import 'package:grateful_notes/modules/circles/controllers/circle_controller.dart';
import 'package:grateful_notes/modules/circles/controllers/circle_variable.dart';
import 'package:grateful_notes/modules/circles/data/friend_model.dart';
import 'package:grateful_notes/modules/circles/views/view_circle_modal.dart';

class CloseCircleModal extends StatelessWidget {
  const CloseCircleModal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);
    CircleVariables cv = CircleVariables(state);
    CircleController cc = CircleController(state);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            "My Close Circle",
            size: 18,
            weight: FontWeight.bold,
            height: 1.5,
          ),
          const YSpace(12),
          const CustomText(
              "Your close circle can see the notes that you mark as open",
              height: 1.4,
              size: 14),
          const YSpace(24),
          CustomFlatButton(
              label: "View Circle",
              onTap: () {
                CustomOverlays().showSheet(
                  height: 580.h,
                  color: Colors.white,
                  child: const ViewMyCloseCircleModal(),
                );
              },
              hasBorder: true,
              expand: true,
              alignment: MainAxisAlignment.start)
        ],
      ),
    );
  }
}

class CircleMemberNameButton extends StatelessWidget {
  const CircleMemberNameButton({
    Key? key,
    required this.fm,
  }) : super(key: key);
  final FriendModel fm;

  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);
    // CircleVariables cv = CircleVariables(state);
    CircleController cc = CircleController(state);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(fm.name, size: 18),
            const XSpace(10),
            Material(
                color: AppColors.fadedPink,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: CustomText(fm.accepted ? "" : "Pending", size: 12),
                )),
            const Spacer(),
            TextButton(
                onPressed: () => cc.removeUserFromCircle(fm),
                child: const CustomText(
                  "Remove",
                  size: 15,
                  color: Colors.red,
                ))
          ],
        ),
        const Divider(
          thickness: 3,
        )
      ],
    );
  }
}
