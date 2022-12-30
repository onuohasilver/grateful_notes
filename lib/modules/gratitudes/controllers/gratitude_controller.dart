import 'package:bridgestate/bridges.dart';
import 'package:grateful_notes/core/network/request_handler.dart';
import 'package:grateful_notes/core/utilities/navigator.dart';
import 'package:grateful_notes/global/display/error_screen.dart';
import 'package:grateful_notes/global/display/success_loading.dart';
import 'package:grateful_notes/modules/gratitudes/controllers/gratitude_input.dart';
import 'package:grateful_notes/modules/gratitudes/controllers/gratitude_variables.dart';
import 'package:grateful_notes/modules/gratitudes/data/gratitude_edit_model.dart';
import 'package:grateful_notes/modules/gratitudes/data/statics.dart';
import 'package:grateful_notes/modules/home/views/home.dart';
import 'package:grateful_notes/modules/user/controllers/user_variables.dart';
import 'package:grateful_notes/services/gratitude/gratitude_service.dart';
import 'package:grateful_notes/services/gratitude/gratitude_service_impl.dart';
import 'package:logger/logger.dart';

class GratitudeController extends BridgeController {
  final BridgeState state;

  GratitudeController(this.state);

  GratitudeInput get _gi => GratitudeInput(state);
  GratitudeVariables get _gv => GratitudeVariables(state);
  GratitudeService get _gs => GratitudeServiceImpl();
  UserVariables get _uv => UserVariables(state);

  ///Initializes a new gratitude edit model
  createNew() => _gi.onEditModelChanged(GratitudeEditModel.createNew());

  saveGratitude() {
    RequestHandler(
            onRequestStart: () => Navigate.to(
                  const SuccessLoading(
                      texts: Statics.saveGratitudeTexts,
                      colors: Statics.saveGratitudeColors),
                ),
            request: () => _gs.createGratitude(
                text: _gv.currentEdit!.texts,
                images: _gv.currentEdit!.imagePaths,
                userid: _uv.user!.userid),
            onSuccess: (_) async => {
                  await Future.delayed(const Duration(seconds: 6)),
                  Navigate.to(const Home())
                },
            onError: (_) => Navigate.replace(ErrorScreen(
                errorMessage: _.data['error'].toString().split("]").last)))
        .sendRequest();
  }

  getGratitudes() {
    RequestHandler(
      request: () => _gs.getGratitudes(userid: _uv.user!.userid),
      onSuccess: (_) => {
        _gi.onGratitudesChanged(
            _.data.values.map((e) => GratitudeEditModel.fromJson(e)).toList()),
        Logger().i(_gv.allGratitudes)
      },
      onError: (_) => Logger().i(_.toString()),
    ).sendRequest();
  }

  addNewField() {
    List<String> current = _gv.currentEdit!.texts;
    current.add("");
    _gi.onEditModelChanged(_gv.currentEdit!.copyWith(texts: current));
  }

  addTextToModel(String text) {
    List<String> current = _gv.currentEdit!.texts;

    current.last = text;
    _gi.onEditModelChanged(_gv.currentEdit!.copyWith(texts: current));
    Logger().i(_gv.currentEdit!.toJson().toString());
  }

  addImageToModel(String imagePath) {
    List<String> current = _gv.currentEdit!.imagePaths;
    current.add(imagePath);
    _gi.onEditModelChanged(_gv.currentEdit!.copyWith(imagePaths: current));
  }

  @override
  void dispose() {}

  @override
  void initialise() {}
}
