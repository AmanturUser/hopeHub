import 'package:auto_route/auto_route.dart';
import 'package:hope_hub/feature/notification/presentation/notification.dart';
import 'package:hope_hub/feature/profile/presentation/profile.dart';
import 'package:hope_hub/feature/rating/presentation/rating.dart';
import 'package:hope_hub/feature/splash/presentation/onboarding/onboarding.dart';

import '../../feature/action/presentation/action.dart';
import '../../feature/auth/presentation/otp.dart';
import '../../feature/auth/presentation/register/register.dart';
import '../../feature/auth/presentation/register/register_done.dart';
import '../../feature/auth/presentation/register/selectClass.dart';
import '../../feature/auth/presentation/register/selectSchool.dart';
import '../../feature/auth/presentation/signIn.dart';
import '../../feature/dashboard/presentation/dashboard.dart';
import '../../feature/home/presentation/home.dart';
import '../../feature/splash/presentation/splash_screen.dart';
part 'auto_route.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter{
  @override
  List<AutoRoute> get routes=>[
    AutoRoute(page: SplashRoute.page,initial: true),
    AutoRoute(page: OnboardRoute.page),
    AutoRoute(page: SignInRoute.page),
    AutoRoute(page: OtpRoute.page),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(page: SelectSchoolRoute.page),
    AutoRoute(page: SelectClassRoute.page),
    AutoRoute(page: RegisterDoneRoute.page),
    AutoRoute(page: HomeRoute.page,children: [
      AutoRoute(page: DashboardRoute.page),
      AutoRoute(page: ActionRoute.page),
      AutoRoute(page: RatingRoute.page),
      AutoRoute(page: NotificationRoute.page),
      AutoRoute(page: ProfileRoute.page),

    ]),
  ];
}