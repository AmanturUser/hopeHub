import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hope_hub/feature/dashboard/data_source/dashboard_server.dart';
import 'package:hope_hub/feature/dashboard/domain/dashboard_model.dart';

import '../../../../core/const/form_status.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardState()) {
    on<GetDashboardEvent>(_getDashboard);
    on<IdeaSubmissionEvent>(_ideaSubmission);
    on<SurveySubmitEvent>(_surveySubmit);
  }

  _getDashboard(GetDashboardEvent event, Emitter emit) async {
    emit(state.copyWith(status: FormStatus.submissionInProgress));
    try {
      DashboardModel dashboard = await getUserDashboard();
      emit(state.copyWith(
          status: FormStatus.submissionSuccess,
          userName: dashboard.userName,
          ideas: dashboard.ideas,
          projects: dashboard.projects,
          userSurveys: dashboard.userSurveys));
    } catch (e) {
      emit(state.copyWith(status: FormStatus.submissionFailure));
    }
  }

  _ideaSubmission(IdeaSubmissionEvent event, Emitter emit) async {
    emit(state.copyWith(statusIdea: FormStatus.submissionInProgress));
    try {
      var data = {"name": event.name, "description": event.description};
      var res = await ideaSubmission(data);
      if (res) {
        emit(state.copyWith(statusIdea: FormStatus.submissionSuccess, ideas: [
          ...state.ideas,
          Ideas(sId: '', name: event.name, description: event.description)
        ]));
      } else {
        emit(state.copyWith(statusIdea: FormStatus.submissionFailure));
      }
    } catch (e) {
      emit(state.copyWith(statusIdea: FormStatus.submissionFailure));
    }
  }

  _surveySubmit(SurveySubmitEvent event, Emitter emit) async {
    emit(state.copyWith(status: FormStatus.pure, userSurveys: [
      ...state.userSurveys,
      event.survey
    ]));
  }
}
