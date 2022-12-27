import 'package:bridgestate/bridges.dart';
import 'package:grateful_notes/modules/gratitudes/controllers/gratitude_keys.dart';
import 'package:grateful_notes/modules/gratitudes/data/gratitude_edit_model.dart';

class GratitudeVariables {
  GratitudeVariables(this.state);

  GratitudeKeys get _keys => GratitudeKeys();
  final BridgeState state;

  GratitudeEditModel? get currentEdit =>
      state.read(_keys.currentEdit, null).slice;
}
