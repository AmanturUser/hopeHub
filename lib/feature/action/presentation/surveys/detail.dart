import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hope_hub/core/const/form_status.dart';
import 'package:hope_hub/core/style/app_colors.dart';
import 'package:hope_hub/core/style/app_text_styles.dart';
import 'package:hope_hub/core/style/sizedBoxHeight.dart';
import 'package:hope_hub/feature/action/domain/action_model.dart';
import 'package:hope_hub/feature/dashboard/domain/dashboard_model.dart';
import 'package:hope_hub/feature/dashboard/presentation/bloc/dashboard_bloc.dart';

import '../../../profile/presentation/bloc/profile_bloc.dart';
import '../bloc/action_bloc.dart';

class SurveyActionDetailScreen extends StatefulWidget {
  const SurveyActionDetailScreen({super.key, required this.survey});

  final Surveys survey;

  @override
  State<SurveyActionDetailScreen> createState() =>
      _SurveyActionDetailScreenState();
}

class _SurveyActionDetailScreenState extends State<SurveyActionDetailScreen> {
  int? selectedOptionId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Голосования',
          style: AppTextStyles.appBar,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.survey.name!,
                  style: AppTextStyles.detail,
                ),
                SizedBoxHeight.sizedBox14,
                Text(
                  widget.survey.description!,
                  style: AppTextStyles.subDetail,
                ),
                SizedBoxHeight.sizedBox14,
                Text(
                  'Проголосуйте',
                  style: AppTextStyles.detail,
                ),
                SizedBoxHeight.sizedBox14,
                for (var item in widget.survey.options!)
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: selectedOptionId == item.optionId
                            ? const BorderSide(
                                width: 1, color: Color(0xFF3A3938))
                            : BorderSide.none),
                    child: InkWell(
                      onTap: () {
                        selectedOptionId = item.optionId;
                        setState(() {});
                      },
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
                            if (selectedOptionId == item.optionId)
                              const Icon(
                                Icons.check_circle,
                                color: AppColors.mainGreen,
                              ),
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            ),
            BlocConsumer<ActionBloc, ActionState>(
              listenWhen: (previous, current) =>
              previous.statusSurvey != current.statusSurvey,
              listener: (context, state) {
                // TODO: implement listener
                if (state.statusSurvey == FormStatus.submissionSuccess) {
                  context.read<DashboardBloc>().add(SurveySubmitEvent(
                      survey: UserSurveys(
                          id: widget.survey.sId,
                          name: widget.survey.name,
                          description: widget.survey.description,
                          options: widget.survey.options,
                          selectedOption: selectedOptionId)));
                  Navigator.pop(context);
                  Navigator.pop(context);
                  context.read<ProfileBloc>().add(const GetProfileEvent());
                  context.read<ActionBloc>().add(const ResetEvent());
                }
              },
              buildWhen: (previous, current) =>
              previous.statusSurvey != current.statusSurvey,
              builder: (context, state) {
                if (state.statusSurvey == FormStatus.submissionInProgress) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.statusSurvey == FormStatus.submissionFailure) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                        content:
                            Text('Вышла ошибка', style: AppTextStyles.error)));
                }
                return Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              if (selectedOptionId != null) {
                                context.read<ActionBloc>().add(
                                    SubmitSurveyEvent(
                                        selectOption: selectedOptionId!,
                                        surveyId: widget.survey.sId!));
                              }
                            },
                            child: const Text('Проголосовать'))),
                  ],
                );
              },
            )
          ],
        ),
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
