import 'package:bridgestate/state/bridge_controller.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:grateful_notes/core/network/request_handler.dart';
import 'package:grateful_notes/core/utilities/loading_states.dart';
import 'package:grateful_notes/modules/circles/controllers/circle_inputs.dart';
import 'package:grateful_notes/modules/circles/controllers/circle_variable.dart';
import 'package:grateful_notes/modules/circles/data/close_circle_model.dart';
import 'package:grateful_notes/modules/circles/data/friend_model.dart';
import 'package:grateful_notes/modules/user/controllers/user_variables.dart';
import 'package:grateful_notes/services/circle/circle_service_impl.dart';
import 'package:logger/logger.dart';

class CircleController extends BridgeController {
  final BridgeState state;

  CircleController(this.state);
  CircleServiceImpl get _cs => CircleServiceImpl();

  CircleVariables get _cv => CircleVariables(state);
  CircleInputs get _ci => CircleInputs(state);
  UserVariables get _uv => UserVariables(state);

  addUserToCircle() async {
    Set<FriendModel> friends = _cv.circle.friends.toSet();
    if (friends.length < 5 && _uv.usersearch != null) {
      friends.add(_uv.usersearch!.toFriendModel());

      RequestHandler(
          onRequestStart: _ci.onCurrentStateChanged(LoadingStates.loading),
          request: () => _cs.updateCircle(
                friends: friends.map((e) => e.toJson()).toList(),
                userid: _uv.user!.userid,
              ),
          onError: (_) => Logger().e(_),
          onSuccess: (_) => {
                _ci.onCircleModelChanged(
                    _cv.circle.copyWith(friends: friends.toList())),
                _ci.onCurrentStateChanged(LoadingStates.done)
              }).sendRequest();
    }
  }

  removeUserFromCircle(FriendModel fm) {
    List<FriendModel> friends = _cv.circle.friends;

    friends.remove(fm);

    RequestHandler(
        onRequestStart: _ci.onCurrentStateChanged(LoadingStates.loading),
        request: () => _cs.updateCircle(
              friends: friends.map((e) => e.toJson()).toList(),
              userid: _uv.user!.userid,
            ),
        onError: (_) => Logger().e(_),
        onSuccess: (_) => {
              _ci.onCircleModelChanged(_cv.circle.copyWith(friends: friends)),
              _ci.onCurrentStateChanged(LoadingStates.done)
            }).sendRequest();
  }

  getCircle() {
    RequestHandler(
        request: () => _cs.getCircle(userid: _uv.user!.userid),
        onError: (_) => Logger().e(_),
        onSuccess: (_) => {
              _ci.onCircleModelChanged(CloseCircleModel.fromJson(_.data)),
              Logger().i(_),
            }).sendRequest();
  }

  @override
  void dispose() {}

  @override
  void initialise() {
    getCircle();
  }
}
