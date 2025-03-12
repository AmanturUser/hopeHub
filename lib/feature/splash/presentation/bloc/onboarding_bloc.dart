import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hope_hub/core/const/form_status.dart';
import 'package:hope_hub/core/const/userData.dart';

import '../../../../core/apiService/apiService.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final storage = const FlutterSecureStorage();
  OnboardingBloc() : super(OnboardingState()) {
    on<CheckOnboard>(_checkOnboard);
    on<ResetOnboard>(_resetOnboard);
    on<NotificationMessage>(_notificationMessage);
  }

  _checkOnboard(CheckOnboard event, Emitter emit) async {
    String? onboard=await storage.read(key: 'onboard');
    String? token=await storage.read(key: 'token');
    String? userId=await storage.read(key: 'userId');
    if(onboard!=null){
      if(token!=null){
        UserData.token=token;
        UserData.userId=userId!;
        if(UserData.fcmToken!=''){
          await ApiService().post('/auth/fcmTokenSet', {"fcmToken" : UserData.fcmToken});
        }
        emit(state.copyWith(status: FormStatus.submissionSuccess,statusToken: FormStatus.submissionSuccess));
      }else{
        emit(state.copyWith(status: FormStatus.submissionSuccess,statusToken: FormStatus.submissionFailure));
      }
    }else{
      emit(state.copyWith(status: FormStatus.submissionFailure));
    }
  }

  _resetOnboard(ResetOnboard event, Emitter emit) async {
    emit(state.copyWith(status: FormStatus.pure));
  }

  _notificationMessage(NotificationMessage event, Emitter emit) async {
    emit(state.copyWith(message: event.message));
  }
}
