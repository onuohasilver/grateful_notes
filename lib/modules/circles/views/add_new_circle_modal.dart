import 'package:animate_do/animate_do.dart';
import 'package:bridgestate/state/bridge_builder.dart';
import 'package:bridgestate/state/bridge_state/bridge_methods.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:flutter/material.dart';
import 'package:grateful_notes/core/utilities/navigator.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_flat_button.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/global/display/state_aware_builder.dart';
import 'package:grateful_notes/modules/circles/controllers/circle_controller.dart';
import 'package:grateful_notes/modules/user/controllers/user_controller.dart';
import 'package:grateful_notes/modules/user/controllers/user_inputs.dart';
import 'package:grateful_notes/modules/user/controllers/user_variables.dart';

class AddNewCircleModal extends StatelessWidget {
  const AddNewCircleModal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);
    CircleController cc = CircleController(state);
    UserController uc = UserController(state);
    UserVariables uv = UserVariables(state);
    UserInputs ui = UserInputs(state);
    return BridgeBuilder(
      controllers: [ui],
      dispose: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              "Add new",
              size: 18,
              weight: FontWeight.bold,
              height: 1.5,
            ),
            const YSpace(12),
            const CustomText("Enter the tag of the person to add",
                height: 1.4, size: 14),
            const YSpace(12),
            TextField(
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              onChanged: (_) {
                uc.findUser(_);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                height: 20,
                child: StateAwareBuilder(
                    currentState: uv.currentState,
                    done: uv.usersearch != null
                        ? CustomText(uv.usersearch!.username, size: 14)
                        : const SizedBox(),
                    loading: Flash(
                        infinite: true,
                        child: const CustomText("Searching", size: 12)),
                    error: Bounce(
                        child: const Icon(Icons.error, color: Colors.red))),
              ),
            ),
            const YSpace(12),
            Visibility(
              visible: uv.usersearch != null,
              child: ElasticIn(
                child: CustomFlatButton(
                    label: "Send Invite",
                    onTap: () {
                      cc.addUserToCircle();
                      Navigate.pop();
                    },
                    expand: true,
                    alignment: MainAxisAlignment.start,
                    color: Colors.white,
                    bgColor: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
