import 'package:grateful_notes/core/bridge/bridge_controller.dart';

class AudioKeys extends BridgeKeys {
  AudioKeys() : super('Audio');

  get isRecording => brKey("IsRecording");
  get timeStartedRecording => brKey("Time Started recording");
  get currentAudio => brKey("AudioCurrent");
  get isPlaying => brKey("Is Playing");
  get currentBeingPlayed => brKey("CcurrentBeingPlayed");
  get currentAudioTimeStamp => brKey("Current audio time stamp");
}
