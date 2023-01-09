import 'package:bridgestate/state/bridge_controller.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:grateful_notes/core/network/request_handler.dart';
import 'package:grateful_notes/core/utilities/loading_states.dart';
import 'package:grateful_notes/modules/circles/controllers/circle_inputs.dart';
import 'package:grateful_notes/modules/circles/controllers/circle_variable.dart';
import 'package:grateful_notes/modules/circles/data/close_circle_model.dart';
import 'package:grateful_notes/modules/circles/data/friend_model.dart';
import 'package:grateful_notes/modules/gratitudes/controllers/gratitude_controller.dart';
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
  GratitudeController get _gc => GratitudeController(state);

  addUserToCircle() async {
    Set<FriendModel> friends = _cv.circle.friends.toSet();
    if (friends.length < 5 && _uv.usersearch != null) {
      friends.add(
          _uv.usersearch!.toFriendModel().copyWith(senderId: _uv.user!.userid));

      RequestHandler(
          onRequestStart: _ci.onCurrentStateChanged(LoadingStates.loading),
          request: () => _cs.updateCircle(
              friends: friends.map((e) => e.toJson()).toList(),
              userid: _uv.user!.userid),
          onError: (_) => Logger().e(_),
          onSuccess: (_) async => {
                _ci.onCircleModelChanged(
                    _cv.circle.copyWith(friends: friends.toList())),
                await findUserAndUpdateCircle(
                    userid: _cv.circle.friends.first.id),
                _ci.onCurrentStateChanged(LoadingStates.done)
              }).sendRequest();
    }
  }

  acceptUserToCircle(FriendModel fm) async {
    List<FriendModel> friends = _cv.circle.friends;
    friends.remove(fm);
    friends.add(fm.copyWith(accepted: true));

    RequestHandler(
      onRequestStart: _ci.onCurrentStateChanged(LoadingStates.loading),
      request: () => _cs.updateCircle(
          friends: friends.map((e) => e.toJson()).toList(),
          userid: _uv.user!.userid),
      onSuccess: (_) async => {
        _ci.onCircleModelChanged(
            _cv.circle.copyWith(friends: friends.toList())),
        await getCircle(),
        _gc.getCircleGratitudes(),
        await findUserAndUpdateCircle(
            userid: _cv.circle.friends.first.id,
            status: true,
            senderId: fm.senderId),
        _ci.onCurrentStateChanged(LoadingStates.done),
      },
      onError: (_) => Logger().e(_),
    ).sendRequest();
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
        onSuccess: (_) async => {
              _ci.onCircleModelChanged(_cv.circle.copyWith(friends: friends)),
              await getCircle(),
              _gc.getCircleGratitudes(),
              await findUserAndUpdateCircle(
                  userid: fm.id,
                  status: false,
                  remove: true,
                  senderId: fm.senderId),
              _ci.onCurrentStateChanged(LoadingStates.done)
            }).sendRequest();
  }

  getCircle() {
    RequestHandler(
        request: () => _cs.getCircle(userid: _uv.user!.userid),
        onError: (_) => Logger().e(_),
        onSuccess: (_) => {
              Logger().e("New$_"),
              _ci.onCircleModelChanged(CloseCircleModel.fromJson(_.data)),
              Logger().i(_),
            }).sendRequest();
  }

  findUserAndUpdateCircle(
      {required String userid,
      bool status = false,
      String? senderId,
      bool remove = false}) {
    CloseCircleModel ccm = CloseCircleModel.empty();
    List<FriendModel> friends = [];
    FriendModel currentFm = FriendModel(
      senderId: senderId ?? _uv.user!.userid,
      name: _uv.user!.username,
      id: _uv.user!.userid,
      accepted: status,
    );
    RequestHandler(
      request: () => _cs.getCircle(userid: userid),
      onSuccess: (_) async => {
        ccm = CloseCircleModel.fromJson(_.data),
        Logger().i(ccm),
        friends = ccm.friends,
        friends.remove(currentFm),
        if (!remove) friends.add(currentFm),
        await _cs.updateCircle(
            friends: friends.map((e) => e.toJson()).toList(), userid: userid),
      },
      onError: (_) => Logger().i(_),
    ).sendRequest();
  }

  @override
  void dispose() {}

  @override
  void initialise() {
    getCircle();
  }
}
