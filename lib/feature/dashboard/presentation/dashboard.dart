import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hope_hub/core/const/form_status.dart';
import 'package:hope_hub/feature/dashboard/presentation/myIdeas/list.dart';
import 'package:hope_hub/feature/dashboard/presentation/projects/list.dart';

import '../../../core/style/app_text_styles.dart';
import '../../action/presentation/bloc/action_bloc.dart';
import 'bloc/dashboard_bloc.dart';
import 'myIdeas/ideaSubmission.dart';
import 'surveys/list.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<DashboardBloc, DashboardState>(
            bloc: context.read<DashboardBloc>()..add(const GetDashboardEvent()),
            builder: (context, state) {
              if(state.status==FormStatus.submissionInProgress){
                return const Center(child: CircularProgressIndicator());
              }
              if(state.status==FormStatus.submissionFailure){
                return RefreshIndicator(
                  onRefresh: () async{
                    context.read<DashboardBloc>().add(const GetDashboardEvent());
                    context.read<ActionBloc>().add(const GetActionsEvent());
                  },
                  child: ListView(
                    children: [
                      const Center(child: Text('Вышла ошибка')),
                    ],
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: () async{
                  context.read<DashboardBloc>().add(const GetDashboardEvent());
                  context.read<ActionBloc>().add(const GetActionsEvent());
                },
                child: Stack(
                    children: [
                      ListView(
                        children: [
                          Text(
                            'Добрый день, ${state.userName}!',
                            style: AppTextStyles.authText.copyWith(
                                color: const Color(0xFF1A1A1A)),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Давай менять будущее вместе!',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF1A1A1A),
                                fontWeight: FontWeight.w400
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Секция "Мои инициативы"
                          InkWell(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => MyIdeasListScreen(ideas: state.ideas)));
                            },
                            child: _buildSectionCard(
                                title: 'Мои инициативы',
                                items: state.ideas,
                                color: const Color(0xFFDBE6B3),
                                colorItems: const Color(0xFFD2DEA7)
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Секция "Участие в голосованиях"
                          InkWell(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SurveyListScreen(userSurveys: state.userSurveys)));
                            },
                            child: _buildSectionCard(
                                title: 'Участие в голосованиях',
                                items: state.userSurveys,
                                color: const Color(0xFFFBDD9D),
                                colorItems: const Color(0xFFF7D58C)
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Секция "Участие в проектах"
                          InkWell(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ProjectListScreen(projects: state.projects)),
                              );
                            },
                            child: _buildSectionCard(
                                title: 'Участие в проектах',
                                items: state.projects,
                                color: const Color(0xFFFFF4A9),
                                colorItems: const Color(0xFFFBED90)
                            ),
                          ),
                          const SizedBox(height: 100)
                        ],
                      ),
                      // Кнопка "У меня есть идея"
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => IdeaSubmissionScreen()),
                                );
                                // Обработка нажатия
                              },
                              child: const Text(
                                'У меня есть идея',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]

                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required List<dynamic> items,
    required Color color,
    required Color colorItems,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
          ...items.map((item) =>
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: colorItems,
                ),
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              )).toList(),
        ],
      ),
    );
  }
}
