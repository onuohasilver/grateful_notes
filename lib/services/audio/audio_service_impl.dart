import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

import 'audio_service.dart';

class AudioServiceImpl extends AudioService {
  // final _recordingSession = FlutterSoundRecorder();

  final recorder = Record();
  final player = AudioPlayer();

  @override
  initialise() async {
    await Permission.microphone.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
  }

  @override
  pause() {}

  @override
  record() async {
    initialise();
    if (await recorder.hasPermission()) {
      Directory path = await getApplicationDocumentsDirectory();
      path.createSync();
      if (!path.existsSync()) {
        path.createSync();
      }
      await recorder.start(
        path: '${path.path}/myFile.m4a',
        encoder: AudioEncoder.aacLc,
        bitRate: 128000,
      );
      // .then((value) => Logger().i(Directory("$path").listSync()));
    } else {
      initialise();
    }

    // Get the state of the recorder
    // bool isRecording = await recorder.isRecording();

    // Stop recording
  }

  @override
  stop() async {
    await recorder.stop().then((value) => Logger().i(value));
  }

  @override
  play() async {
    Directory path = await getApplicationDocumentsDirectory();
    player.play(DeviceFileSource('${path.path}/myFile.m4a'));
  }
}
