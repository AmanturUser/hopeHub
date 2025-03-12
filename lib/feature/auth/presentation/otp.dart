import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:hope_hub/core/style/app_colors.dart';
import 'package:hope_hub/core/style/app_text_styles.dart';
import 'package:hope_hub/core/style/sizedBoxHeight.dart';

import '../../../core/auto_route/auto_route.dart';
import '../../../core/const/form_status.dart';
import 'bloc/auth_bloc.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool _onEditing = true;

  String _code = '';

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
                                     height: 24),
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
                              'Введите код',
                              style: AppTextStyles.authText,
                            ),
                            Text(
                              'отправленный на ваш email адрес',
                              style: AppTextStyles.authEmailLabel,
                            ),
                            const SizedBox(height: 40),
                            Column(
                              children: [
                                VerificationCode(
                                  textStyle: AppTextStyles.authEmailLabel,
                                  keyboardType: TextInputType.number,
                                  underlineColor: AppColors.mainGreen,
                                  length: 4,
                                  fullBorder: true,
                                  cursorColor: AppColors.mainGreen,
                                  underlineUnfocusedColor:
                                      const Color(0xFFC5C6CC),
                                  onCompleted: (String value) {
                                    setState(() {
                                      _code = value;
                                    });
                                  },
                                  onEditing: (bool value) {
                                    setState(() {
                                      _onEditing = value;
                                    });
                                    if (!_onEditing)
                                      FocusScope.of(context).unfocus();
                                  },
                                ),
                                SizedBoxHeight.sizedBox8,
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'не получили код? ',
                                      style: AppTextStyles.authEmailLabel
                                          .copyWith(
                                              fontWeight: FontWeight.w400),
                                    ),
                                    BlocConsumer<AuthBloc, AuthState>(
                                      listenWhen: (previous, current) =>
                                          previous.statusSendCode != current.statusSendCode,
                                      listener: (context, state) {
                                        if (state.statusSendCode ==
                                            FormStatus.submissionSuccess) {
                                          ScaffoldMessenger.of(context)
                                            ..hideCurrentSnackBar()
                                            ..showSnackBar(SnackBar(
                                                content: Text('Отправлено',
                                                    style: AppTextStyles
                                                        .authEmailLabel
                                                        .copyWith(
                                                            color: Colors
                                                                .white))));
                                        }
                                        if (state.statusSendCode ==
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
                                          previous.statusSendCode != current.statusSendCode,
                                      builder: (context, state) {
                                        if (state.statusSendCode ==
                                            FormStatus.submissionInProgress) {
                                          return const CircularProgressIndicator();
                                        }
                                        return InkWell(
                                          onTap: () {
                                            context.read<AuthBloc>().add(
                                                SignInEvent(
                                                    email: state.userEmail));
                                          },
                                          child: Text(
                                            ' Получить код',
                                            style: AppTextStyles.authEmailLabel
                                                .copyWith(
                                                    color: AppColors.mainGreen),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                SizedBoxHeight.sizedBox24,
                                BlocConsumer<AuthBloc, AuthState>(
                                  listenWhen: (previous, current) =>
                                      previous.statusOtp != current.statusOtp,
                                  listener: (context, state) {
                                    if (state.statusOtp ==
                                        FormStatus.submissionSuccess) {
                                      if(state.isRegister){
                                        AutoRouter.of(context)
                                            .replaceAll([const HomeRoute()]);
                                      }else{
                                        AutoRouter.of(context)
                                            .push(const RegisterRoute());
                                      }
                                      context.read<AuthBloc>().add(const ResetEvent());
                                    }
                                    if (state.statusOtp ==
                                        FormStatus.submissionFailure) {
                                      ScaffoldMessenger.of(context)
                                        ..hideCurrentSnackBar()
                                        ..showSnackBar(SnackBar(
                                            content: Text('Вышла ошибка',
                                                style: AppTextStyles.error)));
                                    }
                                  },
                                  buildWhen: (previous, current) =>
                                      previous.statusOtp != current.statusOtp,
                                  builder: (context, state) {
                                    if (state.statusOtp ==
                                        FormStatus.submissionInProgress) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                    return Row(
                                      children: [
                                        Expanded(
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  if (_code.isNotEmpty) {
                                                    context
                                                        .read<AuthBloc>()
                                                        .add(OtpEvent(
                                                            otp: _code));
                                                  }
                                                },
                                                child:
                                                    const Text('Подтвердить'))),
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
