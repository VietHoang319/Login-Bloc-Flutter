import 'package:equatable/equatable.dart';

class RegisterEvent extends Equatable {
  const RegisterEvent();

  List<Object> get props => [];
}

final class NextStepChanged extends RegisterEvent {
  final int step;

  const NextStepChanged(this.step);

  @override
  List<Object> get props => [step];
}

final class BackStepChanged extends RegisterEvent {
  final int step;

  const BackStepChanged(this.step);

  @override
  List<Object> get props => [step];
}

final class OfficeCodeChanged extends RegisterEvent {
  final String officeCode;

  const OfficeCodeChanged(this.officeCode);

  @override
  List<Object> get props => [officeCode];
}

final class UsernameChanged extends RegisterEvent {
  final String username;

  const UsernameChanged(this.username);

  @override
  List<Object> get props => [username];
}

final class EmailChanged extends RegisterEvent {
  final String email;

  const EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

final class BirthdayChanged extends RegisterEvent {
  final DateTime birthday;

  const BirthdayChanged(this.birthday);

  @override
  List<Object> get props => [birthday];
}

final class GenderChanged extends RegisterEvent {
  final String gender;

  const GenderChanged(this.gender);

  @override
  List<Object> get props => [gender];
}

final class NotificationFlagChanged extends RegisterEvent {
  final bool notificationFlag;

  const NotificationFlagChanged(this.notificationFlag);

  @override
  List<Object> get props => [notificationFlag];
}