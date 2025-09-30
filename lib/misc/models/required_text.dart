import 'package:formz/formz.dart';

enum RequiredTextValidationError { empty }

class RequiredText extends FormzInput<String, RequiredTextValidationError> {
  const RequiredText.pure() : super.pure('');
  const RequiredText.dirty([super.value = '']) : super.dirty();

  @override
  RequiredTextValidationError? validator(String value) {
    return value.trim().isNotEmpty ? null : RequiredTextValidationError.empty;
  }
}
