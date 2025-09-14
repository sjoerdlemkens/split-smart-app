import 'package:split_smart_api/split_smart_api.dart';

/// Exception thrown when login fails.
class LoginFailure implements Exception {
  const LoginFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory LoginFailure.fromException(ApiException e) {
    if (e is AuthException) {
      return LoginFailure(
        'Invalid email or password.',
      );
    } else if (e is ValidationException) {
      return LoginFailure(
        e.message,
      );
    } else {
      return LoginFailure(e.message);
    }
  }

  final String message;
}
