import 'package:bridgestate/state/bridge_controller.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:grateful_notes/core/utilities/loading_states.dart';
import 'package:grateful_notes/modules/gratitudes/controllers/gratitude_keys.dart';
import 'package:grateful_notes/modules/gratitudes/data/gratitude_edit_model.dart';

class GratitudeInput extends BridgeController {
  final BridgeState state;

  GratitudeInput(this.state);
  GratitudeKeys get _keys => GratitudeKeys();

  onEditModelChanged(GratitudeEditModel gem) =>
      state.load(_keys.currentEdit, gem, GratitudeEditModel);

  onGratitudesChanged(List<GratitudeEditModel> gems) =>
      state.load(_keys.allGratitudes, gems, List<GratitudeEditModel>);

  onCurrentStateChanged(LoadingStates ls) =>
      state.load(_keys.currentState, ls, LoadingStates);

  @override
  void dispose() {}

  @override
  void initialise() {}
}
