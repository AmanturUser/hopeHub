part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class GetDashboardEvent extends DashboardEvent {
  const GetDashboardEvent();

  @override
  List<Object> get props => [];
}

class IdeaSubmissionEvent extends DashboardEvent {
  const IdeaSubmissionEvent({required this.name, required this.description});

  final String name;
  final String description;


  @override
  List<Object> get props => [
    name,
    description
  ];
}

class SurveySubmitEvent extends DashboardEvent {
  const SurveySubmitEvent({required this.survey});

  final UserSurveys survey;


  @override
  List<Object> get props => [
    survey
  ];
}