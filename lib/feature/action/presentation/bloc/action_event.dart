part of 'action_bloc.dart';

abstract class ActionEvent extends Equatable {
  const ActionEvent();

  @override
  List<Object> get props => [];
}

class GetActionsEvent extends ActionEvent {
  const GetActionsEvent();

  @override
  List<Object> get props => [];
}

class ResetEvent extends ActionEvent {
  const ResetEvent();

  @override
  List<Object> get props => [];
}

class SubmitSurveyEvent extends ActionEvent {
  SubmitSurveyEvent({required this.selectOption, required this.surveyId});

  int selectOption;
  String surveyId;

  @override
  List<Object> get props => [selectOption];
}