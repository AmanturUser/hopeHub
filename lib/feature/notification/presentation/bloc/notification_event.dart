part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class GetNotificationEvent extends NotificationEvent {
  const GetNotificationEvent();

  @override
  List<Object> get props => [];
}

class GetNotificationRemoteEvent extends NotificationEvent {
  const GetNotificationRemoteEvent();

  @override
  List<Object> get props => [];
}

class LoadMoreEvent extends NotificationEvent {
  const LoadMoreEvent();

  @override
  List<Object> get props => [];
}

class ResetNotificationEvent extends NotificationEvent {
  const ResetNotificationEvent();

  @override
  List<Object> get props => [];
}