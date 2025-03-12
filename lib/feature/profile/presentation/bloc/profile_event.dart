part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfileEvent extends ProfileEvent {
  const GetProfileEvent();

  @override
  List<Object> get props => [];
}

class DeleteAccountEvent extends ProfileEvent {
  const DeleteAccountEvent();

  @override
  List<Object> get props => [];
}

class ResetProfileEvent extends ProfileEvent {
  const ResetProfileEvent();

  @override
  List<Object> get props => [];
}

class EditProfileEvent extends ProfileEvent {
  EditProfileEvent({required this.name,required this.surname,required this.classUser});
  String name;
  String surname;
  ClassUser classUser;

  @override
  List<Object> get props => [name, surname, classUser];
}

class ProfileImageChanged extends ProfileEvent {
  const ProfileImageChanged(this.value);

  final XFile value;

  @override
  List<Object> get props => [value];
}
