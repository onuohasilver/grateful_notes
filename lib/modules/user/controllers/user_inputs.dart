import 'package:bridgestate/state/bridge_controller.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:grateful_notes/core/utilities/loading_states.dart';
import 'package:grateful_notes/modules/user/controllers/user_keys.dart';
import 'package:grateful_notes/modules/user/models/user_model.dart';

class UserInputs extends BridgeController {
  final BridgeState state;

  UserInputs(this.state);
  UserKeys get _keys => UserKeys();

  onUsermodelChanged(UserModel user) => state.load(_keys.user, user, UserModel);

  onUserSearchChanged(UserModel? users) =>
      state.load(_keys.usersearch, users, UserModel);

  onSearchTextChanged(String value) =>
      state.load(_keys.searchtext, value, String);
  onCurrentStateChanged(LoadingStates ls) =>
      state.load(_keys.currentState, ls, LoadingStates);

  @override
  void dispose() {
    state.closeKeyList([_keys.usersearch]);
  }

  @override
  void initialise() {}
}
