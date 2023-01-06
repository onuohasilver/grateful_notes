import 'package:grateful_notes/core/network/response_model.dart';

abstract class CircleService {
  Future<ResponseModel> updateCircle(
      {required List<Map> friends, required String userid});

  Future<ResponseModel> getCircle({required String userid});
}
