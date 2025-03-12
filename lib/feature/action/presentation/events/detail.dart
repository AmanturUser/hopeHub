import 'package:flutter/material.dart';
import 'package:hope_hub/core/style/app_text_styles.dart';
import 'package:hope_hub/core/style/sizedBoxHeight.dart';
import 'package:hope_hub/feature/dashboard/domain/dashboard_model.dart';

import '../../../../core/const/helper.dart';
import '../../domain/action_model.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({super.key, required this.event});
  final Events event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFEF5),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Календарь событий',
          style: AppTextStyles.appBar,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 32.0,horizontal: 40),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                formatDate(event.date!),
                style: AppTextStyles.detail,
              ),
            ],
          ),
          Text(
            event.title!,
            style: AppTextStyles.detail,
          ),
          SizedBoxHeight.sizedBox14,
          Text(
            event.description!,
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