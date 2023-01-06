import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:grateful_notes/core/utilities/loading_states.dart';
import 'package:grateful_notes/modules/user/controllers/user_keys.dart';
import 'package:grateful_notes/modules/user/models/user_model.dart';

class UserVariables {
  UserVariables(this.state);

  UserKeys get _keys => UserKeys();
  final BridgeState state;

  UserModel? get user => state.read(_keys.user, null).slice;

  LoadingStates get currentState =>
      state.read(_keys.currentState, LoadingStates.loading).slice;

  UserModel? get usersearch =>
      state.read(_keys.usersearch, null).slice;

  String get searchtext => state.read(_keys.searchtext, null).slice;
}
