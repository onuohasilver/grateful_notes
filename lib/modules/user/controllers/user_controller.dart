import 'package:bot_toast/bot_toast.dart';
import 'package:bridgestate/bridges.dart';
import 'package:grateful_notes/core/network/request_handler.dart';
import 'package:grateful_notes/modules/user/controllers/user_inputs.dart';
import 'package:grateful_notes/modules/user/controllers/user_variables.dart';
import 'package:grateful_notes/modules/user/models/user_model.dart';
import 'package:grateful_notes/services/user/user_service.dart';
import 'package:grateful_notes/services/user/user_service_impl.dart';

class UserController extends BridgeController {
  final BridgeState state;

  UserController(this.state);
  UserService get _us => UserServiceImpl();
  UserInputs get _ui => UserInputs(state);
  UserVariables get _uv => UserVariables(state);

  getuser(String userid) async {
    RequestHandler(
      request: () => _us.getuser(userid: userid),
      onSuccess: (_) => _ui.onUsermodelChanged(
          UserModel.fromJson(_.data as Map<String, dynamic>)),
      onError: (_) => BotToast.showText(text: "An error occured"),
    ).sendRequest();
  }

  @override
  void dispose() {}

  @override
  void initialise() {}
}
