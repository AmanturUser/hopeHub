import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hope_hub/core/style/app_colors.dart';

import '../../../core/const/form_status.dart';
import '../../../core/style/app_text_styles.dart';
import 'bloc/notification_bloc.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final _scrollController = ScrollController();
  late NotificationBloc _notificationBloc;



  @override
  void initState() {
    _notificationBloc = context.read<NotificationBloc>();
    _notificationBloc.add(const GetNotificationEvent());
    _scrollController.addListener(() => _onScroll(_scrollController));
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll(ScrollController controller) {
    if (_isBottom(controller)) {
      _notificationBloc.add(const LoadMoreEvent());
    }
  }

  bool _isBottom(ScrollController controller) {
    if (!controller.hasClients) return false;
    final maxScroll = controller.position.maxScrollExtent;
    final currentScroll = controller.offset;
    return currentScroll >=
        maxScroll; // Загружаем новые данные когда долистали до 90%
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0.3,
        title: const Text(
          'Уведомления',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        backgroundColor: const Color(0xFFFFFDEB),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<NotificationBloc>().add(const GetNotificationEvent());
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            children: [
              BlocConsumer<NotificationBloc, NotificationState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                buildWhen: (previous, current) =>
                    previous.status != current.status || previous.statusRemote != current.statusRemote || previous.statusLoadMore != current.statusLoadMore,
                builder: (context, state) {
                  if (state.status == FormStatus.submissionFailure) {
                    return Center(
                        child: Text(
                      'Вышла ошибка',
                      style: AppTextStyles.error,
                    ));
                  }
                  if (state.status == FormStatus.submissionInProgress) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 100.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return Column(
                    children: [
                      for (var item in state.notifications)
                        NotificationItem(
                          message: item.body!,
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String message;

  const NotificationItem({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFC8D3A2),
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFC8D3A2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_outlined,
                color: AppColors.mainGreen,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
