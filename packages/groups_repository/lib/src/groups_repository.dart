import 'package:split_smart_api/split_smart_api.dart';

/// Repository for managing groups
class GroupsRepository {
  const GroupsRepository({
    required SplitSmartApi apiClient,
  }) : _apiClient = apiClient;

  final SplitSmartApi _apiClient;

  /// Create a new group
  Future<Group> createGroup({
    required String name,
    String? description,
    List<String> memberEmails = const [],
  }) async {
    final request = CreateGroupRequest(
      name: name,
      description: description,
      memberEmails: memberEmails,
    );
    return await _apiClient.groups.createGroup(request);
  }

  /// Get all groups for the current user
  Future<List<Group>> getGroups() async {
    return await _apiClient.groups.getGroups();
  }
}
