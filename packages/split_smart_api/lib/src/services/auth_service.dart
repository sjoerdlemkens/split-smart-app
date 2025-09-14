import 'package:split_smart_api/src/core/core.dart';
import 'package:split_smart_api/src/models/models.dart';

class AuthService {
  final ApiClient _apiClient;

  AuthService(this._apiClient);

  /// Login user
  Future<LoginResponse> login(LoginRequest request) async {
    final response = await _apiClient.post<LoginResponse>(
      'auth/login',
      data: request.toJson(),
      fromJson: LoginResponse.fromJson,
    );

    // Store the token in the API client for future requests
    _apiClient.setAuthTokens(
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
    );

    return response;
  }
}
