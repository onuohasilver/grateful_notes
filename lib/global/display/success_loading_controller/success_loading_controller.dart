import 'package:bridgestate/state/bridge_controller.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:grateful_notes/core/utilities/colors.dart';
import 'package:grateful_notes/global/display/success_loading_controller/success_loading_input.dart';
import 'package:grateful_notes/global/display/success_loading_controller/success_loading_variables.dart';
import 'package:logger/logger.dart';

class SuccessLoadingController extends BridgeController {
  final BridgeState state;

  SuccessLoadingController(this.state);

  SuccessLoadingInput get sli => SuccessLoadingInput(state);
  SuccessLoadingVariables get slv => SuccessLoadingVariables(state);

  updateIndex() async {
    for (var text in slv.texts) {
      await Future.delayed(const Duration(seconds: 2));
      Logger().i(text);
      if (slv.index < slv.texts.length - 1) sli.onIndexChanged(slv.index + 1);
    }
  }

  @override
  void dispose() {
    sli.onIndexChanged(0);
    sli.onTextsChanged([]);
    sli.onColorsChanged([AppColors.chatreuse]);
  }

  @override
  void initialise() {
    Logger().i("Initil");
  }
}
