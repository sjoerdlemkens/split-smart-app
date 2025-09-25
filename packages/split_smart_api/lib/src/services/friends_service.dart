import 'package:split_smart_api/src/core/core.dart';
import 'package:split_smart_api/src/models/models.dart';

class FriendsService {
  final ApiClient _apiClient;

  FriendsService(this._apiClient);

  /// Add a friend by email 
  Future<void> addFriend(AddFriendRequest request) async {
    await _apiClient.post<void>(
      '/friends',
      data: request.toJson(),
    );
  }

  /// Get all friends of the current user
  Future<List<Friend>> getFriends() async {
    final response = await _apiClient.get<List<dynamic>>(
      '/friends',
      fromJson: (json) => json as List<dynamic>,
    );

    return response
        .map((json) => Friend.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
