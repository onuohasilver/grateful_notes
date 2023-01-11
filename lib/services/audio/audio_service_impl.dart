import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:grateful_notes/core/network/response_model.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

import 'audio_service.dart';

class AudioServiceImpl extends AudioService {
  // final _recordingSession = FlutterSoundRecorder();

  final recorder = Record();
  final player = AudioPlayer(playerId: "identier");
  final CloudinaryPublic _cloudinary =
      CloudinaryPublic('afroify', 'grateful_notes', cache: true);

  @override
  initialise() async {
    await Permission.microphone.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
  }

  @override
  pause() {
    player.pause();
  }

  @override
  Future record() async {
    initialise();
    if (await recorder.hasPermission()) {
      Directory path = await getApplicationDocumentsDirectory();
      path.createSync();
      if (!path.existsSync()) {
        path.createSync();
      }
      await recorder.start(
        path: '${path.path}/${DateTime.now().toIso8601String()}.m4a',
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
  Future<String> stop() async {
    String path = '';
    player.stop();
    await recorder.stop().then((value) => path = value!);
    return path;
  }

  @override
  play({required String source, required String url}) async {
    late Source path;
    if (source == "dfs") {
      path = DeviceFileSource(url);
    } else {
      path = UrlSource(url);
    }
    Logger().i(path);
    player.play(path);
  }

  @override
  Future<ResponseModel> uploadToDB(audio) async {
    // List<String> imageUrls = [];
    String path = "";
    // Logger().i("message");

    await _cloudinary
        .uploadFile(CloudinaryFile.fromFile(audio))
        .then((value) => path = value.secureUrl);

    return ResponseModel(data: {'audio': path}, success: true, code: 200);
  }
}
