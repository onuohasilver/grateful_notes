import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

import 'audio_service.dart';

class AudioServiceImpl extends AudioService {
  final _recordingSession = FlutterSoundRecorder();
  @override
  initialise() async {
    String pathToAudio = '/sdcard/Download/temp.wav';

    await _recordingSession.openRecorder();
    await _recordingSession
        .setSubscriptionDuration(const Duration(milliseconds: 10));
    await Permission.microphone.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
  }

  @override
  pause() {
    // TODO: implement pause
    throw UnimplementedError();
  }

  @override
  record() {
    // TODO: implement record
    throw UnimplementedError();
  }

  @override
  stop() {
    // TODO: implement stop
    throw UnimplementedError();
  }
}
