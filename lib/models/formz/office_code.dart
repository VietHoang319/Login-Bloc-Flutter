import 'package:formz/formz.dart';

enum OfficeCodeValidationError { invalid }

class OfficeCode extends FormzInput<String, OfficeCodeValidationError> {
  const OfficeCode.pure([super.value = '']) : super.pure();

  const OfficeCode.dirty([super.value = '']) : super.dirty();

  @override
  OfficeCodeValidationError? validator(String value) {
    if (value.isEmpty || value.length != 4) {
      return OfficeCodeValidationError.invalid;
    }
    return null;
  }
}
