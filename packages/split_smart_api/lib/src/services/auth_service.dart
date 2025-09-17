import 'package:split_smart_api/src/core/core.dart';
import 'package:split_smart_api/src/models/models.dart';

class AuthService {
  final ApiClient _apiClient;

  AuthService(this._apiClient);

  /// Login user
  Future<void> login(LoginRequest request) async {
    final authTokens = await _apiClient.post<AuthTokens>(
      '/auth/login',
      data: request.toJson(),
      fromJson: AuthTokens.fromJson,
    );

    // Store the token in the API client for future requests
    _apiClient.setAuthTokens(authTokens);
  }

  /// Check if user is authenticated
  Future<bool> get isAuthenticated async {
    return await _apiClient.isAuthenticated;
  }

  /// Logout user (clear local tokens)
  Future<void> logout() async {
    await _apiClient.clearAuthTokens();
  }
}
