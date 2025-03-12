import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hope_hub/feature/notification/data_source/notification_server.dart';
import 'package:hope_hub/feature/notification/domain/notification_model.dart';
import '../../../../core/const/form_status.dart';

part 'notification_event.dart';

part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(const NotificationState()) {
    on<GetNotificationEvent>(_getNotifications);
    on<ResetNotificationEvent>(_resetNotification);
    on<LoadMoreEvent>(_loadMore);
    on<GetNotificationRemoteEvent>(_getNotificationsRemote);
  }

  _getNotifications(GetNotificationEvent event, Emitter emit) async {
    emit(state.copyWith(status: FormStatus.submissionInProgress));
    try {
      NotificationModel notificationModel = await getNotifications(1);
      emit(state.copyWith(
          status: FormStatus.submissionSuccess,
          notifications: notificationModel.notifications,
        page: notificationModel.page,
        totalPage: notificationModel.pages,
      ));
    } catch (e) {
      emit(state.copyWith(status: FormStatus.submissionFailure));
    }
  }

  _getNotificationsRemote(GetNotificationRemoteEvent event, Emitter emit) async {
    emit(state.copyWith(statusRemote: FormStatus.submissionInProgress));
    try {
      NotificationModel notificationModel = await getNotifications(1);
      emit(state.copyWith(
        statusRemote: FormStatus.submissionSuccess,
        notifications: notificationModel.notifications,
        page: notificationModel.page,
        totalPage: notificationModel.pages,
      ));
    } catch (e) {
      emit(state.copyWith(statusRemote: FormStatus.submissionFailure));
    }
  }

  _loadMore(LoadMoreEvent event, Emitter emit) async {
    if (state.page < state.totalPage) {
      emit(state.copyWith(statusLoadMore: FormStatus.submissionInProgress));
      try {
        NotificationModel notificationModel = await getNotifications(state.page + 1);
        print([...notificationModel.notifications!, ...state.notifications].length);
        emit(state.copyWith(
            statusLoadMore: FormStatus.submissionSuccess,
            notifications: [...state.notifications, ...notificationModel.notifications!],
            page: notificationModel.page,
            totalPage: notificationModel.pages));
      } catch (e) {
        emit(state.copyWith(statusLoadMore: FormStatus.submissionFailure));
      }
    }
  }

  _resetNotification(ResetNotificationEvent event, Emitter emit) async {
    emit(state.copyWith(status: FormStatus.pure));
  }
}
