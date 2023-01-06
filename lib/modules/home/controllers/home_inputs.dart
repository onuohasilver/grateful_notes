import 'package:bridgestate/state/bridge_controller.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:grateful_notes/modules/home/controllers/home_keys.dart';
import 'package:grateful_notes/modules/home/data/circle_enum.dart';

class HomeInputs extends BridgeController {
  final BridgeState state;

  HomeInputs(this.state);
  HomeKeys get _keys => HomeKeys();

  onCurrentDateChanged(DateTime date) =>
      state.load(_keys.currentDate, date, DateTime);

  onCurrentViewChanged(CurrentView value) =>
      state.load(_keys.currentView, value, CurrentView);

  @override
  void dispose() {}

  @override
  void initialise() {}
}
