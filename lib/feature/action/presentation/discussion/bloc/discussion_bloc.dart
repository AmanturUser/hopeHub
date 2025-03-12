import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hope_hub/core/const/userData.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../../../core/const/const.dart';
import '../../../../../core/const/form_status.dart';
import '../chat/chat.dart';

part 'discussion_event.dart';
part 'discussion_state.dart';

class DiscussionBloc extends Bloc<DiscussionEvent, DiscussionState> {
  late IO.Socket socket;
  DiscussionBloc() : super(const DiscussionState()) {
    on<ConnectSocketEvent>(_connectSocket);
    on<JoinDiscussionEvent>(_joinDiscussion);
    on<LoadMessagesEvent>(_loadMessages);
  }

  _connectSocket(ConnectSocketEvent event, Emitter emit) async {
    emit(state.copyWith(connectStatus: FormStatus.submissionInProgress));
    socket = IO.io(
      ApiUrl.baseUrlSocket,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect().setPath('/socket')
          .enableForceNew()
          .setQuery({
        'token': UserData.token,
      })
          .setTimeout(60000)
          .build(),
    );
    socket.onConnect((_) {
      print('Connected to server');
      emit(state.copyWith(connectStatus: FormStatus.submissionSuccess));
    });
    socket.onConnectError((data) {
      print('Connect Error: $data');
      emit(state.copyWith(connectStatus: FormStatus.submissionFailure));
    });
  }
  _joinDiscussion(JoinDiscussionEvent event, Emitter emit) async {
    emit(state.copyWith(connectStatus: FormStatus.submissionInProgress));
    socket = IO.io(
      ApiUrl.baseUrlSocket,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect().setPath('/socket')
          .enableForceNew()
          .setQuery({
        'token': UserData.token,
      })
          .setTimeout(60000)
          .build(),
    );
    socket.onConnect((_) {
      print('Connected to server');
      emit(state.copyWith(connectStatus: FormStatus.submissionSuccess));
    });
    socket.onConnectError((data) {
      print('Connect Error: $data');
      emit(state.copyWith(connectStatus: FormStatus.submissionFailure));
    });
  }
  _loadMessages(LoadMessagesEvent event, Emitter emit) async {
    emit(state.copyWith(connectStatus: FormStatus.submissionInProgress));
    socket = IO.io(
      ApiUrl.baseUrlSocket,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect().setPath('/socket')
          .enableForceNew()
          .setQuery({
        'token': UserData.token,
      })
          .setTimeout(60000)
          .build(),
    );
    socket.onConnect((_) {
      print('Connected to server');
      emit(state.copyWith(connectStatus: FormStatus.submissionSuccess));
    });
    socket.onConnectError((data) {
      print('Connect Error: $data');
      emit(state.copyWith(connectStatus: FormStatus.submissionFailure));
    });
  }
}
