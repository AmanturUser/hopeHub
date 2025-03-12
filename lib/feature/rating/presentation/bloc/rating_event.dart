part of 'rating_bloc.dart';

abstract class RatingEvent extends Equatable {
  const RatingEvent();

  @override
  List<Object> get props => [];
}

class GetRatingEvent extends RatingEvent {
  const GetRatingEvent();

  @override
  List<Object> get props => [];
}

class LoadMoreEvent extends RatingEvent {
  final bool userOrSchool;
  const LoadMoreEvent(this.userOrSchool);

  @override
  List<Object> get props => [userOrSchool];
}

class ResetRatingEvent extends RatingEvent {
  const ResetRatingEvent();

  @override
  List<Object> get props => [];
}

class ChangeRatingEvent extends RatingEvent {
  const ChangeRatingEvent({required this.userOrSchool});

  final bool userOrSchool;

  @override
  List<Object> get props => [userOrSchool];
}

class UserRatingUpEvent extends RatingEvent {
  const UserRatingUpEvent(this.rating);
  final int rating;

  @override
  List<Object> get props => [];
}