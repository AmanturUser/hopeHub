import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hope_hub/core/style/app_colors.dart';
import 'package:hope_hub/core/style/app_text_styles.dart';
import 'package:hope_hub/feature/auth/domain/model/schoolsModel.dart';

import '../../../../core/auto_route/auto_route.dart';
import '../../../../core/const/form_status.dart';
import '../bloc/auth_bloc.dart';

class SelectClassScreen extends StatefulWidget {
  const SelectClassScreen({super.key});

  @override
  State<SelectClassScreen> createState() => _SelectClassScreenState();
}

class _SelectClassScreenState extends State<SelectClassScreen> {
  String? selectedClassId;
  Success? selectedSchool;
  List<Success>? classes;

  @override
  void initState() {
    classes = context.read<AuthBloc>().state.classes;
    selectedSchool=context.read<AuthBloc>().state.selectedSchool.first;
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
                selectedSchool!.name!,
                style: AppTextStyles.authText,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Выберите класс',
                    style: AppTextStyles.authText.copyWith(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: classes!.length,
                  itemBuilder: (context, index) {
                    final classItem = classes![index];
                    final isSelected = classItem.sId == selectedClassId;
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
                          classItem.name!,
                          style: AppTextStyles.authEmailLabel.copyWith(color: isSelected ? Colors.white : null),
                        ),
                        trailing: isSelected
                            ? const Icon(Icons.check_circle, color: Colors.white)
                            : null,
                        onTap: () {
                          setState(() {
                            selectedClassId = classItem.sId;
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
                previous.statusRegister != current.statusRegister,
                listener: (context, state) {
                  if (state.statusRegister ==
                      FormStatus.submissionSuccess) {
                    AutoRouter.of(context)
                        .push(const RegisterDoneRoute());
                    context.read<AuthBloc>().add(const ResetEvent());
                  }
                  if (state.statusRegister ==
                      FormStatus.submissionFailure) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                          content: Text('Вышла ошибка',
                              style: AppTextStyles.error)));
                  }
                },
                buildWhen: (previous, current) =>
                previous.statusRegister != current.statusRegister,
                builder: (context, state) {
                  if (state.statusRegister ==
                      FormStatus.submissionInProgress) {
                    return const Center(
                        child: CircularProgressIndicator());
                  }
    return ElevatedButton(
                onPressed: selectedClassId != null
                    ? () {
                  context.read<AuthBloc>().add(RegisterDoneEvent(classId: selectedClassId!));
                        // Обработка подтверждения выбора
                        print('Selected classItem: $selectedClassId');
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
