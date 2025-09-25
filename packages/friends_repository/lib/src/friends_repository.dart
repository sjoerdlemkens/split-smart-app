import 'package:split_smart_api/split_smart_api.dart';

/// Repository for managing friends
class FriendsRepository {
  const FriendsRepository({
    required SplitSmartApi apiClient,
  }) : _apiClient = apiClient;

  final SplitSmartApi _apiClient;

  /// Add a friend by email
  Future<void> addFriend(String email) async {
    final request = AddFriendRequest(email: email);
    await _apiClient.friends.addFriend(request);
  }

  /// Get all friends of the current user
  Future<List<Friend>> getFriends() async {
    return await _apiClient.friends.getFriends();
  }
}
