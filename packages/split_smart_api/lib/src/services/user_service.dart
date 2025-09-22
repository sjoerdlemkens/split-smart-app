import 'package:split_smart_api/src/core/core.dart';
import 'package:split_smart_api/src/models/models.dart';

class UserService {
  final ApiClient _apiClient;

  UserService(this._apiClient);

  /// Get the logged in user
  Future<User> getLoggedIn() async {
    await _apiClient.isAuthenticated;
    return _apiClient.get<User>(
      '/users/logged-in',
      fromJson: User.fromJson,
    );
  }

  /// Create a new user account
  Future<AuthTokens> signUp(SignUpRequest request) async {
    return _apiClient.post<AuthTokens>(
      '/auth/register',
      data: request.toJson(),
      fromJson: AuthTokens.fromJson,
    );
  }
}
