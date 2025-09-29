import 'package:split_smart_api/src/core/core.dart';
import 'package:split_smart_api/src/models/models.dart';

class GroupsService {
  final ApiClient _apiClient;

  GroupsService(this._apiClient);

  /// Create a new group
  Future<Group> createGroup(CreateGroupRequest request) async {
    final response = await _apiClient.post<Map<String, dynamic>>(
      '/groups',
      data: request.toJson(),
      fromJson: (json) => json as Map<String, dynamic>,
    );

    return Group.fromJson(response);
  }

  /// Get all groups for the current user
  Future<List<Group>> getGroups() async {
    final response = await _apiClient.get<List<dynamic>>(
      '/groups',
      fromJson: (json) => json as List<dynamic>,
    );

    return response
        .map((json) => Group.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
