import 'package:bridgestate/state/bridge_controller.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:grateful_notes/core/network/request_handler.dart';
import 'package:grateful_notes/modules/circles/controllers/circle_inputs.dart';
import 'package:grateful_notes/modules/circles/controllers/circle_variable.dart';
import 'package:grateful_notes/modules/circles/data/close_circle_model.dart';
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

  addUserToCircle() {
    List<String> friends = _cv.circle.friends;
    if (friends.length < 5) {
      friends.add("New");

      RequestHandler(
          request: () => _cs.updateCircle(
                friends: friends,
                userid: _uv.user!.userid,
              ),
          onError: (_) => Logger().e(_),
          onSuccess: (_) => _ci.onCircleModelChanged(
              _cv.circle.copyWith(friends: friends))).sendRequest();
    }
  }

  removeUserFromCircle() {
    List<String> friends = _cv.circle.friends;

    friends.remove("New");

    RequestHandler(
            request: () => _cs.updateCircle(
                  friends: friends,
                  userid: _uv.user!.userid,
                ),
            onError: (_) => Logger().e(_),
            onSuccess: (_) =>
                _ci.onCircleModelChanged(_cv.circle.copyWith(friends: friends)))
        .sendRequest();
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
