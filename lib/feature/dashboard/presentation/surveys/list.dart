import 'package:flutter/material.dart';
import 'package:hope_hub/feature/dashboard/domain/dashboard_model.dart';

import '../../../../core/style/app_text_styles.dart';
import 'detail.dart';

class SurveyListScreen extends StatelessWidget {
  const SurveyListScreen({super.key,required this.userSurveys});
  final List<UserSurveys> userSurveys;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Участие в голосованиях',
          style: AppTextStyles.appBar,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          for (var item in userSurveys)
            _buildProjectCard(
              item.name!,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SurveyDetailScreen(survey: item)));
                // Handle tap
              },
            ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(String title, {required VoidCallback onTap}) {
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
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
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
