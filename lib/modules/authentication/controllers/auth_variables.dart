import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:grateful_notes/modules/authentication/controllers/auth_keys.dart';

class AuthVariables {
  final BridgeState state;

  AuthVariables(this.state);
  AuthKeys get _keys => AuthKeys();

  String get email => state.read(_keys.email, "").slice;
  String get password => state.read(_keys.password, "").slice;
  String get username => state.read(_keys.username, "").slice;
}
