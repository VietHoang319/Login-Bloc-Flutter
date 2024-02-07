import 'package:formz/formz.dart';

enum BirthValidationError {isvalid}
class Birthday extends FormzInput<DateTime?, BirthValidationError> {
  const Birthday.pure([super.value]) : super.pure();
  const Birthday.dirty([super.value]) : super.dirty();

  @override
  BirthValidationError? validator(DateTime? value) {
    if (value == null) {
      return BirthValidationError.isvalid;
    }
    return null;
  }
}