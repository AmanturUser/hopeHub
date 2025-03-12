part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  const NotificationState({
    this.status = FormStatus.pure,
    this.statusLoadMore = FormStatus.pure,
    this.statusRemote = FormStatus.pure,
    this.page = 0,
    this.totalPage = 0,
    this.notifications = const [],
  });

  final FormStatus status;
  final FormStatus statusLoadMore;
  final FormStatus statusRemote;
  final List<Notifications> notifications;
  final int page;
  final int totalPage;

  NotificationState copyWith({
    FormStatus? status,
    FormStatus? statusLoadMore,
    FormStatus? statusRemote,
    List<Notifications>? notifications,
    int? page,
    int? totalPage,
  }) {
    return NotificationState(
      status: status ?? this.status,
      statusLoadMore: statusLoadMore ?? this.statusLoadMore,
      statusRemote: statusRemote ?? this.statusRemote,
      notifications: notifications ?? this.notifications,
      page: page ?? this.page,
      totalPage: totalPage ?? this.totalPage,
    );
  }

  @override
  List<Object> get props => [
        status,
        statusLoadMore,
        statusRemote,
        notifications,
        page,
        totalPage,
      ];
}
