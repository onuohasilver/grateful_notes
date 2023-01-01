import 'package:grateful_notes/core/network/firebase_extended.dart';
import 'package:grateful_notes/core/network/network_core.dart';
import 'package:grateful_notes/services/gratitude/gratitude_service.dart';

class GratitudeServiceImpl extends GratitudeService {
  final NetworkImpl network = NetworkImpl();
  final FirebaseExtended firebaseExtended = FirebaseExtended();

  @override
  createGratitude(
      {required List<String> text,
      required List<String> images,
      required String userid,
      required String type}) async {
    // DateTime date = DateTime.now();
    return await network.post(
      path: UrlPath('notes', userid),
      body: {
        DateTime.now().toIso8601String(): {
          'imagePaths': images,
          'texts': text,
          'type': type,
          'date': DateTime.now().toIso8601String()
        }
      },
    );
  }

  @override
  getGratitudes({required String userid}) async {
    return await network.get(path: UrlPath('notes', userid));
  }
}