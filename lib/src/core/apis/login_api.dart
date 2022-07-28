abstract class LoginApi {
  Future<bool> createUser({
    required String name,
    required String email,
    required String password,
  });

  Future<String> login({
    required String email,
    required String password,
  });
}
