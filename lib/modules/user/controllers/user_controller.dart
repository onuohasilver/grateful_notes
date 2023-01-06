import 'package:bridgestate/bridges.dart';
import 'package:grateful_notes/core/network/request_handler.dart';
import 'package:grateful_notes/core/utilities/loading_states.dart';
import 'package:grateful_notes/modules/user/controllers/user_inputs.dart';
import 'package:grateful_notes/modules/user/controllers/user_variables.dart';
import 'package:grateful_notes/modules/user/models/user_model.dart';
import 'package:grateful_notes/services/user/user_service.dart';
import 'package:grateful_notes/services/user/user_service_impl.dart';
import 'package:logger/logger.dart';

class UserController extends BridgeController {
  final BridgeState state;

  UserController(this.state);
  UserService get _us => UserServiceImpl();
  UserInputs get _ui => UserInputs(state);
  UserVariables get _uv => UserVariables(state);

  Future getuser(String userid) async {
    RequestHandler(
      request: () => _us.getuser(userid: userid),
      onSuccess: (_) => {
        // Logger().i(_),
        _ui.onUsermodelChanged(
            UserModel.fromJson(_.data as Map<String, dynamic>)),
      },
      onError: (_) => Logger().i(_),
    ).sendRequest();
  }

  Future<bool> findUser(String email) async {
    bool response = false;
    await RequestHandler(
      request: () => _us.finduser(email: email),
      onRequestStart: () => {
        _ui.onUserSearchChanged(null),
        _ui.onCurrentStateChanged(LoadingStates.loading),
      },
      removeFocus: false,
      onSuccess: (_) {
        response = _.data['users'].isNotEmpty;
        Logger().e(response);
        _ui.onCurrentStateChanged(LoadingStates.done);
        Logger().i(_.data['users']);

        if (response) {
          _ui.onUserSearchChanged(UserModel.fromJson(_.data['users'].first));
        }
      },
      onError: (_) => _ui.onCurrentStateChanged(LoadingStates.done),
    ).sendRequest();
    return response;
  }

  @override
  void dispose() {}

  @override
  void initialise() {}
}
