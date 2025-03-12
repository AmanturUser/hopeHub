import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/auto_route/auto_route.dart';
import '../../../../core/const/const.dart';
import '../../../../core/const/form_status.dart';
import '../../../../core/const/helper.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_text_styles.dart';
import '../../../../core/style/sizedBoxHeight.dart';
import '../bloc/auth_bloc.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/icons/people.png'),
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x171D011A).withOpacity(0.1),
                        blurRadius: 25,
                      )
                    ],
                    color: AppColors.authContainerBackground,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBoxHeight.sizedBox24,
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/icons/lamp.png',
                                    width: 24, height: 24),
                                SizedBoxHeight.sizedBox8,
                                Text(
                                  'Virtual Volunteer Club',
                                  style: AppTextStyles.authLogoText,
                                )
                              ]),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Column(
                          children: [
                            Text(
                              'Регистрация',
                              style: AppTextStyles.authText,
                            ),
                            const SizedBox(height: 40),
                            Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Имя',
                                    style: AppTextStyles.authEmailLabel,
                                  ),
                                  TextFormField(
                                    controller: name,
                                    decoration: InputDecoration(
                                      hintText: 'Введите ваше имя',
                                      hintStyle: AppTextStyles.formHint,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                          color: AppColors.formBorder,
                                          width: 1.0,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                          color: AppColors.error,
                                          width: 2.0,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                          color: AppColors.error,
                                          width: 2.0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                          color: AppColors.mainGreen,
                                          width: 2.0,
                                        ),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 14),
                                    ),
                                    textCapitalization:
                                        TextCapitalization.words,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[a-zA-Zа-яА-Я\s]')),
                                    ],
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) =>
                                        validateName(value),
                                  ),
                                  SizedBoxHeight.sizedBox18,
                                  Text(
                                    'Фамилия',
                                    style: AppTextStyles.authEmailLabel,
                                  ),
                                  TextFormField(
                                    controller: surname,
                                    decoration: InputDecoration(
                                      hintText: 'Введите вашу фамилию',
                                      hintStyle: AppTextStyles.formHint,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                          color: AppColors.formBorder,
                                          width: 1.0,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                          color: AppColors.error,
                                          width: 2.0,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                          color: AppColors.error,
                                          width: 2.0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                          color: AppColors.mainGreen,
                                          width: 2.0,
                                        ),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 14),
                                    ),
                                    textCapitalization:
                                        TextCapitalization.words,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[a-zA-Zа-яА-Я\s]')),
                                    ],
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) =>
                                        validateSurname(value),
                                  ),
                                  SizedBoxHeight.sizedBox24,
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      context
                                                          .read<AuthBloc>()
                                                          .add(RegisterFirstEvent(
                                                              name: name.text,
                                                              surname: surname
                                                                  .text));
                                                      AutoRouter.of(context).push(
                                                          const SelectSchoolRoute());
                                                    }
                                                  },
                                                  child: const Text('Далее'))),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Image.asset('assets/icons/goodNeighbors.png',
                               height: 68),
                          SizedBoxHeight.sizedBox24,
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
