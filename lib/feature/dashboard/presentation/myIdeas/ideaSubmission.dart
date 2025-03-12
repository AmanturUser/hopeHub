import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hope_hub/core/style/app_text_styles.dart';
import 'package:hope_hub/feature/dashboard/presentation/myIdeas/success.dart';
import 'package:hope_hub/feature/rating/presentation/bloc/rating_bloc.dart';

import '../../../../core/const/form_status.dart';
import '../../../profile/presentation/bloc/profile_bloc.dart';
import '../bloc/dashboard_bloc.dart';

class IdeaSubmissionScreen extends StatelessWidget {
  IdeaSubmissionScreen({super.key});
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  final _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'У тебя есть идея?',
          style: AppTextStyles.appBar,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Замечательно! Мы рады ее услышать',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Опиши и отправь свою инициативу на рассмотрение',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: name,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Название',
                  ),
                  validator: (value){
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите название';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: description,
                  maxLines: 8,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Напиши, что ты хочешь изменить или улучшить',
                  ),
                  validator: (value){
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите описание';
                    }
                    return null;
                  },
                ),
                Text(
                  'Твою заявку обязательно рассмотрят на собрании Сената в течение 5 рабочих дней',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                BlocConsumer<DashboardBloc, DashboardState>(
                  listenWhen: (previous, current) =>
                  previous.statusIdea != current.statusIdea,
                  listener: (context, state) async {
                    if (state.statusIdea ==
                        FormStatus.submissionSuccess){
                      /*ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                            content: Text('Отправлено',
                                style: AppTextStyles
                                    .authEmailLabel
                                    .copyWith(
                                    color: Colors
                                        .white))));*/
                      await context.read<ProfileBloc>()..add(const GetProfileEvent());
                      await context.read<RatingBloc>()..add(const GetRatingEvent());
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const SuccessScreen()),
                      );
                    }
                    if (state.statusIdea ==
                        FormStatus.submissionFailure) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                            content: Text('Вышла ошибка',
                                style:
                                AppTextStyles.error)));
                    }
                  },
                  buildWhen: (previous, current) =>
                  previous.statusIdea != current.statusIdea,
                  builder: (context, state) {
                    if (state.statusIdea ==
                        FormStatus.submissionInProgress) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                            context.read<DashboardBloc>().add(IdeaSubmissionEvent(name: name.text, description: description.text));
                          }
                          // Handle submission
                        },
                        child: const Text(
                          'Отправить',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}