import 'package:flutter/material.dart';
import 'package:hope_hub/feature/dashboard/domain/dashboard_model.dart';

import '../../../../core/style/app_text_styles.dart';
import '../../../../core/style/sizedBoxHeight.dart';

class MyIdeaDetailScreen extends StatelessWidget {
  const MyIdeaDetailScreen({super.key, required this.idea});

  final Ideas idea;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFEF5),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Мои инициативы',
          style: AppTextStyles.appBar,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 32.0,horizontal: 40),
        children: [
          Text(
            idea.name!,
            style: AppTextStyles.detail,
          ),
          SizedBoxHeight.sizedBox14,
          Text(
            idea.description!,
            style: AppTextStyles.subDetail,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}