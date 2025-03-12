import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hope_hub/feature/rating/data_source/rating_server.dart';
import 'package:hope_hub/feature/rating/domain/rating_schools_model.dart';

import '../../../../core/const/form_status.dart';
import '../../domain/rating_model.dart';

part 'rating_event.dart';

part 'rating_state.dart';

class RatingBloc extends Bloc<RatingEvent, RatingState> {
  RatingBloc() : super(const RatingState()) {
    on<GetRatingEvent>(_getRating);
    on<ResetRatingEvent>(_resetRating);
    on<LoadMoreEvent>(_loadMore);
    on<ChangeRatingEvent>(_changeRating);
    on<UserRatingUpEvent>(_userRatingUp);
  }

  _getRating(GetRatingEvent event, Emitter emit) async {
    emit(state.copyWith(status: FormStatus.submissionInProgress));
    try {
      RatingModel rating = await getRatings(1);
      RatingSchoolsModel ratingSchools = await getRatingSchools(1);
      emit(state.copyWith(
        status: FormStatus.submissionSuccess,
        name: rating.name,
        surname: rating.surname,
        photo: rating.photo,
        rating: rating.rating,
        users: rating.users,
        page: rating.currentPage,
        totalPage: rating.totalPages,
        sId: ratingSchools.sId,
        schoolName: ratingSchools.userSchoolName,
        schoolRating: ratingSchools.userSchoolRating,
        schoolPage: ratingSchools.currentPage,
        totalSchoolPage: ratingSchools.totalPages,
        schools: ratingSchools.schools
      ));
    } catch (e) {
      emit(state.copyWith(status: FormStatus.submissionFailure));
    }
  }

  _getRating2(GetRatingEvent event, Emitter emit) async {
    emit(state.copyWith(status: FormStatus.submissionInProgress));
    try {
      RatingModel rating = await getRatings(1);
      emit(state.copyWith(
          status: FormStatus.submissionSuccess,
          name: rating.name,
          surname: rating.surname,
          photo: rating.photo,
          rating: rating.rating,
          users: rating.users,
          page: rating.currentPage,
          totalPage: rating.totalPages));
    } catch (e) {
      emit(state.copyWith(status: FormStatus.submissionFailure));
    }
  }

  _loadMore(LoadMoreEvent event, Emitter emit) async {
    if (state.page < state.totalPage) {
      emit(state.copyWith(statusLoadMore: FormStatus.submissionInProgress));
      try {
        if(event.userOrSchool){
          RatingModel rating = await getRatings(state.page + 1);
          print([...rating.users!, ...state.users].length);
          emit(state.copyWith(
              statusLoadMore: FormStatus.submissionSuccess,
              users: [...state.users, ...rating.users!],
              page: rating.currentPage,
              totalPage: rating.totalPages));
        }else{
          RatingSchoolsModel ratingSchool = await getRatingSchools(state.schoolPage + 1);
          print([...ratingSchool.schools!, ...state.schools].length);
          emit(state.copyWith(
              statusLoadMore: FormStatus.submissionSuccess,
              schools: [...state.schools, ...ratingSchool.schools!],
              schoolPage: ratingSchool.currentPage,
              totalSchoolPage: ratingSchool.totalPages));
        }

      } catch (e) {
        emit(state.copyWith(statusLoadMore: FormStatus.submissionFailure));
      }
    }
  }

  _resetRating(ResetRatingEvent event, Emitter emit) async {
    emit(state.copyWith(status: FormStatus.pure));
  }

  _changeRating(ChangeRatingEvent event, Emitter emit) async {
    emit(state.copyWith(userOrSchool: event.userOrSchool));
  }

  _userRatingUp(UserRatingUpEvent event, Emitter emit) async {
    emit(state.copyWith(rating: event.rating));
  }
}
