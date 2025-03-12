import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hope_hub/core/const/form_status.dart';
import 'package:hope_hub/core/style/app_colors.dart';
import 'package:hope_hub/core/style/app_text_styles.dart';
import 'package:hope_hub/core/style/sizedBoxHeight.dart';

import '../../../core/auto_route/auto_route.dart';
import '../../../core/const/const.dart';
import '../../../core/const/helper.dart';
import 'bloc/auth_bloc.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  TextEditingController email = TextEditingController();
  final _formKey=GlobalKey<FormState>();
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
                              'Авторизация',
                              style: AppTextStyles.authText,
                            ),
                            const SizedBox(height: 40),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Введите ваш e-mail адрес',
                                  style: AppTextStyles.authEmailLabel,
                                ),
                                Form(
                                  key: _formKey,
                                  child: TextFormField(
                                    controller: email,
                                    decoration: InputDecoration(
                                      hintText: 'E-mail',
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
                                      contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 14),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) => validateEmail(value),
                                  ),
                                ),
                                SizedBoxHeight.sizedBox24,
                                BlocConsumer<AuthBloc, AuthState>(
                                  listenWhen: (previous, current) =>
                                  previous.status != current.status || previous.userEmail != current.userEmail,
                                  listener: (context, state){
                                    if(state.status==FormStatus.submissionSuccess){
                                      context.read<AuthBloc>().add(const ResetEvent());
                                      AutoRouter.of(context)
                                          .push(const OtpRoute());
                                    }
                                  },
                                  buildWhen: (previous, current) =>
                                  previous.status != current.status || previous.userEmail != current.userEmail,
                                  builder: (context, state) {
                                    String error='';
                                    if(state.status==FormStatus.submissionInProgress){
                                      return const Center(child: CircularProgressIndicator());
                                    }
                                    if(state.status==FormStatus.submissionFailure){
                                      error='Вышла ошибка';
                                    }
                                    if(state.status==FormStatus.pure){
                                      error='';
                                    }
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      if(_formKey.currentState!.validate()){
                                                        context.read<AuthBloc>().add(SignInEvent(email: email.text));
                                                      }
                                                    },
                                                    child: const Text('Получить код'))),
                                          ],
                                        ),
                                        SizedBoxHeight.sizedBox8,
                                        Text(
                                          error,
                                        style: AppTextStyles.error,),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Image.asset('assets/icons/goodNeighbors.png',
                              width: 211, height: 68),
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
