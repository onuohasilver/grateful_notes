import 'package:grateful_notes/core/network/response_model.dart';

abstract class UserService {
  Future<ResponseModel> getuser({required String userid});
  Future<ResponseModel> finduser({required String email});
}
