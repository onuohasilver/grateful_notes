import 'package:bridgestate/state/bridge_controller.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:grateful_notes/modules/recaps/controllers/recap_keys.dart';
import 'package:grateful_notes/modules/recaps/data/recap_model.dart';

class RecapInput extends BridgeController {
  final BridgeState state;

  RecapInput(this.state);
  RecapKeys get _keys => RecapKeys();

  onRecapModelChanged(RecapModel rm) =>
      state.load(_keys.currentRecap, rm, RecapModel);

  @override
  void dispose() {}

  @override
  void initialise() {}
}
