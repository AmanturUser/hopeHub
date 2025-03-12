import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hope_hub/core/const/userData.dart';
import 'package:hope_hub/feature/auth/domain/model/schoolsModel.dart';

import '../../../../core/apiService/apiService.dart';
import '../../../../core/const/form_status.dart';
import '../../data_source/auth_server.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<ResetEvent>(_reset);
    on<SignInEvent>(_signIn);
    on<OtpEvent>(_otp);
    on<RegisterFirstEvent>(_registerFirst);
    on<GetClassesEvent>(_getClasses);
    on<RegisterDoneEvent>(_registerDone);
  }
  _reset(ResetEvent event, Emitter emit) async {
    emit(state.copyWith(status: FormStatus.pure,statusOtp: FormStatus.pure,statusSendCode: FormStatus.pure,statusRegister: FormStatus.pure));
  }
  _signIn(SignInEvent event, Emitter emit) async {
    emit(state.copyWith(status: FormStatus.submissionInProgress,statusSendCode: FormStatus.submissionInProgress));
    try {
      bool login = await auth({'email' : event.email});
      if (login) {
        emit(state.copyWith(status: FormStatus.submissionSuccess,statusSendCode:FormStatus.submissionSuccess,userEmail: event.email));
      } else {
        emit(state.copyWith(status: FormStatus.submissionFailure,statusSendCode: FormStatus.submissionFailure));
      }
    } catch (e) {
      emit(state.copyWith(status: FormStatus.submissionFailure,statusSendCode: FormStatus.submissionFailure));
    }
  }

  _otp(OtpEvent event, Emitter emit) async {
    emit(state.copyWith(statusOtp: FormStatus.submissionInProgress));
    try {
      var data={
        "email": state.userEmail,
        "otp" : event.otp
      };
      var res = await otpVerification(data);
      if (res['status']) {
        if(!res['isRegister']){
          SchoolsModel schools = SchoolsModel.fromJson(res);
          emit(state.copyWith(statusOtp: FormStatus.submissionSuccess, token: res['token'], isRegister: res['isRegister'],schools: schools.success));
        }else{
          emit(state.copyWith(statusOtp: FormStatus.submissionSuccess, token: res['token'], isRegister: res['isRegister']));
        }
        if(UserData.fcmToken!=''){
          await ApiService().post('/auth/fcmTokenSet', {"fcmToken" : UserData.fcmToken});
        }
      } else {
        emit(state.copyWith(statusOtp: FormStatus.submissionFailure));
      }
    } catch (e) {
      emit(state.copyWith(statusOtp: FormStatus.submissionFailure));
    }
  }

  _registerFirst(RegisterFirstEvent event, Emitter emit) async {
    emit(state.copyWith(name: event.name,surname: event.surname));
  }

  _getClasses(GetClassesEvent event, Emitter emit) async {
    emit(state.copyWith(status: FormStatus.submissionInProgress));
    try {
      var res = await getClasses({'schoolId' : event.selectedSchool.sId});
      if (res['status']) {
        SchoolsModel classes = SchoolsModel.fromJsonClass(res);
        emit(state.copyWith(status: FormStatus.submissionSuccess,classes: classes.classes,selectedSchool: [event.selectedSchool]));
      } else {
        emit(state.copyWith(status: FormStatus.submissionFailure));
      }
    } catch (e) {
      emit(state.copyWith(status: FormStatus.submissionFailure));
    }
  }

  _registerDone(RegisterDoneEvent event, Emitter emit) async {
    emit(state.copyWith(statusRegister: FormStatus.submissionInProgress));
    try {
      var json={
        "name" : state.name,
        "surname" : state.surname,
        "classId" : event.classId,
        "schoolId" : state.selectedSchool.first.sId,
        "fcmToken" : UserData.fcmToken
      };
      bool res = await registerDone(json);
      if (res) {
        emit(state.copyWith(statusRegister: FormStatus.submissionSuccess,isRegister: true));
      } else {
        emit(state.copyWith(statusRegister: FormStatus.submissionFailure));
      }
    } catch (e) {
      emit(state.copyWith(statusRegister: FormStatus.submissionFailure));
    }
  }
}
