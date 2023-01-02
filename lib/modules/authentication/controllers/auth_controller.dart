import 'dart:developer';

import 'package:bridgestate/state/bridge_controller.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:grateful_notes/core/network/request_handler.dart';
import 'package:grateful_notes/core/utilities/navigator.dart';
import 'package:grateful_notes/global/display/error_screen.dart';
import 'package:grateful_notes/global/display/success_loading.dart';
import 'package:grateful_notes/global/display/success_loading_controller/success_loading_controller.dart';
import 'package:grateful_notes/modules/authentication/controllers/auth_input.dart';
import 'package:grateful_notes/modules/authentication/controllers/auth_keys.dart';
import 'package:grateful_notes/modules/authentication/controllers/auth_variables.dart';
import 'package:grateful_notes/modules/authentication/widgets/enter_password.dart';
import 'package:grateful_notes/modules/home/views/home.dart';
import 'package:grateful_notes/modules/user/controllers/user_controller.dart';
import 'package:grateful_notes/modules/user/controllers/user_inputs.dart';
import 'package:grateful_notes/modules/user/controllers/user_variables.dart';
import 'package:grateful_notes/modules/user/models/user_model.dart';
import 'package:grateful_notes/services/auth/auth_service_impl.dart';
import 'package:grateful_notes/services/local_storage/key_storage.dart';
import 'package:grateful_notes/services/local_storage/key_value_storage_service.dart';
import 'package:logger/logger.dart';

class AuthController extends BridgeController {
  final BridgeState state;

  AuthController(this.state);
  AuthServiceImpl get _as => AuthServiceImpl();
  AuthVariables get _av => AuthVariables(state);
  AuthInputs get _ai => AuthInputs(state);
  AuthKeys get _ak => AuthKeys();
  UserInputs get _ui => UserInputs(state);
  UserController get _uc => UserController(state);
  UserVariables get _uv => UserVariables(state);
  SuccessLoadingController get _slc => SuccessLoadingController(state);
  KeyValueStorageService get _ks => const FlutterSecureStorageImpl();

  Future signup() async {
    RequestHandler(
            onRequestStart: () => Navigate.to(
                  SuccessLoading(texts: signUpTexts, colors: signUpColors),
                ),
            request: () => _as.signup(email: _av.email, password: _av.password),
            onSuccess: (_) => {
                  _createUserProfile(_.data['id']),
                  _ks.saveString(_ak.username, _.data['id']),
                  _slc.dispose()
                },
            onError: (_) => Navigate.replace(ErrorScreen(
                errorMessage: _.data['error'].toString().split("]").last)))
        .sendRequest();
  }

  //Initializes the signin fllow using the parsed user
  //data.
  Future signin() async {
    RequestHandler(
            onRequestStart: () => Navigate.to(
                  SuccessLoading(texts: signInTexts, colors: signUpColors),
                ),
            request: () => _as.signin(email: _av.email, password: _av.password),
            onSuccess: (_) async => {
                  Logger().i(_),
                  await _uc.getuser(_.data['id']),
                  await Future.delayed(const Duration(seconds: 2)),
                  _ks.saveString(_ak.username, _.data['id']),
                  _slc.dispose(),
                  Navigate.to(Home())
                },
            onError: (_) => Navigate.replace(ErrorScreen(
                errorMessage: _.data['error'].toString().split("]").last)))
        .sendRequest();
  }

  Future _createUserProfile(String id) async {
    RequestHandler(
      request: () =>
          _as.createProfile(email: _av.email, username: _av.username, id: id),
      onSuccess: (_) async => {
        {
          _ui.onUsermodelChanged(
              UserModel(email: _av.email, username: _av.username, userid: id)),
          await Future.delayed(const Duration(seconds: 6)),
          Navigate.to(Home())
        }
      },
      onError: (_) => log("message"),
    ).sendRequest();
  }

  checkIfIsReturningUser() async {
    if (await _ks.hasValue(_ak.username)) {
      _ai.onIsReturningUserChanged("Returning");
      String? id = await _ks.readString(_ak.username);

      await _uc
          .getuser(id!)
          .whenComplete(() => Future.delayed(const Duration(seconds: 1)))
          .whenComplete(() => Navigate.to(Home()));
    } else {
      _ai.onIsReturningUserChanged("New");
    }
  }

  @override
  void dispose() {}

  @override
  void initialise() async {
    await checkIfIsReturningUser();
  }
}
