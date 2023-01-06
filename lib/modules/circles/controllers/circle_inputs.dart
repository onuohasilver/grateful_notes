import 'package:bridgestate/bridges.dart';
import 'package:grateful_notes/modules/circles/controllers/circle_keys.dart';
import 'package:grateful_notes/modules/circles/data/close_circle_model.dart';
import 'package:grateful_notes/modules/circles/views/close_circle_modal.dart';

class CircleInputs extends BridgeController {
  final BridgeState state;

  CircleInputs(this.state);

  CircleKeys get keys => CircleKeys();

  onCircleModelChanged(CloseCircleModel ccm) =>
      state.load(keys.circleModel, ccm, CloseCircleModel);

  @override
  void dispose() {}

  @override
  void initialise() {}
}
