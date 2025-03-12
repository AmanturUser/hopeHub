part of 'discussion_bloc.dart';

class DiscussionState extends Equatable {
  const DiscussionState({
    this.status = FormStatus.pure,
    this.connectStatus = FormStatus.pure,
    this.messages = const {}
  });

  final FormStatus status;
  final FormStatus connectStatus;
  final Map<String,List<ChatMessage>> messages;

  DiscussionState copyWith({
    FormStatus? status,
    FormStatus? connectStatus,
    Map<String,List<ChatMessage>>? messages,
  }) {
    return DiscussionState(
        status: status ?? this.status,
        connectStatus: connectStatus ?? this.connectStatus,
        messages: messages ?? this.messages,
    );
  }

  @override
  List<Object> get props => [
    status,
    connectStatus,
    messages
  ];
}