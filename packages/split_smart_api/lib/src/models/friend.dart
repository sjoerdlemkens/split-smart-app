import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'friend.g.dart';

@JsonSerializable(createToJson: false)
class Friend extends Equatable {
  final String id;
  final String email;

  const Friend({
    required this.id,
    required this.email,
  });

  factory Friend.fromJson(Map<String, dynamic> json) => _$FriendFromJson(json);

  @override
  List<Object?> get props => [
        id,
        email,
      ];
}
