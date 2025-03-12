part of 'profile_bloc.dart';


class ProfileState extends Equatable {
  const ProfileState({
    this.status = FormStatus.pure,
    this.statusEdit = FormStatus.pure,
    this.statusEditInfo = FormStatus.pure,
    this.statusDelete = FormStatus.pure,
    this.profiles = const []
  });

  final FormStatus status;
  final FormStatus statusEdit;
  final FormStatus statusEditInfo;
  final FormStatus statusDelete;
  final List<ProfileModel> profiles;

  ProfileState copyWith({
    FormStatus? status,
    FormStatus? statusEdit,
    FormStatus? statusEditInfo,
    FormStatus? statusDelete,
    List<ProfileModel>? profiles,
  }) {
    return ProfileState(
      status: status ?? this.status,
      statusEdit: statusEdit ?? this.statusEdit,
      statusEditInfo: statusEditInfo ?? this.statusEditInfo,
      statusDelete: statusDelete ?? this.statusDelete,
      profiles: profiles ?? this.profiles,
    );
  }

  @override
  List<Object> get props => [
    status,
    statusEdit,
    statusEditInfo,
    statusDelete,
    profiles
  ];
}