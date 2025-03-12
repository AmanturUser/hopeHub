import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hope_hub/core/const/userData.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import '../../../../core/const/form_status.dart';
import '../../data_source/profile_server.dart';
import '../../domain/profile_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<GetProfileEvent>(_getProfile);
    on<ResetProfileEvent>(_resetProfile);
    on<ProfileImageChanged>(_changeProfileImage);
    on<EditProfileEvent>(_profileEdit);
    on<DeleteAccountEvent>(_delete);
  }

  _getProfile(GetProfileEvent event, Emitter emit) async {
    emit(state.copyWith(status: FormStatus.submissionInProgress));
    try {
      ProfileModel profile = await getProfile();
      print('get2 $profile');
      List<ProfileModel> profiles=[profile];
      emit(state.copyWith(status: FormStatus.submissionSuccess,profiles: profiles));
    } catch (e) {
      emit(state.copyWith(status: FormStatus.submissionFailure));
    }
  }

  _delete(DeleteAccountEvent event, Emitter emit) async {
    emit(state.copyWith(statusDelete: FormStatus.submissionInProgress));
    try {
      bool deleteIs = await deleteAccount();
      if(deleteIs){
        emit(state.copyWith(statusDelete: FormStatus.submissionSuccess));
      }else{
        emit(state.copyWith(statusDelete: FormStatus.submissionFailure));
      }
    } catch (e) {
      emit(state.copyWith(statusDelete: FormStatus.submissionFailure));
    }
  }

  _resetProfile(ResetProfileEvent event, Emitter emit) async {
    emit(state.copyWith(status: FormStatus.pure,statusEdit: FormStatus.pure,statusEditInfo:FormStatus.pure));
  }

  _changeProfileImage(ProfileImageChanged event, Emitter emit) async {
    emit(state.copyWith(statusEdit: FormStatus.submissionInProgress));
    try {
      /*var data= await MultipartFile.fromPath(
        'image',           // имя поля
        event.value.path,       // путь к файлу
        filename: event.value.name,  // имя файла
        contentType: MediaType('image', 'jpeg'), // тип контента
      );
      final formData = FormData.fromMap({
        'image': data,
      });*/
      var res = await changeProfileImage(event.value);
      if (res) {
        emit(state.copyWith(statusEdit: FormStatus.submissionSuccess));
      } else {
        emit(state.copyWith(statusEdit: FormStatus.submissionFailure));
      }
    } catch (e) {
      emit(state.copyWith(statusEdit: FormStatus.submissionFailure));
    }
  }

  _profileEdit(EditProfileEvent event, Emitter emit) async {
    emit(state.copyWith(statusEditInfo: FormStatus.submissionInProgress));
    try {
      var json={
        "name" : event.name,
        "surname" : event.surname,
        "classId" : event.classUser.id,
        "fcmToken" : UserData.fcmToken
      };
      bool res = await editProfile(json);
      if (res) {
        ProfileModel profileTemp=state.profiles.first;
        profileTemp.name=event.name;
        profileTemp.surname=event.surname;
        profileTemp.classUser=event.classUser;
        emit(state.copyWith(statusEditInfo: FormStatus.submissionSuccess, profiles: [profileTemp]));
      } else {
        emit(state.copyWith(statusEditInfo: FormStatus.submissionFailure));
      }
    } catch (e) {
      emit(state.copyWith(statusEditInfo: FormStatus.submissionFailure));
    }
  }
}
