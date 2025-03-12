part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  const DashboardState({
    this.status = FormStatus.pure,
    this.statusIdea = FormStatus.pure,
    this.userName = '',
    this.ideas = const [],
    this.projects = const [],
    this.userSurveys = const [],
  });

  final FormStatus status;
  final FormStatus statusIdea;
  final String userName;
  final List<Ideas> ideas;
  final List<Projects> projects;
  final List<UserSurveys> userSurveys;

  DashboardState copyWith({
    FormStatus? status,
    FormStatus? statusIdea,
    String? userName,
    List<Ideas>? ideas,
    List<Projects>? projects,
    List<UserSurveys>? userSurveys
  }) {
    return DashboardState(
      status: status ?? this.status,
      statusIdea: statusIdea ?? this.statusIdea,
      userName: userName ?? this.userName,
      ideas: ideas ?? this.ideas,
      projects: projects ?? this.projects,
      userSurveys: userSurveys ?? this.userSurveys,
    );
  }

  @override
  List<Object> get props => [
    status,
    statusIdea,
    userName,
    projects,
    ideas,
    userSurveys
  ];
}
