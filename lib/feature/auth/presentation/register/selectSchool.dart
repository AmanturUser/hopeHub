import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hope_hub/core/style/app_colors.dart';
import 'package:hope_hub/core/style/app_text_styles.dart';
import 'package:hope_hub/feature/auth/domain/model/schoolsModel.dart';

import '../../../../core/auto_route/auto_route.dart';
import '../../../../core/const/form_status.dart';
import '../bloc/auth_bloc.dart';

class SelectSchoolScreen extends StatefulWidget {
  const SelectSchoolScreen({super.key});

  @override
  State<SelectSchoolScreen> createState() => _SelectSchoolScreenState();
}

class _SelectSchoolScreenState extends State<SelectSchoolScreen> {
  Success? selectedSchool;
  List<Success>? schools;

  @override
  void initState() {
    schools = context.read<AuthBloc>().state.schools;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Text(
                'Выберите вашу школу',
                style: AppTextStyles.authText,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: schools!.length,
                  itemBuilder: (context, index) {
                    final school = schools![index];
                    bool isSelected;
                    if(selectedSchool!=null) {
                      isSelected = school.sId == selectedSchool!.sId;
                    }else{
                      isSelected=false;
                    }

                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: isSelected ? AppColors.mainGreen : Colors.white,
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        title: Text(
                          school.name!,
                          style: AppTextStyles.authEmailLabel.copyWith(
                              color: isSelected ? Colors.white : null),
                        ),
                        trailing: isSelected
                            ? const Icon(Icons.check_circle,
                                color: Colors.white)
                            : null,
                        onTap: () {
                          setState(() {
                            selectedSchool = school;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              BlocConsumer<AuthBloc, AuthState>(
                listenWhen: (previous, current) =>
                    previous.status != current.status,
                listener: (context, state) {
                  if (state.status == FormStatus.submissionSuccess) {
                    AutoRouter.of(context).push(const SelectClassRoute());
                    context.read<AuthBloc>().add(const ResetEvent());
                  }
                  if (state.status == FormStatus.submissionFailure) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                          content: Text('Вышла ошибка',
                              style: AppTextStyles.error)));
                  }
                },
                buildWhen: (previous, current) =>
                    previous.status != current.status,
                builder: (context, state) {
                  if (state.status == FormStatus.submissionInProgress) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ElevatedButton(
                    onPressed: selectedSchool != null
                        ? () {
                      context
                          .read<AuthBloc>()
                          .add(GetClassesEvent(selectedSchool: selectedSchool!));
                            // Обработка подтверждения выбора
                            print('Selected school: ${selectedSchool!.sId}');
                          }
                        : null,
                    child: const Text('Подтвердить'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
