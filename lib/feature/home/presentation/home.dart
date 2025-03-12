import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hope_hub/core/style/app_colors.dart';
import 'package:hope_hub/core/style/app_text_styles.dart';

import '../../../core/auto_route/auto_route.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [DashboardRoute(), ActionRoute(), RatingRoute(), NotificationRoute(), ProfileRoute()],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
            body: child,
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF171D01).withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 25,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: BottomNavigationBar(
                  currentIndex: tabsRouter.activeIndex,
                  onTap: (value) {
                    tabsRouter.setActiveIndex(value);
                  },
                  items: [
                    /*BottomNavigationBarItem(
                  icon: Icon(Icons.event_note_outlined),
                  label: 'ToDo',
                ),
                */
                    BottomNavigationBarItem(
                      icon: Image.asset('assets/icons/dashboard.png',width: 24,height: 24,color: tabsRouter.activeIndex==0 ? AppColors.bottomBarActiveIcon : AppColors.bottomBarPassiveIcon),
                      label: 'Гланая',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset('assets/icons/action.png',width: 24,height: 24,color: tabsRouter.activeIndex==1 ? AppColors.bottomBarActiveIcon : AppColors.bottomBarPassiveIcon),
                      label: 'Действия',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset('assets/icons/rating.png',width: 24,height: 24,color: tabsRouter.activeIndex==2 ? AppColors.bottomBarActiveIcon : AppColors.bottomBarPassiveIcon),
                      label: 'Рейтинг',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset('assets/icons/notification.png',width: 24,height: 24,color: tabsRouter.activeIndex==3 ? AppColors.bottomBarActiveIcon : AppColors.bottomBarPassiveIcon),
                      label: 'Уведомвления',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset('assets/icons/profile.png',width: 24,height: 24,color: tabsRouter.activeIndex==4 ? AppColors.bottomBarActiveIcon : AppColors.bottomBarPassiveIcon),
                      label: 'Профиль',
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
