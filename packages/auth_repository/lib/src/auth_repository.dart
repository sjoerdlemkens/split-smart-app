import 'package:auth_repository/src/auth_repository_exception.dart';
import 'package:split_smart_api/split_smart_api.dart';

class AuthenticationRepository {
  final SplitSmartApi _apiClient;

  AuthenticationRepository({
    SplitSmartApi? apiClient,
  }) : _apiClient = apiClient ?? SplitSmartApi.development();

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LoginFailure] if an exception occurs.
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      final request = LoginRequest(
        email: email,
        password: password,
      );

      await _apiClient.auth.login(request);
    } on ApiException catch (e) {
      throw LoginFailure.fromException(e);
    } catch (e) {
      throw const LoginFailure();
    }
  }
}
