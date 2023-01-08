import 'package:grateful_notes/core/network/api.dart';
import 'package:grateful_notes/core/network/firebase_extended.dart';
import 'package:grateful_notes/core/network/network_core.dart';
import 'package:grateful_notes/core/network/response_model.dart';
import 'package:grateful_notes/services/gratitude/gratitude_service.dart';
import 'package:logger/logger.dart';

class GratitudeServiceImpl extends GratitudeService {
  final NetworkImpl network = NetworkImpl();
  final FirebaseExtended firebaseExtended = FirebaseExtended();

  @override
  createGratitude(
      {required List<String> text,
      required List<String> images,
      required String privacy,
      required String userid,
      required String type}) async {
    DateTime date = DateTime.now();
    var notes = await network.post(
      path: UrlPath(Api().notes, userid),
      body: {
        DateTime.now().toIso8601String(): {
          'imagePaths': images,
          'texts': text,
          'type': type,
          'Privacy': privacy,
          'date': DateTime(date.year, date.month, date.day).toIso8601String()
        }
      },
    );
    Logger().i(notes);
    return notes;
  }

  @override
  getGratitudes({required String userid}) async {
    return await network.get(path: UrlPath(Api().notes, userid));
  }

  @override
  Future<ResponseModel> updateGratitude(
      {required List<String> text,
      required List<String> images,
      required String type,
      required String privacy,
      required String id,
      required String date,
      required String userid}) async {
    return await network.post(
      path: UrlPath(Api().notes, userid),
      body: {
        id: {
          'imagePaths': images,
          'texts': text,
          'type': type,
          'Privacy': privacy,
          'date': date
        }
      },
    );
  }

  @override
  Future<ResponseModel> deleteGratitude({required String id}) async {
    return await firebaseExtended.findAndDelete(
        matcher: MatcherPath(Api().notes, "keyword", id));
  }
}
