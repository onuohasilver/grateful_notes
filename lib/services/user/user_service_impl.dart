import 'package:grateful_notes/core/network/api.dart';
import 'package:grateful_notes/core/network/firebase_extended.dart';
import 'package:grateful_notes/core/network/network_core.dart';
import 'package:grateful_notes/core/network/response_model.dart';
import 'package:grateful_notes/services/user/user_service.dart';

class UserServiceImpl implements UserService {
  final Network _network = NetworkImpl();
  final FirebaseExtended _firebaseExtended = FirebaseExtended();
  @override
  Future<ResponseModel> getuser({required String userid}) async {
    return await _network.get(path: UrlPath(Api().users, userid));
  }

  @override
  Future<ResponseModel> finduser({required String username}) async {
    return await _firebaseExtended.findWhere(
        matcher: MatcherPath(Api().users, username.toLowerCase(), 'username'));
  }
}
