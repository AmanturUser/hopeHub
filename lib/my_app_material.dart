import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hope_hub/feature/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:hope_hub/feature/splash/presentation/bloc/onboarding_bloc.dart';
import 'core/auto_route/auto_route.dart';
import 'core/navigationService/navigationService.dart';
import 'core/style/theme.dart';
import 'feature/action/presentation/bloc/action_bloc.dart';
import 'feature/auth/presentation/bloc/auth_bloc.dart';
import 'feature/notification/presentation/bloc/notification_bloc.dart';
import 'feature/profile/presentation/bloc/profile_bloc.dart';
import 'feature/rating/presentation/bloc/rating_bloc.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => DashboardBloc(),
        ),
        BlocProvider(
          create: (context) => ActionBloc(),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(),
        ),
        BlocProvider(
          create: (context) => RatingBloc(),
        ),
        BlocProvider(
          create: (context) => OnboardingBloc(),
        ),
        BlocProvider(
          create: (context) => NotificationBloc(),
        ),
      ],
      child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'HopeHub',
          routerConfig: NavigationService.router.config(),
          theme: themeData),
    );
  }
}
