import 'package:bridgestate/bridges.dart';
import 'package:grateful_notes/modules/gratitudes/controllers/gratitude_input.dart';
import 'package:grateful_notes/modules/gratitudes/controllers/gratitude_variables.dart';
import 'package:grateful_notes/modules/gratitudes/data/gratitude_edit_model.dart';

class GratitudeController extends BridgeController {
  final BridgeState state;

  GratitudeController(this.state);

  GratitudeInput get _gi => GratitudeInput(state);
  GratitudeVariables get _gv => GratitudeVariables(state);

  ///Initializes a new gratitude edit model
  createNew() => _gi.onEditModelChanged(GratitudeEditModel.createNew());

  addNewField() {
    List<String> current = _gv.currentEdit!.texts;
    current.add("");
    _gi.onEditModelChanged(_gv.currentEdit!.copyWith(texts: current));
  }

  @override
  void dispose() {}

  @override
  void initialise() {}
}
