import 'package:json_annotation/json_annotation.dart';

part 'add_friend_request.g.dart';

@JsonSerializable(createFactory: false)
class AddFriendRequest {
  final String email;

  const AddFriendRequest({
    required this.email,
  });

  Map<String, dynamic> toJson() => _$AddFriendRequestToJson(this);
}
