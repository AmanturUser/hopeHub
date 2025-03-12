part of 'auto_route.dart';


abstract class _$AppRouter extends RootStackRouter{
  @override
  final Map<String, PageFactory> pagesMap={
    SplashRoute.name: (routeData){
      return AutoRoutePage<dynamic>(
          routeData: routeData,
          child: const SplashScreen()
      );
    },
    OnboardRoute.name: (routeData){
      return AutoRoutePage<dynamic>(
          routeData: routeData,
          child: const OnboardingScreen()
      );
    },
    SignInRoute.name: (routeData){
      return AutoRoutePage<dynamic>(
          routeData: routeData,
          child: SignInScreen()
      );
    },
    OtpRoute.name: (routeData){
      return AutoRoutePage<dynamic>(
          routeData: routeData,
          child: OtpScreen()
      );
    },
    RegisterRoute.name: (routeData){
      return AutoRoutePage<dynamic>(
          routeData: routeData,
          child: RegisterScreen()
      );
    },
    SelectSchoolRoute.name: (routeData){
      return AutoRoutePage<dynamic>(
          routeData: routeData,
          child: const SelectSchoolScreen()
      );
    },
    SelectClassRoute.name: (routeData){
      return AutoRoutePage<dynamic>(
          routeData: routeData,
          child: const SelectClassScreen()
      );
    },
    RegisterDoneRoute.name: (routeData){
      return AutoRoutePage<dynamic>(
          routeData: routeData,
          child: const RegisterDoneScreen()
      );
    },
    HomeRoute.name: (routeData){
      return AutoRoutePage<dynamic>(
          routeData: routeData,
          child: const HomeScreen()
      );
    },
    DashboardRoute.name: (routeData){
      return AutoRoutePage<dynamic>(
          routeData: routeData,
          child: const DashboardScreen()
      );
    },
    ActionRoute.name: (routeData){
      return AutoRoutePage<dynamic>(
          routeData: routeData,
          child: const ActionScreen()
      );
    },

    RatingRoute.name: (routeData){
      return AutoRoutePage<dynamic>(
          routeData: routeData,
          child: const RatingScreen()
      );
    },
    NotificationRoute.name: (routeData){
      return AutoRoutePage<dynamic>(
          routeData: routeData,
          child: const NotificationScreen()
      );
    },
    ProfileRoute.name: (routeData){
      return AutoRoutePage<dynamic>(
          routeData: routeData,
          child: ProfileScreen()
      );
    },
  };
}

class SplashRoute extends PageRouteInfo<void>{
  static const String name='Splash';
  static const PageInfo<void> page=PageInfo<void>(name);
  const SplashRoute({List<PageRouteInfo>? children}): super(SplashRoute.name,initialChildren: children);
}

class OnboardRoute extends PageRouteInfo<void>{
  static const String name='OnboardRoute';
  static const PageInfo<void> page=PageInfo<void>(name);
  const OnboardRoute({List<PageRouteInfo>? children}): super(OnboardRoute.name,initialChildren: children);
}

class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute({List<PageRouteInfo>? children})
      : super(
    SignInRoute.name,
    initialChildren: children,
  );
  static const String name = 'SignInRoute';
  static const PageInfo<void> page = PageInfo<void>(name);
}

class OtpRoute extends PageRouteInfo<void> {
  const OtpRoute({List<PageRouteInfo>? children})
      : super(
    OtpRoute.name,
    initialChildren: children,
  );
  static const String name = 'OtpRoute';
  static const PageInfo<void> page = PageInfo<void>(name);
}

class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
      : super(
    RegisterRoute.name,
    initialChildren: children,
  );
  static const String name = 'RegisterRoute';
  static const PageInfo<void> page = PageInfo<void>(name);
}

class SelectSchoolRoute extends PageRouteInfo<void> {
  const SelectSchoolRoute({List<PageRouteInfo>? children})
      : super(
    SelectSchoolRoute.name,
    initialChildren: children,
  );
  static const String name = 'SelectSchoolRoute';
  static const PageInfo<void> page = PageInfo<void>(name);
}

class SelectClassRoute extends PageRouteInfo<void> {
  const SelectClassRoute({List<PageRouteInfo>? children})
      : super(
    SelectClassRoute.name,
    initialChildren: children,
  );
  static const String name = 'SelectClassRoute';
  static const PageInfo<void> page = PageInfo<void>(name);
}

class RegisterDoneRoute extends PageRouteInfo<void> {
  const RegisterDoneRoute({List<PageRouteInfo>? children})
      : super(
    RegisterDoneRoute.name,
    initialChildren: children,
  );
  static const String name = 'RegisterDoneRoute';
  static const PageInfo<void> page = PageInfo<void>(name);
}

class HomeRoute extends PageRouteInfo<void>{
  static const String name='Home';
  static const PageInfo<void> page=PageInfo<void>(name);
  const HomeRoute({List<PageRouteInfo>? children}): super(HomeRoute.name,initialChildren: children);
}

class DashboardRoute extends PageRouteInfo<void> {
  const DashboardRoute({List<PageRouteInfo>? children})
      : super(
    DashboardRoute.name,
    initialChildren: children,
  );
  static const String name = 'DashboardRoute';
  static const PageInfo<void> page = PageInfo<void>(name);
}

class ActionRoute extends PageRouteInfo<void> {
  const ActionRoute({List<PageRouteInfo>? children})
      : super(
    ActionRoute.name,
    initialChildren: children,
  );
  static const String name = 'ActionRoute';
  static const PageInfo<void> page = PageInfo<void>(name);
}

class RatingRoute extends PageRouteInfo<void> {
  const RatingRoute({List<PageRouteInfo>? children})
      : super(
    RatingRoute.name,
    initialChildren: children,
  );
  static const String name = 'RatingRoute';
  static const PageInfo<void> page = PageInfo<void>(name);
}

class NotificationRoute extends PageRouteInfo<void> {
  const NotificationRoute({List<PageRouteInfo>? children})
      : super(
    NotificationRoute.name,
    initialChildren: children,
  );
  static const String name = 'NotificationRoute';
  static const PageInfo<void> page = PageInfo<void>(name);
}

class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
    ProfileRoute.name,
    initialChildren: children,
  );
  static const String name = 'ProfileRoute';
  static const PageInfo<void> page = PageInfo<void>(name);
}