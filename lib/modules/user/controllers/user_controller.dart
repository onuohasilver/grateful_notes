import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:bridgestate/bridges.dart';
import 'package:gamee/core/network/request_handler.dart';
import 'package:gamee/core/utilities/navigator.dart';
import 'package:gamee/modules/menu/views/search_opponent_result.dart';
import 'package:gamee/modules/user/bridge/user_inputs.dart';
import 'package:gamee/modules/user/bridge/user_variables.dart';
import 'package:gamee/modules/user/models/user_model.dart';
import 'package:gamee/services/user/user_service.dart';
import 'package:gamee/services/user/user_service_impl.dart';

class UserController extends BridgeController {
  final BridgeState state;

  UserController(this.state);
  UserService get _us => UserServiceImpl();
  UserInputs get _ui => UserInputs(state);
  UserVariables get _uv => UserVariables(state);

  getuser(String userid) {
    RequestHandler(
      onRequestStart: () => BotToast.showLoading(),
      request: () => _us.getuser(userid: userid),
      onSuccess: (_) => _ui.onUsermodelChanged(
          UserModel.fromJson(_.data as Map<String, dynamic>)),
      onError: (_) => BotToast.showText(text: "An error occured"),
    ).sendRequest();
  }

  ///Find the user with the parsed name
  finduser() {
    RequestHandler(
      onRequestStart: () => BotToast.showLoading(),
      request: () => _us.finduser(username: _uv.searchtext),
      onSuccess: (_) => {
        log(_.toString()),
        _ui.onUserSearchChanged(
            [...(_.data['users'] as List).map((e) => UserModel.fromJson(e))]),
        _uv.usersearch.isEmpty
            ? BotToast.showText(text: "No user found")
            : Navigate.to(const SearchOpponentResult())
      },
      onError: (_) => BotToast.showText(text: "An error occured"),
    ).sendRequest();
  }

  @override
  void dispose() {}

  @override
  void initialise() {}
}
