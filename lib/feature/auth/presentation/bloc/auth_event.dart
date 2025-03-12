part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class ResetEvent extends AuthEvent {
  const ResetEvent();

  @override
  List<Object> get props => [];
}

class SignInEvent extends AuthEvent {
  final String email;
  const SignInEvent({
    required this.email
  });

  @override
  List<Object> get props => [email];
}

class OtpEvent extends AuthEvent {
  final String otp;
  const OtpEvent({
    required this.otp
  });

  @override
  List<Object> get props => [otp];
}

class RegisterFirstEvent extends AuthEvent {
  final String name;
  final String surname;
  const RegisterFirstEvent({
    required this.name,
    required this.surname
  });

  @override
  List<Object> get props => [name,surname];
}

class GetClassesEvent extends AuthEvent {
  final Success selectedSchool;
  const GetClassesEvent({
    required this.selectedSchool
  });

  @override
  List<Object> get props => [selectedSchool];
}

class RegisterDoneEvent extends AuthEvent {
  final String classId;
  const RegisterDoneEvent({
    required this.classId
  });

  @override
  List<Object> get props => [classId];
}
