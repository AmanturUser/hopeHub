part of 'onboarding_bloc.dart';

class OnboardingState extends Equatable {
  OnboardingState({
    this.status = FormStatus.pure,
    this.statusToken = FormStatus.pure,
    this.message=const RemoteMessage()
});

  final FormStatus status;
  final FormStatus statusToken;
  final RemoteMessage message;

OnboardingState copyWith({
  FormStatus? status,
  FormStatus? statusToken,
  RemoteMessage? message
}

    ) {
  return OnboardingState(
    status: status ?? this.status,
    statusToken: statusToken ?? this.statusToken,
    message: message ?? this.message,
  );
}

  @override
  List<Object> get props => [
    status,
    statusToken,
    message
  ];
}