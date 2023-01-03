import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:grateful_notes/modules/home/controllers/home_keys.dart';

DateTime dt = DateTime.now();

class HomeVariables {
  final BridgeState state;

  HomeKeys get _keys => HomeKeys();

  DateTime get currentDate =>
      state.read(_keys.currentDate, DateTime(dt.year, dt.month, dt.day)).slice;

  HomeVariables(this.state);
}
