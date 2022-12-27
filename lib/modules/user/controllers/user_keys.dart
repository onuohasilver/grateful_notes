import 'package:grateful_notes/core/bridge/bridge_controller.dart';

class UserKeys extends BridgeKeys {
  UserKeys() : super("User Keys");
  get user => brKey("User Model");
  get usersearch => brKey("User search result");
  get searchtext => brKey("User search text");
}
