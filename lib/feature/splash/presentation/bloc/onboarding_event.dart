part of 'onboarding_bloc.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object> get props => [];
}

class CheckOnboard extends OnboardingEvent {
  const CheckOnboard();

  @override
  List<Object> get props => [];
}

class ResetOnboard extends OnboardingEvent {
  const ResetOnboard();

  @override
  List<Object> get props => [];
}

class NotificationMessage extends OnboardingEvent {
  final RemoteMessage message;
  const NotificationMessage(this.message);

  @override
  List<Object> get props => [];
}
