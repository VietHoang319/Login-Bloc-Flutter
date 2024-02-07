import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:test_login/models/formz/birthday.dart';
import 'package:test_login/models/formz/email.dart';
import 'package:test_login/models/formz/gender.dart';
import 'package:test_login/models/formz/office_code.dart';
import 'package:test_login/models/formz/username.dart';

class RegisterState extends Equatable {
  final int step;
  final OfficeCode officeCode;
  final Username username;
  final Email email;
  final Birthday birthday;
  final Gender gender;
  final bool notificationFlag;
  final bool isValid;
  final FormzSubmissionStatus status;

  const RegisterState({
    this.step = 1,
    this.officeCode = const OfficeCode.pure(),
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.birthday = const Birthday.pure(),
    this.gender = const Gender.pure(),
    this.notificationFlag = false,
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
  });

  RegisterState copyWith({
    int? step,
    OfficeCode? officeCode,
    Username? username,
    Email? email,
    Birthday? birthday,
    Gender? gender,
    bool? notificationFlag,
    bool? isValid,
    FormzSubmissionStatus? status,
  }) {
    return RegisterState(
      step: step ?? this.step,
      officeCode: officeCode ?? this.officeCode,
      username: username ?? this.username,
      email: email ?? this.email,
      birthday: birthday ?? this.birthday,
      gender: gender ?? this.gender,
      notificationFlag: notificationFlag ?? this.notificationFlag,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        step,
        officeCode,
        username,
        email,
        birthday,
        gender,
        notificationFlag,
        isValid,
        status
      ];
}
