import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:grateful_notes/modules/home/controllers/home_keys.dart';

class HomeVariables {
  final BridgeState state;

  HomeKeys get _keys => HomeKeys();

  DateTime get currentDate =>
      state.read(_keys.currentDate, DateTime.now()).slice;
  
  

  HomeVariables(this.state);
}
