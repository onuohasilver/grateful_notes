import 'package:grateful_notes/core/network/api.dart';
import 'package:grateful_notes/core/network/firebase_extended.dart';
import 'package:grateful_notes/core/network/network_core.dart';
import 'package:grateful_notes/core/network/response_model.dart';
import 'package:grateful_notes/services/circle/circle_service.dart';
import 'package:logger/logger.dart';

class CircleServiceImpl extends CircleService {
  final NetworkImpl network = NetworkImpl();
  final FirebaseExtended firebaseExtended = FirebaseExtended();

  @override
  Future<ResponseModel> updateCircle(
      {required List<String> friends, required String userid}) async {
    Logger().i("Tapped");
    return await network.post(path: UrlPath(Api().closeCircle, userid), body: {
      "friends": friends
    });
  }

  @override
  Future<ResponseModel> getCircle({required String userid}) async {
    return await network.get(path: UrlPath(Api().closeCircle, userid));
  }
}
