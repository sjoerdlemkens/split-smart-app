import 'package:split_smart_api/src/core/core.dart';
import 'package:split_smart_api/src/models/models.dart';

class UserService {
  final ApiClient _apiClient;

  UserService(this._apiClient);

  /// Get the logged in user
  Future<User> getLoggedIn() {
    // Throw error when not authenticated.

    return _apiClient.get<User>(
      '/users/logged-in',
      fromJson: User.fromJson,
    );
  }
}
