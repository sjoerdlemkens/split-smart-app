import 'package:formz/formz.dart';

/// Confirm Password Form Input Validation Error
enum ConfirmPasswordValidationError {
  /// Confirm password is empty
  empty,

  /// Confirm password does not match password
  mismatch,
}

/// {@template confirm_password}
/// Reusable confirm password form input.
/// {@endtemplate}
class ConfirmPassword
    extends FormzInput<String, ConfirmPasswordValidationError> {
  /// {@macro confirm_password}
  const ConfirmPassword.pure({this.password = ''}) : super.pure('');

  /// {@macro confirm_password}
  const ConfirmPassword.dirty({required this.password, String value = ''})
      : super.dirty(value);

  /// The original password to match against
  final String password;

  @override
  ConfirmPasswordValidationError? validator(String value) {
    if (value.isEmpty) return ConfirmPasswordValidationError.empty;
    if (value != password) return ConfirmPasswordValidationError.mismatch;
    return null;
  }
}
