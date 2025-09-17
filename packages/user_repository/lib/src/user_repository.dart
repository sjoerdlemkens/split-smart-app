import 'package:split_smart_api/split_smart_api.dart';

class UserRepository {
  final SplitSmartApi _apiClient;

  UserRepository({
    SplitSmartApi? apiClient,
  }) : _apiClient = apiClient ?? SplitSmartApi.development();

  /// Get the logged in user
  Future<User> getLoggedInUser() => _apiClient.user.getLoggedIn();
}
