import 'package:split_smart_api/src/core/core.dart';
import 'package:split_smart_api/src/models/models.dart';

class AuthService {
  final ApiClient _apiClient;
  // final TokenRefreshInterceptor _tokenRefreshInterceptor;

  AuthService(this._apiClient);

  /// Login user
  Future<void> login(LoginRequest request) async {
    final authTokens = await _apiClient.post<AuthTokens>(
      '/auth/login',
      data: request.toJson(),
      fromJson: (json) => AuthTokens.fromJson(json as Map<String, dynamic>),
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

  /// Set or update the token refresh failure handler
  /// This will be called when automatic token refresh fails
  void setOnTokenRefreshFailed(void Function()? callback) {
    _apiClient.tokenRefreshInterceptor.setOnTokenRefreshFailed(callback);
  }
}
