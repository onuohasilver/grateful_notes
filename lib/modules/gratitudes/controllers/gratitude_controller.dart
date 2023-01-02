import 'package:bridgestate/bridges.dart';
import 'package:grateful_notes/core/network/request_handler.dart';
import 'package:grateful_notes/core/utilities/navigator.dart';
import 'package:grateful_notes/global/display/error_screen.dart';
import 'package:grateful_notes/global/display/success_loading.dart';
import 'package:grateful_notes/global/display/success_loading_controller/success_loading_controller.dart';
import 'package:grateful_notes/modules/gratitudes/controllers/gratitude_input.dart';
import 'package:grateful_notes/modules/gratitudes/controllers/gratitude_variables.dart';
import 'package:grateful_notes/modules/gratitudes/data/gratitude_edit_model.dart';
import 'package:grateful_notes/modules/gratitudes/data/statics.dart';
import 'package:grateful_notes/modules/home/views/home.dart';
import 'package:grateful_notes/modules/user/controllers/user_variables.dart';
import 'package:grateful_notes/services/gratitude/gratitude_service.dart';
import 'package:grateful_notes/services/gratitude/gratitude_service_impl.dart';
import 'package:grateful_notes/services/images/image_service_impl.dart';
import 'package:logger/logger.dart';

class GratitudeController extends BridgeController {
  final BridgeState state;

  GratitudeController(this.state);

  GratitudeInput get _gi => GratitudeInput(state);
  GratitudeVariables get _gv => GratitudeVariables(state);
  GratitudeService get _gs => GratitudeServiceImpl();
  ImageServiceImpl get _is => ImageServiceImpl();
  UserVariables get _uv => UserVariables(state);
  SuccessLoadingController get _slc => SuccessLoadingController(state);

  ///Initializes a new gratitude edit model
  createNew(String type) =>
      _gi.onEditModelChanged(GratitudeEditModel.createNew(type));

  saveGratitude() async {
    Navigate.to(
      const SuccessLoading(
          texts: Statics.saveGratitudeTexts,
          colors: Statics.saveGratitudeColors),
    );
    await _uploadImages();
    RequestHandler(
            onRequestStart: () async => {},
            request: () =>

                // Logger().i("Success savsse"),
                _gs.createGratitude(
                    text: _gv.currentEdit!.texts,
                    images: _gv.currentEdit!.imagePaths,
                    type: _gv.currentEdit!.type,
                    userid: _uv.user!.userid),
            onSuccess: (_) async => {
                  Logger().i("on Success save"),
                  await getGratitudes(),
                  await Future.delayed(const Duration(seconds: 6)),
                  _slc.dispose(),
                  Navigate.to(Home())
                },
            // onRequestEnd: () => _slc.dispose(),
            onError: (_) => Navigate.replace(ErrorScreen(
                errorMessage: _.data['error'].toString().split("]").last)))
        .sendRequest();
  }

  getGratitudes() {
    Logger().i("Getting this");
    RequestHandler(
      request: () => _gs.getGratitudes(userid: _uv.user!.userid),
      onSuccess: (_) => {
        _gi.onGratitudesChanged(_.data.values
            .map((e) => GratitudeEditModel.fromJson(e))
            .toList()
            .reversed
            .toList()),
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
  }

  addImageToModel() async {
    List<String> current = _gv.currentEdit!.imagePaths;
    await _is
        .getImagesFromDevice()
        .then((value) => current.addAll([...value.map((e) => e.path)]));
    // current.add(imagePath);

    _gi.onEditModelChanged(_gv.currentEdit!.copyWith(imagePaths: current));
    Logger().i(_gv.currentEdit);
  }

  _uploadImages() async {
    if (_gv.currentEdit!.imagePaths.isNotEmpty) {
      await _is.uploadToDB(_gv.currentEdit!.imagePaths).then(
            (value) => _gi.onEditModelChanged(
                _gv.currentEdit!.copyWith(imagePaths: value.data['images'])),
          );
    }
  }

  @override
  void dispose() {}

  @override
  void initialise() {
    getGratitudes();
  }
}
