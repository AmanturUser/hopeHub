import 'package:flutter/material.dart';
import 'package:hope_hub/core/const/const.dart';
import 'package:hope_hub/core/const/userData.dart';
import 'package:hope_hub/core/style/app_colors.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  final String discussionId;
  final String title;
  final String token;
  final String currentUserId;

  const ChatScreen({
    Key? key,
    required this.discussionId,
    required this.title,
    required this.token,
    required this.currentUserId,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();

  late IO.Socket socket;
  bool _isConnected = false;
  bool _mounted = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _connectToServer();
  }

  void _safeSetState(VoidCallback fn) {
    if (_mounted && mounted) {
      setState(fn);
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent+100,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _connectToServer() {
    try {
      socket = IO.io(
        ApiUrl.baseUrlSocket,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect().setPath('/socket')
            .enableForceNew()
            .setQuery({
              'token': widget.token,
            })
            .setTimeout(60000)
            .build(),
      );

      // Подключаем обработчики событий
      socket.onConnect((_) {
        print('Connected to server');
        _safeSetState(() => _isConnected = true);
        _joinDiscussion();
      });

      socket.on('load messages', (data) {
        if (_mounted && mounted) {
          _safeSetState(() {
            _messages.clear();
            print(data);
            for (var msgData in data) {
              _messages.add(ChatMessage(
                id: msgData['message']['_id'],
                content: msgData['message']['content'],
                authorId: msgData['author']['_id'],
                authorName: msgData['author']['name'],
                authorSchool: msgData['author']['school'],
                authorImage: msgData['author']['imagePath'] ?? '',
                timestamp: DateTime.parse(msgData['message']['createdAt']),
                isMe: msgData['author']['_id'] == UserData.userId,
              ));

            }
            _isLoading = false;
            setState(() {

            });
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollToBottom();
            });
          });
        }
      });

      socket.onConnectError((data) {
        print('Connect Error: $data');
        _safeSetState(() => _isConnected = false);
      });

      socket.onDisconnect((_) {
        print('Disconnected from server');
        _safeSetState(() => _isConnected = false);
      });

      socket.on('new message', (data) {
        if (_mounted && mounted) {
          _safeSetState(() {
            final message = ChatMessage.fromJson(data, UserData.userId);
            _messages.add(message);
          });
          _scrollToBottom();
        }
      });

      // Подключаемся к серверу
      socket.connect();
    } catch (e) {
      print('Socket initialization error: $e');
    }
  }

  void _joinDiscussion() {
    if (_isConnected) {
      print('Joining discussion: ${widget.discussionId}');
      socket.emit('join discussion', widget.discussionId);
    }
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty && _isConnected) {
      final message = _messageController.text;
      socket.emit('new message', {
        'discussionId': widget.discussionId,
        'content': message,
      });
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    _mounted = false; // Устанавливаем флаг перед отключением сокета

    // Отключаем все слушатели событий
    socket.off('connect');
    socket.off('connect_error');
    socket.off('disconnect');
    socket.off('new message');

    // Покидаем обсуждение
    if (_isConnected) {
      socket.emit('leave discussion', widget.discussionId);
    }

    // Отключаем сокет
    socket.disconnect();
    socket.dispose();

    // Освобождаем ресурсы
    _messageController.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Корректно отключаемся при нажатии кнопки "назад"
        if (_isConnected) {
          socket.emit('leave discussion', widget.discussionId);
          socket.disconnect();
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              socket.emit('leave discussion', widget.discussionId);
              socket.disconnect();
              Navigator.of(context).pop();
            },
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (!_isConnected)
                const Text(
                  'Переподключение...',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              height: 2,
              color: const Color(0xFF9BA878),
            ),
          ),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            :Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return _buildMessageBubble(message);
                },
              ),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Column(
          crossAxisAlignment:
              message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (!message.isMe)
              Padding(
                padding: const EdgeInsets.only(left: 48, bottom: 4),
                child: Text(
                  '${message.authorName}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!message.isMe)
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: message.authorImage.isNotEmpty
                          ? NetworkImage(
                              '${ApiUrl.baseUrl}/${message.authorImage}')
                          : AssetImage('assets/icons/avatar.png'),
                      backgroundColor: Color(0xFFFFD699),
                    ),
                  ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: message.isMe
                          ? AppColors.mainGreen
                          : const Color(0xFFEEEBCE),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.content,
                          style: TextStyle(
                            color: message.isMe ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatTime(message.timestamp),
                          style: TextStyle(
                            fontSize: 10,
                            color: message.isMe
                                ? Colors.white.withOpacity(0.7)
                                : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _messageController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFFEEEBCE),
                hintText: 'Сообщение...',
              ),
              enabled: _isConnected,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Color(0xFF9BA878)),
            onPressed: _isConnected ? _sendMessage : null,
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String id;
  final String content;
  final String authorId;
  final String authorName;
  final String authorSchool;
  final String authorImage;
  final DateTime timestamp;
  final bool isMe;

  ChatMessage({
    required this.id,
    required this.content,
    required this.authorId,
    required this.authorName,
    required this.authorSchool,
    required this.authorImage,
    required this.timestamp,
    required this.isMe,
  });

  factory ChatMessage.fromJson(
      Map<String, dynamic> json, String currentUserId) {
    return ChatMessage(
      id: json['message']['_id'],
      content: json['message']['content'],
      authorId: json['author']['_id'],
      authorName: json['author']['name'],
      authorSchool: json['author']['school'],
      authorImage: json['author']['imagePath'] ?? '',
      timestamp: DateTime.parse(json['message']['createdAt']),
      isMe: json['author']['_id'] == currentUserId,
    );
  }
}
