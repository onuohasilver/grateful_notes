import 'dart:developer';

import 'package:bridgestate/state/bridge_controller.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:flutter/material.dart';
import 'package:grateful_notes/core/network/request_handler.dart';
import 'package:grateful_notes/core/utilities/navigator.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/global/display/error_screen.dart';
import 'package:grateful_notes/global/display/success_loading.dart';
import 'package:grateful_notes/global/display/success_loading_controller/success_loading_controller.dart';
import 'package:grateful_notes/modules/authentication/controllers/auth_input.dart';
import 'package:grateful_notes/modules/authentication/controllers/auth_keys.dart';
import 'package:grateful_notes/modules/authentication/controllers/auth_variables.dart';
import 'package:grateful_notes/modules/authentication/data/statics.dart';
import 'package:grateful_notes/modules/authentication/views/forgot_password_success.dart';
import 'package:grateful_notes/modules/authentication/views/intro.dart';
import 'package:grateful_notes/modules/authentication/widgets/enter_password.dart';
import 'package:grateful_notes/modules/home/views/home.dart';
import 'package:grateful_notes/modules/user/controllers/user_controller.dart';
import 'package:grateful_notes/modules/user/controllers/user_inputs.dart';
import 'package:grateful_notes/modules/user/models/user_model.dart';
import 'package:grateful_notes/services/auth/auth_service_impl.dart';
import 'package:grateful_notes/services/local_storage/key_storage.dart';
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
  SuccessLoadingController get _slc => SuccessLoadingController(state);
  FlutterSecureStorageImpl get _ks => const FlutterSecureStorageImpl();

  Future signup() async {
    RequestHandler(
            onRequestStart: () => Navigate.to(
                  SuccessLoading(texts: signUpTexts, colors: signUpColors),
                ),
            request: () => _as.signup(email: _av.email, password: _av.password),
            onSuccess: (_) async => {
                  await _createUserProfile(_.data['id']),
                  _ks.saveString(_ak.username, _.data['id']),
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
              Navigate.replaceUntil(Home())
            },
        onError: (_) => Navigate.replace(ErrorScreen(
              errorMessage: _.data['error'].toString().split("]").last,
              secondary: _.data['error']
                      .toString()
                      .split("]")
                      .last
                      .contains("password")
                  ? GestureDetector(
                      onTap: () => forgotPassword(),
                      child: const CustomText("Reset my password",
                          size: 14,
                          color: Colors.white,
                          decoration: TextDecoration.underline),
                    )
                  : null,
            ))).sendRequest();
  }

  Future forgotPassword() async {
    RequestHandler(
      onRequestStart: () => Navigate.replace(
        const SuccessLoading(
            texts: AuthStatics.forgotPasswordTexts,
            colors: AuthStatics.forgotPasswordColors),
      ),
      request: () => _as.forgotPassword(email: _av.email),
      onSuccess: (_) async => {
        await Future.delayed(const Duration(seconds: 5)),
        Navigate.replace(const ForgotPasswordSuccess())
      },
      onError: (_) => Logger().i("New"),
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
          await Future.delayed(const Duration(seconds: 6)),
          Navigate.replaceUntil(Home()),
          _slc.dispose()
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
          .whenComplete(
              () async => await Future.delayed(const Duration(seconds: 3)))
          .whenComplete(() => Navigate.replaceUntil(Home()));
    } else {
      _ai.onIsReturningUserChanged("New");
    }
  }

  logout() {
    Navigate.replaceUntil(const Intro());
    state.close();
    _ks.close();
  }

  @override
  void dispose() {}

  @override
  void initialise() async {
    await checkIfIsReturningUser();
  }
}
