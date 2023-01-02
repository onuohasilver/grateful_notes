import 'package:bridgestate/state/bridge_controller.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:grateful_notes/modules/authentication/controllers/auth_keys.dart';

class AuthInputs extends BridgeController {
  final BridgeState state;

  AuthInputs(this.state);

  AuthKeys get _keys => AuthKeys();

  onEmailChanged(String value) => state.load(_keys.email, value, String);
  onPasswordChanged(String value) => state.load(_keys.password, value, String);
  onUsernameChanged(String value) => state.load(_keys.username, value, String);
  onIsReturningUserChanged(String value) =>
      state.load(_keys.returningUser, value, String);

  @override
  void dispose() {}

  @override
  void initialise() {}
}
