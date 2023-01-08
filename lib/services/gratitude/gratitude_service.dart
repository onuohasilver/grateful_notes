import 'package:grateful_notes/core/network/response_model.dart';

abstract class GratitudeService {
  Future<ResponseModel> createGratitude(
      {required List<String> text,
      required List<String> images,
      required String type,
      required String privacy,
      required String userid});

  Future<ResponseModel> getGratitudes({required String userid});

  Future<ResponseModel> updateGratitude(
      {required List<String> text,
      required List<String> images,
      required String type,
      required String privacy,
      required String userid,
      required String date,
      required String id});
}
