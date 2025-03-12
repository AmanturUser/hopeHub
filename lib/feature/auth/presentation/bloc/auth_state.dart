part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({
    this.status = FormStatus.pure,
    this.statusOtp = FormStatus.pure,
    this.statusSendCode = FormStatus.pure,
    this.statusRegister = FormStatus.pure,
    this.userEmail = '',
    this.token = '',
    this.name = '',
    this.surname = '',
    this.schools = const [],
    this.classes = const [],
    this.selectedSchool = const [],
    this.isRegister = false,
});
  final FormStatus status;
  final FormStatus statusOtp;
  final FormStatus statusSendCode;
  final FormStatus statusRegister;
  final String userEmail;
  final String token;
  final String name;
  final String surname;
  final List<Success> schools;
  final List<Success> selectedSchool;
  final List<Success> classes;
  final bool isRegister;

  AuthState copyWith(
  {
    FormStatus? status,
    FormStatus? statusOtp,
    FormStatus? statusSendCode,
    FormStatus? statusRegister,
    String? userEmail,
    String? token,
    String? name,
    String? surname,
    List<Success>? selectedSchool,
    List<Success>? schools,
    List<Success>? classes,
    bool? isRegister,
  }
  ) {
    return AuthState(
      status: status ?? this.status,
      statusOtp: statusOtp ?? this.statusOtp,
      statusRegister: statusRegister ?? this.statusRegister,
      statusSendCode: statusSendCode ?? this.statusSendCode,
      userEmail: userEmail ?? this.userEmail,
      token: token ?? this.token,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      schools: schools ?? this.schools,
      selectedSchool: selectedSchool ?? this.selectedSchool,
      classes: classes ?? this.classes,
      isRegister: isRegister ?? this.isRegister,
    );
  }
  @override
  List<Object> get props => [
    status,
    statusOtp,
    statusRegister,
    statusSendCode,
    userEmail,
    token,
    name,
    surname,
    schools,
    selectedSchool,
    classes,
    isRegister
  ];
}