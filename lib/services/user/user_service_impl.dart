import 'package:gamee/core/network/firebase_extended.dart';
import 'package:gamee/core/network/network_core.dart';
import 'package:gamee/core/network/response_model.dart';
import 'package:gamee/services/user/user_service.dart';

class UserServiceImpl implements UserService {
  final Network _network = NetworkImpl();
  final FirebaseExtended _firebaseExtended = FirebaseExtended();
  @override
  Future<ResponseModel> getuser({required String userid}) async {
    return await _network.get(path: UrlPath('users', userid));
  }

  @override
  Future<ResponseModel> finduser({required String username}) async {
    return await _firebaseExtended.findWhere(
        matcher: MatcherPath('users', username.toLowerCase(), 'username'));
  }
}
