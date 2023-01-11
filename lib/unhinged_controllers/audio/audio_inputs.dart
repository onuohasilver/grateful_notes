import 'package:bridgestate/bridges.dart';

import 'audio_keys.dart';

class AudioInputs extends BridgeController {
  final BridgeState state;

  AudioInputs(this.state);

  AudioKeys get keys => AudioKeys();

  onRecordingStateChanged(bool value) =>
      state.load(keys.isRecording, value, bool);
  onPlayStateChanged(bool value) => state.load(keys.isPlaying, value, bool);

  onTimeRecordingChanged(DateTime? timeOfDay) =>
      state.load(keys.timeStartedRecording, timeOfDay, DateTime);

  onCurrentAudioChanged(String? audio) =>
      state.load(keys.currentAudio, audio, String);

  @override
  void dispose() {}

  @override
  void initialise() {}
}
