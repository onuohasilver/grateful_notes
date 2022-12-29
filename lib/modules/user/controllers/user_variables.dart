import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:grateful_notes/modules/user/controllers/user_keys.dart';
import 'package:grateful_notes/modules/user/models/user_model.dart';

class UserVariables {
  UserVariables(this.state);

  UserKeys get _keys => UserKeys();
  final BridgeState state;

  UserModel? get user => state.read(_keys.user, null).slice;

  List<UserModel> get usersearch =>
      state.read(_keys.usersearch, <UserModel>[]).slice;

  String get searchtext => state.read(_keys.searchtext, null).slice;
}
