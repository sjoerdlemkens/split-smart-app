import 'package:split_smart_api/split_smart_api.dart';

class UserRepository {
  final SplitSmartApi _apiClient;

  UserRepository({
    SplitSmartApi? apiClient,
  }) : _apiClient = apiClient ?? SplitSmartApi.development();

  /// Get the logged in user
  Future<User> getLoggedInUser() => _apiClient.user.getLoggedIn();

  /// Create a new user account
  Future<AuthTokens> signUp(SignUpRequest request) =>
      _apiClient.user.signUp(request);
}
