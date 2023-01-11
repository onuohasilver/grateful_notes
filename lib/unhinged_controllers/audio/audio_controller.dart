import 'package:bridgestate/bridges.dart';
import 'package:grateful_notes/core/network/request_handler.dart';
import 'package:grateful_notes/services/audio/audio_service_impl.dart';
import 'package:grateful_notes/unhinged_controllers/audio/audio_inputs.dart';
import 'package:grateful_notes/unhinged_controllers/audio/audio_variables.dart';
import 'package:logger/logger.dart';

class AudioController extends BridgeController {
  final BridgeState state;

  AudioController(this.state);
  AudioServiceImpl get _aus => AudioServiceImpl();
  AudioInputs get _aui => AudioInputs(state);
  AudioVariables get _auv => AudioVariables(state);

  Stream<Duration> getDurationState() {
    return _aus.player.onPositionChanged;
  }

  record() async {
    _aui.onRecordingStateChanged(true);
    _aui.onTimeRecordingChanged(DateTime.now());
    await _aus.record();
  }

  Future<String> stopRecord() async {
    _aui.onRecordingStateChanged(true);
    // _aui.onTimeRecordingChanged(null);
    _aui.onCurrentAudioTimeStampChanged(
        DateTime.now().difference(_auv.timeStartedRecording!).inSeconds);
    String path = await _aus.stop();
    _aui.onCurrentAudioChanged(path);

    return path;
  }

  playAudio({String source = 'dfs', String? url}) {
    _aus.play(source: source, url: url ?? _auv.currentAudio!);
    _aui.onCurrentBeingPlayedChanged(url);
    _aui.onPlayStateChanged(true);
  }

  pauseAudio() {
    _aus.pause();
    _aui.onPlayStateChanged(false);
    _aui.onCurrentBeingPlayedChanged("");
  }

  getPercentage() {
    _aus.getPercentage();
  }

  uploadToDB() async {
    Logger().i("Sending");
    await RequestHandler(
      request: () => _aus.uploadToDB(_auv.currentAudio!),
      onSuccess: (_) =>
          {_aui.onCurrentAudioChanged(_.data['audio']), Logger().i(_)},
      onError: (_) => Logger().i(_),
    ).sendRequest();
  }

  @override
  void dispose() {
    _aui.onPlayStateChanged(false);
  }

  @override
  void initialise() {
    _aui.onCurrentAudioChanged(null);
  }
}

extension CopyDuration on Duration {
  format() {
    return toString().split('.').first.padLeft(8, "0");
  }
}

class DurationState {
  const DurationState({
    required this.progress,
    required this.buffered,
    required this.total,
  });
  final Duration progress;
  final Duration buffered;
  final Duration total;
}
