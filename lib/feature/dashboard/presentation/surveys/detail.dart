import 'package:flutter/material.dart';
import 'package:hope_hub/core/style/app_colors.dart';
import 'package:hope_hub/core/style/app_text_styles.dart';
import 'package:hope_hub/core/style/sizedBoxHeight.dart';
import 'package:hope_hub/feature/dashboard/domain/dashboard_model.dart';

class SurveyDetailScreen extends StatelessWidget {
  const SurveyDetailScreen({super.key, required this.survey});
  final UserSurveys survey;

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
        padding: const EdgeInsets.symmetric(vertical: 32.0,horizontal: 32),
        children: [
          Text(
            survey.name!,
            style: AppTextStyles.detail,
          ),
          SizedBoxHeight.sizedBox14,
          Text(
            survey.description!,
            style: AppTextStyles.subDetail,
          ),
          SizedBoxHeight.sizedBox14,
          Text(
            'Ваш голос',
            style: AppTextStyles.detail,
          ),
          SizedBoxHeight.sizedBox14,
          for(var item in survey.options!)
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: survey.selectedOption==item.optionId ? const BorderSide(width:  1 ,color: Color(0xFF3A3938)) : BorderSide.none
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.optionName!,
                        style: AppTextStyles.authEmailLabel,
                      ),
                    ),
                    if(survey.selectedOption==item.optionId)
                    const Icon(
                      Icons.check_circle,
                      color: AppColors.mainGreen,
                    ),
                  ],
                ),
              ),
            )
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