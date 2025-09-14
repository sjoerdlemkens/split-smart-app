import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable(createToJson: false)
class LoginResponse {
  final String accessToken;
  final String refreshToken;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}
