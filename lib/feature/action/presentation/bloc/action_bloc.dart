import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hope_hub/feature/action/data_source/action_server.dart';

import '../../../../core/const/form_status.dart';
import '../../domain/action_model.dart';

part 'action_event.dart';
part 'action_state.dart';

class ActionBloc extends Bloc<ActionEvent, ActionState> {
  ActionBloc() : super(const ActionState()) {
    on<ResetEvent>(_reset);
    on<GetActionsEvent>(_getSurveysEvent);
    on<SubmitSurveyEvent>(_submitSurveyEvent);
  }

  _reset(ResetEvent event, Emitter emit) async {
    emit(state.copyWith(status: FormStatus.pure,statusSurvey: FormStatus.pure));
  }

  _getSurveysEvent(GetActionsEvent event, Emitter emit) async {
    emit(state.copyWith(status: FormStatus.submissionInProgress));
    try {
      ActionsModel actions = await getSurveysAction();
      emit(state.copyWith(status: FormStatus.submissionSuccess,surveys: actions.surveys,events: actions.events,schoolDiscussions: actions.schoolDiscussions,globalDiscussions: actions.globalDiscussions));
    } catch (e) {
      emit(state.copyWith(status: FormStatus.submissionFailure));
    }
  }

  _submitSurveyEvent(SubmitSurveyEvent event, Emitter emit) async {
    emit(state.copyWith(statusSurvey: FormStatus.submissionInProgress));
    try {
      var data={
        "id" : event.surveyId,
        "selectedOption" : event.selectOption
      };
      var res = await surveySubmit(data);
      if (res) {
        var surveys=state.surveys;
        surveys.removeWhere((survey) => survey.sId == event.surveyId);
        emit(state.copyWith(statusSurvey: FormStatus.submissionSuccess,surveys: surveys));
      } else {
        emit(state.copyWith(statusSurvey: FormStatus.submissionFailure));
      }
    } catch (e) {
      emit(state.copyWith(statusSurvey: FormStatus.submissionFailure));
    }
  }
}
