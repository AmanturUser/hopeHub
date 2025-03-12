part of 'discussion_bloc.dart';

abstract class DiscussionEvent extends Equatable {
  const DiscussionEvent();

  @override
  List<Object> get props => [];
}


class ConnectSocketEvent extends DiscussionEvent {
  const ConnectSocketEvent();

  @override
  List<Object> get props => [];
}

class LoadMessagesEvent extends DiscussionEvent {
  const LoadMessagesEvent();

  @override
  List<Object> get props => [];
}

class JoinDiscussionEvent extends DiscussionEvent {
  final String discussionId;
  const JoinDiscussionEvent(this.discussionId);

  @override
  List<Object> get props => [discussionId];
}