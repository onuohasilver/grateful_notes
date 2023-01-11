import 'package:bridgestate/bridges.dart';

import 'audio_keys.dart';

class AudioVariables {
  AudioVariables(this.state);

  AudioKeys get keys => AudioKeys();
  final BridgeState state;

  DateTime? get timeStartedRecording =>
      state.read(keys.timeStartedRecording, null).slice;

  get recordStateChanged => state.read(keys.isRecording, false).slice;

  String? get currentAudio => state.read(keys.currentAudio, null).slice;

  String get currentlyBeingPlayed =>
      state.read(keys.currentBeingPlayed, "initial").slice;
  int get currentAudioTimeStamp =>
      state.read(keys.currentAudioTimeStamp, 0).slice;

  bool get isPlaying => state.read(keys.isPlaying, false).slice;
}
