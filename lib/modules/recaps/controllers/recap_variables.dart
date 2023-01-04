import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:grateful_notes/modules/recaps/controllers/recap_keys.dart';
import 'package:grateful_notes/modules/recaps/data/recap_model.dart';

class RecapVariables {
  final BridgeState state;

  RecapVariables(this.state);

  RecapKeys get _keys => RecapKeys();

  RecapModel? get currentRecap => state.read(_keys.currentRecap, null).slice;

  
}
