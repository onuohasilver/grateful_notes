import 'package:bridgestate/bridges.dart';
import 'package:grateful_notes/core/network/request_handler.dart';
import 'package:grateful_notes/core/utilities/loading_states.dart';
import 'package:grateful_notes/core/utilities/navigator.dart';
import 'package:grateful_notes/global/display/error_screen.dart';
import 'package:grateful_notes/global/display/success_loading.dart';
import 'package:grateful_notes/global/display/success_loading_controller/success_loading_controller.dart';
import 'package:grateful_notes/modules/circles/controllers/circle_variable.dart';
import 'package:grateful_notes/modules/circles/data/friend_model.dart';
import 'package:grateful_notes/modules/gratitudes/controllers/gratitude_input.dart';
import 'package:grateful_notes/modules/gratitudes/controllers/gratitude_variables.dart';
import 'package:grateful_notes/modules/gratitudes/data/gratitude_edit_model.dart';
import 'package:grateful_notes/modules/gratitudes/data/statics.dart';
import 'package:grateful_notes/modules/home/views/home.dart';
import 'package:grateful_notes/modules/settings/controllers/settings_variables.dart';
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
  CircleVariables get _cv => CircleVariables(state);
  SettingsVariables get _sv => SettingsVariables(state);

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
                    privacy: _gv.currentEdit!.privacy ?? _sv.privacy,
                    userid: _uv.user!.userid),
            onSuccess: (_) async => {
                  Logger().i("on Success save"),
                  await getGratitudes(),
                  await Future.delayed(const Duration(seconds: 6)),
                  _slc.dispose(),
                  Navigate.to(Home(callInitMethods: false))
                },
            onError: (_) => Navigate.replace(ErrorScreen(
                errorMessage: _.data['error'].toString().split("]").last)))
        .sendRequest();
  }

  getGratitudes({bool showloading = true}) {
    Logger().d("Fetching the gratitudes ${_uv.user?.userid}");
    RequestHandler(
      onRequestStart: showloading
          ? () => _gi.onCurrentStateChanged(LoadingStates.loading)
          : () {},
      request: () => _gs.getGratitudes(userid: _uv.user!.userid),
      onSuccess: (_) => {
        Logger().d("Fetching the gratitudes $_"),
        if (_.success)
          {
            _gi.onGratitudesChanged(_.data.values
                .map((e) => GratitudeEditModel.fromJson(
                    e, _.data.keys.firstWhere((key) => _.data[key] == e)))
                .toList()
                .reversed
                .toList()),
            _gi.onCurrentStateChanged(LoadingStates.done),
          }
        else
          {_gi.onCurrentStateChanged(LoadingStates.done)},
        Logger().i(_gv.allGratitudes)
      },
      onError: (_) => _gi.onCurrentStateChanged(LoadingStates.error),
    ).sendRequest();
  }

  updateGratitude(GratitudeEditModel gem) {
    RequestHandler(
      request: () => _gs.updateGratitude(
          id: gem.id,
          text: gem.texts,
          images: gem.imagePaths,
          type: gem.type,
          privacy: gem.privacy!,
          userid: _uv.user!.userid,
          date: gem.date.toIso8601String()),
      onSuccess: (_) =>
          {Logger().i("Success"), getGratitudes(showloading: false)},
      onError: (_) => Logger().i("Error"),
    ).sendRequest();
  }

  // deleteGratitude(GratitudeEditModel gem) {
  //   RequestHandler(
  //     request: () => _gs.deleteGratitude(id: gem.id),
  //     onSuccess: (_) =>
  //         {Logger().i("Success"), getGratitudes(showloading: false)},
  //     onError: (_) => Logger().i("Error"),
  //   ).sendRequest();
  // }

  getCircleGratitudes() {
    for (FriendModel friend
        in _cv.circle.friends.where((element) => element.accepted)) {
      _fetchCircleGratitudes(friend);
    }
  }

  _fetchCircleGratitudes(FriendModel fm) {
    Logger().d("Fetching Circle gratitudes ${fm.id}");
    List<GratitudeEditModel> notes = [];
    RequestHandler(
      // onRequestStart: () => _gi.onCurrentStateChanged(LoadingStates.loading),
      request: () => _gs.getGratitudes(userid: fm.id),
      onSuccess: (_) => {
        Logger().d("Fetching the gratitudes $_"),
        if (_.success)
          {
            notes = _gv.allCircleGratitudes,
            notes.addAll(_.data.values
                .map((e) => GratitudeEditModel.fromJson(
                        e, _.data.keys.firstWhere((key) => _.data[key] == e))
                    .copyWith(name: fm.name))
                .toList()
                .reversed
                .toList()),
            _gi.onCircleGratitudesChanged(
                notes.where((element) => element.privacy == "Open").toList()),
            _gi.onCurrentStateChanged(LoadingStates.done),
          }
        else
          {_gi.onCurrentStateChanged(LoadingStates.done)},
        Logger().i(_gv.allCircleGratitudes)
      },
      onError: (_) => _gi.onCurrentStateChanged(LoadingStates.error),
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

  addPrivacyToModel(String text) {
    _gi.onEditModelChanged(_gv.currentEdit!.copyWith(privacy: text));
  }

  addImageToModel() async {
    List<String> current = _gv.currentEdit!.imagePaths;
    await _is
        .getImagesFromDevice()
        .then((value) => current.addAll([...value.map((e) => e.path)]));
    _gi.onEditModelChanged(
        _gv.currentEdit!.copyWith(imagePaths: current.take(2).toList()));
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
  void initialise() async {
    await Future.delayed(const Duration(seconds: 2));
    await getGratitudes();
    await getCircleGratitudes();
  }
}
