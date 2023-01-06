import 'package:animate_do/animate_do.dart';
import 'package:bridgestate/state/bridge_state/bridge_methods.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grateful_notes/core/asset_files.dart';
import 'package:grateful_notes/core/utilities/colors.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_flat_button.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/global/display/state_aware_builder.dart';
import 'package:grateful_notes/global/overlays/custom_modal_sheet.dart';
import 'package:grateful_notes/modules/circles/controllers/circle_controller.dart';
import 'package:grateful_notes/modules/circles/controllers/circle_variable.dart';
import 'package:grateful_notes/modules/circles/data/friend_model.dart';
import 'package:grateful_notes/modules/circles/views/add_new_circle_modal.dart';
import 'package:lottie/lottie.dart';

class ViewMyCloseCircleModal extends StatelessWidget {
  const ViewMyCloseCircleModal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);
    CircleVariables cv = CircleVariables(state);
    CircleController cc = CircleController(state);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        height: 520.h,
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
            CustomText(
                cv.circle.friends.isEmpty
                    ? "You don't have any one in your circle yet"
                    : "You have ${5 - cv.circle.friends.length} more space(s) left in your circle",
                height: 1.4,
                size: 14),
            const YSpace(24),
            Expanded(
              child: cv.circle.friends.isEmpty
                  ? LottieBuilder.asset(const AnimationAssets().astronaut)
                  : ListView(
                      children: [
                        ...cv.circle.friends
                            .map((e) => CircleMemberNameButton(fm: e))
                      ],
                    ),
            ),
            StateAwareBuilder(
                currentState: cv.currentState,
                done: const SizedBox(),
                loading: Center(
                  child: LottieBuilder.asset(
                    const AnimationAssets().loading,
                    height: 100,
                  ),
                ),
                error:
                    Bounce(child: const Icon(Icons.error, color: Colors.red))),
            Visibility(
              visible: cv.circle.friends.length < 5,
              child: ElasticIn(
                child: CustomFlatButton(
                  label: "Add New",
                  onTap: () {
                    CustomOverlays().showSheet(
                      height: 300,
                      color: Colors.white,
                      child: const AddNewCircleModal(),
                    );
                  },
                  expand: true,
                  alignment: MainAxisAlignment.start,
                  color: Colors.white,
                  bgColor: Colors.black,
                ),
              ),
            ),
            const YSpace(50),
          ],
        ),
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
            Visibility(
              visible: !fm.accepted,
              child: Material(
                  color: AppColors.fadedPink,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: CustomText(fm.accepted ? "" : "Pending", size: 12),
                  )),
            ),
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
