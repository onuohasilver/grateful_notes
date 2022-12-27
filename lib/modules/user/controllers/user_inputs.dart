import 'package:bridgestate/state/bridge_controller.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:grateful_notes/modules/user/controllers/user_keys.dart';
import 'package:grateful_notes/modules/user/models/user_model.dart';

class UserInputs extends BridgeController {
  final BridgeState state;

  UserInputs(this.state);
  UserKeys get _keys => UserKeys();

  onUsermodelChanged(UserModel user) => state.load(_keys.user, user, UserModel);

  onUserSearchChanged(List<UserModel> users) =>
      state.load(_keys.usersearch, users, List<UserModel>);

  onSearchTextChanged(String value) =>
      state.load(_keys.searchtext, value, String);

  @override
  void dispose() {}

  @override
  void initialise() {}
}
