abstract class AuthService {
  const AuthService();

  createProfile({
    required String email,
    required String username,
    required String id,
    required String notificationid
  });

  signup({
    required String email,
    required String password,
  });

  signin({
    required String email,
    required String password,
  });

  forgotPassword({required String email});
}
