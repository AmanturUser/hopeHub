import 'package:flutter/material.dart';
import 'package:hope_hub/core/style/app_colors.dart';
import 'package:hope_hub/core/style/app_text_styles.dart';
import 'package:hope_hub/feature/action/domain/action_model.dart';
import 'package:hope_hub/feature/action/presentation/bloc/action_bloc.dart';
import 'package:hope_hub/feature/action/presentation/discussion/school/list.dart';

import 'global/list.dart';

class SelectDiscussionsScreen extends StatelessWidget {
  const SelectDiscussionsScreen({Key? key, required this.schoolDisc, required this.globalDisc}) : super(key: key);

  final List<Discussion> schoolDisc;
  final List<Discussion> globalDisc;

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Светло-кремовый фон
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Обсуждения',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildChatButton(
              title: 'Школьный чат',
              color: AppColors.mainGreen, // Оливковый цвет
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SchoolDiscussionListScreen(discussions: schoolDisc)));
                // Обработка нажатия на школьный чат
              },
            ),
            const SizedBox(height: 12),
            _buildChatButton(
              title: 'Всеобщий чат',
              color: const Color(0xFFF1A025), // Оранжевый цвет
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            GlobalDiscussionListScreen(discussions: globalDisc)));
                // Обработка нажатия на всеобщий чат
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatButton({
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.detail,
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