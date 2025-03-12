import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hope_hub/feature/action/presentation/discussion/selectType.dart';

import '../../dashboard/presentation/bloc/dashboard_bloc.dart';
import 'bloc/action_bloc.dart';
import 'events/list.dart';
import 'surveys/list.dart';

class ActionScreen extends StatelessWidget {
  const ActionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0.3,
        title: const Text(
          'Мои действия',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        backgroundColor: const Color(0xFFFFFDEB),
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          context.read<DashboardBloc>().add(const GetDashboardEvent());
          context.read<ActionBloc>().add(const GetActionsEvent());
        },
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            BlocBuilder<ActionBloc, ActionState>(
              bloc: context.read<ActionBloc>()..add(const GetActionsEvent()),
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    // Голосования
                    InkWell(
                      onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SurveyActionListScreen(surveys: state.surveys)));
                      },
                      child: _buildActionCard(
                        title: 'Голосования',
                        subtitle: 'Всего ${state.surveys.length} тем на голосовании',
                        iconPath: 'assets/icons/action1.png',
                        // Добавьте SVG иконку галочки
                        color: const Color(0xFFFBDD9D),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Обсуждения
                    InkWell(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SelectDiscussionsScreen(schoolDisc: state.schoolDiscussions, globalDisc: state.globalDiscussions,)));
                      },
                      child: _buildActionCard(
                        title: 'Обсуждения',
                        subtitle:
                        'Всеобщий чат (${state.globalDiscussions.length} активных обсуждений)\nШкольный чат (${state.schoolDiscussions.length} активных обсуждений)',
                        color: const Color(0xFFDBE6B3),
                        iconPath: 'assets/icons/action2.png', // Добавьте SVG иконку чата
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Календарь событий
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EventListScreen(events: state.events)));
                      },
                      child: _buildActionCard(
                        title: 'Календарь событий',
                        subtitle: '${state.events.length} предстоящих событий',
                        iconPath: 'assets/icons/action3.png',
                        // Добавьте SVG иконку календаря
                        color: const Color(0xFFFFF4A9),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required String iconPath,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
              scale: 4,
              image: AssetImage(iconPath),
              opacity: iconPath.contains('action3') ? 1 : 0.3,
              alignment: Alignment(0.5, 0)
          )),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    // Здесь должна быть ваша SVG иконка
                    // SvgPicture.asset(
                    //   iconPath,
                    //   width: 24,
                    //   height: 24,
                    // ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
