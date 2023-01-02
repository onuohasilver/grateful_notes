import 'package:grateful_notes/core/bridge/bridge_controller.dart';

class AuthKeys extends BridgeKeys {
  AuthKeys() : super('Auth Keys');

  get email => brKey("Email");
  get password => brKey("Password");
  get username => brKey("name");
  get returningUser => brKey("Returning User");
}
