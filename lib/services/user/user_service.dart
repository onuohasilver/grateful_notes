import 'package:gamee/core/network/response_model.dart';

abstract class UserService {
  Future<ResponseModel> getuser({required String userid});
  Future<ResponseModel> finduser({required String username});
}
