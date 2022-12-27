import 'dart:developer';

import 'package:bridgestate/state/bridge_controller.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:grateful_notes/core/network/request_handler.dart';
import 'package:grateful_notes/core/utilities/navigator.dart';
import 'package:grateful_notes/global/display/error_screen.dart';
import 'package:grateful_notes/global/display/success_loading.dart';
import 'package:grateful_notes/modules/authentication/controllers/auth_variables.dart';
import 'package:grateful_notes/modules/authentication/widgets/enter_password.dart';
import 'package:grateful_notes/modules/home/views/home.dart';
import 'package:grateful_notes/modules/user/controllers/user_inputs.dart';
import 'package:grateful_notes/modules/user/models/user_model.dart';
import 'package:grateful_notes/services/auth/auth_service_impl.dart';

class AuthController extends BridgeController {
  final BridgeState state;

  AuthController(this.state);
  AuthServiceImpl get _as => AuthServiceImpl();
  AuthVariables get _av => AuthVariables(state);
  UserInputs get _ui => UserInputs(state);

  Future signup() async {
    RequestHandler(
        request: () => _as.signup(email: _av.email, password: _av.password),
        onSuccess: (_) => {
              _createUserProfile(_.data['id']),
            },
        onError: (_) => Navigate.replace(ErrorScreen(
            errorMessage: _.data['error'].toString().split("]").last))
        // BotToast.showText(text: _.data['error'].toString().split("]").last),
        ).sendRequest();
  }

  Future _createUserProfile(String id) async {
    RequestHandler(
      request: () =>
          _as.createProfile(email: _av.email, username: _av.username, id: id),
      onSuccess: (_) async => {
        {
          _ui.onUsermodelChanged(
              UserModel(email: _av.email, username: _av.username, userid: id)),
          Navigate.to(SuccessLoading(texts: signUpTexts, colors: signUpColors)),
          await Future.delayed(const Duration(seconds: 6)),
          Navigate.to(const Home())
        }
      },
      onError: (_) => log("message"),
    ).sendRequest();
  }

  @override
  void dispose() {}

  @override
  void initialise() {}
}
