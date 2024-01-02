import 'package:grateful_notes/core/network/api.dart';
import 'package:grateful_notes/core/network/firebase_extended.dart';
import 'package:grateful_notes/core/network/network_core.dart';
import 'package:grateful_notes/core/network/response_model.dart';
import 'package:grateful_notes/services/auth/auth_service.dart';

class AuthServiceImpl extends AuthService {
  final NetworkImpl network = NetworkImpl();
  final FirebaseExtended firebaseExtended = FirebaseExtended();

  @override
  Future<ResponseModel> createProfile(
      {required String email,
      required String username,
      required String notificationid,
      required String id}) async {
    return await network.post(
      path: UrlPath(Api().users, id),
      body: {
        "id": id,
        "email": email,
        "username": username.toLowerCase(),
        "notificationId": notificationid
      },
    );
  }

  @override
  Future<ResponseModel> signup({
    required String email,
    required String password,
  }) async {
    return await firebaseExtended.emailSignup(email: email, password: password);
  }

  @override
  signin({required String email, required String password}) async {
    return await firebaseExtended.emailSignIn(email: email, password: password);
  }

  @override
  forgotPassword({required String email}) async {
    return await firebaseExtended.forgotPassword(email: email);
  }
}
