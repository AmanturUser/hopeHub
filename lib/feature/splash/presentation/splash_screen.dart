import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hope_hub/core/style/app_colors.dart';
import 'package:hope_hub/core/style/app_text_styles.dart';
import 'package:hope_hub/core/style/sizedBoxHeight.dart';

import '../../../core/auto_route/auto_route.dart';
import '../../../core/const/form_status.dart';
import '../../../core/notificationService/notificationService.dart';
import 'bloc/onboarding_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  late FirebaseMessagingService _messagingService;
  Future<void> _initializeMessaging() async {
    await _messagingService.initialize();
  }


  @override
  void initState() {
      _messagingService = FirebaseMessagingService(context: context);
      _initializeMessaging();
    Future.delayed(Duration(seconds: 2), () {
      context.read<OnboardingBloc>().add(const CheckOnboard());
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainGreen,
      body: BlocConsumer<OnboardingBloc, OnboardingState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == FormStatus.submissionSuccess) {
            if(state.statusToken==FormStatus.submissionSuccess){
              AutoRouter.of(context).replace(const HomeRoute());
            }else{
              AutoRouter.of(context).replace(const SignInRoute());
              context.read<OnboardingBloc>().add(const ResetOnboard());
            }
          }
          if (state.status == FormStatus.submissionFailure) {
            AutoRouter.of(context).replace(const OnboardRoute());
          }
        },
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(),
                Column(
                  children: [
                    const Column(
                      children: [
                        Text(
                          'Virtual',
                          style: AppTextStyles.splash,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Volunteer',
                          style: AppTextStyles.splash,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Club',
                          style: AppTextStyles.splash,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBoxHeight.sizedBox50,
                    Image.asset('assets/icons/lamp.png',
                        width: 160, height: 160),
                  ],
                ),
                Image.asset(
                  'assets/icons/goodNeighborsWhite.png',
                  width: 211,
                  height: 48,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
