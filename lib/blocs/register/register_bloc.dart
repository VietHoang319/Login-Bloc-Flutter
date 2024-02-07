import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:test_login/blocs/register/register_event.dart';
import 'package:test_login/blocs/register/register_state.dart';
import 'package:test_login/models/formz/birthday.dart';
import 'package:test_login/models/formz/email.dart';
import 'package:test_login/models/formz/gender.dart';
import 'package:test_login/models/formz/office_code.dart';
import 'package:test_login/models/formz/username.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<NextStepChanged>(_onNextStepChange);
    on<OfficeCodeChanged>(_onOfficeCodeChanged);
    on<UsernameChanged>(_onUsernameChanged);
    on<EmailChanged>(_onEmailChange);
    on<BirthdayChanged>(_onBirthdayChanged);
    on<GenderChanged>(_onGenderChange);
    on<NotificationFlagChanged>(_onNotificationFlagChanged);
  }

  void _onNextStepChange(NextStepChanged event, Emitter<RegisterState> emit) {
    final step = event.step;

    if (state.step == 1) {
      final officeCode = OfficeCode.dirty(state.officeCode.value);

      emit(
        state.copyWith(
          step: Formz.validate([officeCode]) ? step : state.step,
          isValid: Formz.validate([officeCode]),
          status: FormzSubmissionStatus.initial,
          officeCode: officeCode,
        ),
      );
    }
    if (state.step == 2) {
      emit(
        state.copyWith(
          step: step,
          isValid: Formz.validate([state.username, state.email, state.birthday, state.gender]),
          status: FormzSubmissionStatus.initial,
        ),
      );
    }
  }

  void _onOfficeCodeChanged(
      OfficeCodeChanged event, Emitter<RegisterState> emit) {
    final officeCode = OfficeCode.dirty(event.officeCode);

    emit(
      state.copyWith(
        officeCode:
            officeCode.isValid ? officeCode : OfficeCode.pure(event.officeCode),
        isValid: Formz.validate([officeCode]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void _onUsernameChanged(UsernameChanged event, Emitter<RegisterState> emit) {
    final username = Username.dirty(event.username);

    emit(state.copyWith(
      username: username.isValid ? username : Username.pure(event.username),
      isValid: Formz.validate([username, state.email, state.birthday, state.gender]),
      status: FormzSubmissionStatus.initial,
    ));
  }

  void _onEmailChange(EmailChanged event, Emitter<RegisterState> emit) {
    final email = Email.dirty(event.email);

    emit(
      state.copyWith(
        email: email.isValid ? email : Email.pure(event.email),
        isValid: Formz.validate([state.username, email, state.birthday, state.gender]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void _onBirthdayChanged(BirthdayChanged event, Emitter<RegisterState> emit) {
    final birthday = Birthday.dirty(event.birthday);

    emit(state.copyWith(
      birthday: birthday.isValid ? birthday : Birthday.pure(event.birthday),
      isValid: Formz.validate([state.username, state.email, birthday, state.gender]),
      status: FormzSubmissionStatus.initial,
    ));
  }

  void _onGenderChange(GenderChanged event, Emitter<RegisterState> emit) {
    final gender = Gender.dirty(event.gender);

    emit(state.copyWith(
      gender: gender.isValid ? gender : Gender.pure(event.gender),
      isValid: Formz.validate([state.username, state.email, state.birthday, gender]),
      status: FormzSubmissionStatus.initial,
    ));
  }

  void _onNotificationFlagChanged(
      NotificationFlagChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(
      notificationFlag: event.notificationFlag,
      status: FormzSubmissionStatus.initial,
    ));
  }
}
