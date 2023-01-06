import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:grateful_notes/modules/home/controllers/home_keys.dart';
import 'package:grateful_notes/modules/home/data/circle_enum.dart';

DateTime dt = DateTime.now();

class HomeVariables {
  final BridgeState state;

  HomeKeys get _keys => HomeKeys();

  DateTime get currentDate =>
      state.read(_keys.currentDate, DateTime(dt.year, dt.month, dt.day)).slice;

  CurrentView get currentView =>
      state.read(_keys.currentView, CurrentView.myNotes).slice;

  HomeVariables(this.state);
}
