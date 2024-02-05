import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:test_login/blocs/login/login_event.dart';
import 'package:test_login/blocs/login/login_state.dart';
import 'package:test_login/models/formz/email.dart';
import 'package:test_login/models/formz/password.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email.isValid ? email : Email.pure(event.email),
      isValid: Formz.validate([email, state.password]),
      status: FormzSubmissionStatus.initial,
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password.isValid ? password : Password.pure(event.password),
      isValid: Formz.validate([state.email, password]),
      status: FormzSubmissionStatus.initial,
    ));
  }

  void _onSubmitted(LoginSubmitted event, Emitter<LoginState> emit) {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    emit(state.copyWith(
      email: email,
      password: password,
      isValid: Formz.validate([email, password]),
      status: FormzSubmissionStatus.success,
    ));
  }
}
