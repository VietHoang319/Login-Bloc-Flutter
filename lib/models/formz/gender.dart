import 'package:formz/formz.dart';
import 'package:test_login/models/gender.dart';

enum GenderValidationError { invalid }

List<GenderModel> listGender = [
  GenderModel(value: '', label: ''),
  GenderModel(value: 'male', label: 'Male'),
  GenderModel(value: 'female', label: 'Female'),
  GenderModel(value: 'other', label: 'Other'),
];

class Gender extends FormzInput<String, GenderValidationError> {
  const Gender.pure([super.value = '']) : super.pure();

  const Gender.dirty([super.value = '']) : super.dirty();

  @override
  GenderValidationError? validator(String value) {
    List<String> listGenderValue = listGender.map((gender) => gender.value).toList();
    if (value.isEmpty || !listGenderValue.contains(value)) {
      return GenderValidationError.invalid;
    }
    return null;
  }
}
