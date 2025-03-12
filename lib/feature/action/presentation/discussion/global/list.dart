import 'package:flutter/material.dart';
import 'package:hope_hub/core/const/userData.dart';
import 'package:hope_hub/core/style/app_text_styles.dart';
import 'package:hope_hub/core/style/sizedBoxHeight.dart';
import 'package:hope_hub/feature/action/domain/action_model.dart';
import 'package:hope_hub/feature/action/presentation/discussion/chat/chat.dart';
import 'package:hope_hub/feature/dashboard/domain/dashboard_model.dart';


class GlobalDiscussionListScreen extends StatelessWidget {
  const GlobalDiscussionListScreen({super.key, required this.discussions});

  final List<Discussion> discussions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Общий чат',
          style: AppTextStyles.appBar,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          for (var item in discussions)
            _buildProjectCard(
              item.title!,
              item.description!,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ChatScreen(title: item.title!, discussionId: item.sId!, token: UserData.token, currentUserId: '',)));
                // Handle tap
              },
            ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(String description,String title, {required VoidCallback onTap}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Colors.black54,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
