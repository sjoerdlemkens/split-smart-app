import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_group_request.g.dart';

@JsonSerializable(createFactory: false)
class CreateGroupRequest extends Equatable {
  final String name;
  final String? description;
  final List<String> memberEmails;

  const CreateGroupRequest({
    required this.name,
    this.description,
    this.memberEmails = const [],
  });

  Map<String, dynamic> toJson() => _$CreateGroupRequestToJson(this);

  @override
  List<Object?> get props => [name, description, memberEmails];
}
