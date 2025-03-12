part of 'action_bloc.dart';

class ActionState extends Equatable {
  const ActionState({
    this.status = FormStatus.pure,
    this.statusSurvey = FormStatus.pure,
    this.surveys = const [],
    this.events = const [],
    this.schoolDiscussions = const [],
    this.globalDiscussions = const [],
  });

  final FormStatus status;
  final FormStatus statusSurvey;
  final List<Surveys> surveys;
  final List<Events> events;
  final List<Discussion> schoolDiscussions;
  final List<Discussion> globalDiscussions;

  ActionState copyWith({
    FormStatus? status,
    FormStatus? statusSurvey,
    List<Surveys>? surveys,
    List<Events>? events,
    List<Discussion>? schoolDiscussions,
    List<Discussion>? globalDiscussions
  }) {
    return ActionState(
      status: status ?? this.status,
      statusSurvey: statusSurvey ?? this.statusSurvey,
      surveys: surveys ?? this.surveys,
      events: events ?? this.events,
      schoolDiscussions: schoolDiscussions ?? this.schoolDiscussions,
      globalDiscussions: globalDiscussions ?? this.globalDiscussions

    );
  }

  @override
  List<Object> get props => [
    status,
    statusSurvey,
    surveys,
    events,
    schoolDiscussions,
    globalDiscussions
  ];
}