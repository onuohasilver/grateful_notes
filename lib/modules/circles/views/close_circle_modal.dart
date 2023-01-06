import 'package:bridgestate/state/bridge_state/bridge_methods.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_flat_button.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/global/overlays/custom_modal_sheet.dart';
import 'package:grateful_notes/modules/circles/controllers/circle_controller.dart';
import 'package:grateful_notes/modules/circles/controllers/circle_variable.dart';
import 'package:grateful_notes/modules/circles/views/pending_invites_modal.dart';
import 'package:grateful_notes/modules/circles/views/view_circle_modal.dart';
import 'package:grateful_notes/modules/user/controllers/user_variables.dart';

class CloseCircleModal extends StatelessWidget {
  const CloseCircleModal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);
    CircleVariables cv = CircleVariables(state);
    CircleController cc = CircleController(state);
    UserVariables uv = UserVariables(state);
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
              label:
                  "View Circle  (${cv.circle.friends.where((element) => element.accepted).length})",
              onTap: () {
                CustomOverlays().showSheet(
                  height: 580.h,
                  color: Colors.white,
                  child: const ViewMyCloseCircleModal(),
                );
              },
              hasBorder: true,
              expand: true,
              alignment: MainAxisAlignment.start),
          const YSpace(24),
          CustomFlatButton(
              label: "Pending Invites",
              onTap: () {
                CustomOverlays().showSheet(
                    height: 580.h,
                    color: Colors.white,
                    child: const PendingInvitesModal());
              },
              hasBorder: true,
              expand: true,
              suffix: CustomText(
                " (${cv.circle.friends.where((element) => element.senderId != uv.user!.userid && !element.accepted).length})"
                    .toString(),
                size: 14,
                color: Colors.red,
              ),
              alignment: MainAxisAlignment.start)
        ],
      ),
    );
  }
}
