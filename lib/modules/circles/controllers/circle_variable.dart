import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:grateful_notes/modules/circles/controllers/circle_keys.dart';
import 'package:grateful_notes/modules/circles/data/close_circle_model.dart';

class CircleVariables {
  CircleVariables(this.state);

  CircleKeys get keys => CircleKeys();
  final BridgeState state;

  CloseCircleModel get circle =>
      state.read(keys.circleModel, CloseCircleModel.empty()).slice;
}
