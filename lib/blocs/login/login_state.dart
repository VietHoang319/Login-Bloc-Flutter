import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:test_login/models/formz/email.dart';
import 'package:test_login/models/formz/password.dart';

class LoginState extends Equatable {
  final Email email;
  final Password password;
  final bool isValid;
  final FormzSubmissionStatus status;
  final String errorMessage;

  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage = '',
  });

  LoginState copyWith(
      {Email? email,
      Password? password,
      bool? isValid,
      FormzSubmissionStatus? status,
      String? errorMessage}) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [email, password, isValid, status, errorMessage];
}
