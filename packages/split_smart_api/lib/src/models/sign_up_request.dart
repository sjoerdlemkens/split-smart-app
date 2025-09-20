import 'package:json_annotation/json_annotation.dart';

part 'sign_up_request.g.dart';

/// {@template sign_up_request}
/// Sign up request model
/// {@endtemplate}
@JsonSerializable()
class SignUpRequest {
  /// {@macro sign_up_request}
  const SignUpRequest({
    required this.email,
    required this.password,
  });

  /// User email
  final String email;

  /// User password
  final String password;

  /// Creates a [SignUpRequest] from Json map
  factory SignUpRequest.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestFromJson(json);

  /// Creates a Json map from a [SignUpRequest]
  Map<String, dynamic> toJson() => _$SignUpRequestToJson(this);
}
