import 'package:bridgestate/bridges.dart';
import 'package:grateful_notes/core/utilities/loading_states.dart';
import 'package:grateful_notes/modules/circles/controllers/circle_keys.dart';
import 'package:grateful_notes/modules/circles/data/close_circle_model.dart';

class CircleInputs extends BridgeController {
  final BridgeState state;

  CircleInputs(this.state);

  CircleKeys get keys => CircleKeys();

  onCircleModelChanged(CloseCircleModel ccm) =>
      state.load(keys.circleModel, ccm, CloseCircleModel);
      
  onCurrentStateChanged(LoadingStates ls) =>
      state.load(keys.currentState, ls, LoadingStates);

  @override
  void dispose() {}

  @override
  void initialise() {}
}
