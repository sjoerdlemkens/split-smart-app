import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable(createToJson: false)
class Group extends Equatable {
  final String id;
  final String name;
  final DateTime createdAt;

  const Group({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  @override
  List<Object?> get props => [
        id,
        name,
        createdAt,
      ];
}
