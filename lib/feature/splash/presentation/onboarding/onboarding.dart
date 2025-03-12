import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hope_hub/core/style/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/auto_route/auto_route.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  bool isLastPage = false;
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              isLastPage = index == 2;
              pageIndex = index;
            });
          },
          children: [
            OnboardingPage(
              pageIndex: pageIndex,
              pageController: _pageController,
              backgroundColor: AppColors.scaffoldBackground,
              title:
                  'Добро пожаловать\nв школьную платформу\nVirtual Volunteer Club!',
              subtitle: '',
              child: Image.asset('assets/icons/people.png', width: 351),
            ),
            OnboardingSecondPage(
              pageIndex: pageIndex,
              pageController: _pageController,
              backgroundColor: AppColors.mainGreen,
              title:
                  'Мы верим, что у каждого из\nнас есть возможность стать\nлидером и изменить мир\nк лучшему!',
              subtitle: '',
              child: Image.asset('assets/icons/people2.png', width: 301),
            ),
            OnboardingThirdPage(
              pageIndex: pageIndex,
              pageController: _pageController,
              backgroundColor: const Color(0xFFFDF6E9),
              title: 'Готовы начать?',
              subtitle: '',
              child: SizedBox(),
            ),
          ],
        ));
  }
}


class OnboardingPage extends StatelessWidget {
  final String title;
  final PageController pageController;
  final String subtitle;
  final Widget child;
  final Color backgroundColor;
  final int pageIndex;

  const OnboardingPage({
    Key? key,
    required this.pageController,
    required this.title,
    required this.subtitle,
    required this.child,
    required this.backgroundColor,
    required this.pageIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            child: Image.asset('assets/icons/subtract.png', height: 259),
          ),
          Positioned(
            left: -70,
            bottom: 43,
            child: child,
          ),
          Positioned(
            right: 20,
            bottom: 30,
            child: Image.asset('assets/icons/goodNeighbors.png', width: 200),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              Center(
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: 3,
                  effect: WormEffect(
                    dotHeight: 4,
                    dotWidth: 21,
                    spacing: 14,
                    dotColor: const Color(0xFFC7CFAC),
                    activeDotColor: pageIndex == 1
                        ? const Color(0xFFF1A025)
                        : AppColors.mainGreen,
                  ),
                  onDotClicked: (index) {
                    pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                ),
              ),
              const SizedBox(height: 100),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF63694F),
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer()
            ],
          ),
        ],
      ),
    );
  }
}

class OnboardingSecondPage extends StatelessWidget {
  final String title;
  final PageController pageController;
  final String subtitle;
  final Widget child;
  final Color backgroundColor;
  final int pageIndex;

  const OnboardingSecondPage({
    Key? key,
    required this.pageController,
    required this.title,
    required this.subtitle,
    required this.child,
    required this.backgroundColor,
    required this.pageIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            child: Image.asset('assets/icons/subtract.png', height: 259),
          ),
          Positioned(
            right: -30,
            bottom: 150,
            child: child,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              Center(
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: 3,
                  effect: WormEffect(
                    dotHeight: 4,
                    dotWidth: 21,
                    spacing: 14,
                    dotColor: Colors.black26,
                    activeDotColor: pageIndex == 1
                        ? const Color(0xFFF1A025)
                        : AppColors.mainGreen,
                  ),
                  onDotClicked: (index) {
                    pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                ),
              ),
              const SizedBox(height: 80),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Image.asset('assets/icons/goodNeighborsWhite.png',
                    width: 200),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class OnboardingThirdPage extends StatelessWidget {
  final String title;
  final PageController pageController;
  final String subtitle;
  final Widget child;
  final Color backgroundColor;
  final int pageIndex;
  final storage = const FlutterSecureStorage();

  const OnboardingThirdPage({
    Key? key,
    required this.pageController,
    required this.title,
    required this.subtitle,
    required this.child,
    required this.backgroundColor,
    required this.pageIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            child: Image.asset('assets/icons/subtract.png', height: 259),
          ),
          Positioned(
            right: -100,
            bottom: 80,
            child: Image.asset('assets/icons/people.png', width: 361),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              Center(
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: 3,
                  effect: WormEffect(
                    dotHeight: 4,
                    dotWidth: 21,
                    spacing: 14,
                    dotColor: const Color(0xFFC7CFAC),
                    activeDotColor: pageIndex == 1
                        ? const Color(0xFFF1A025)
                        : AppColors.mainGreen,
                  ),
                  onDotClicked: (index) {
                    pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                ),
              ),
              const SizedBox(height: 100),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF63694F),
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: 350,
                      child: ElevatedButton(
                        onPressed: () async{
                          await storage.write(key: 'onboard', value: 'onboard');
                          AutoRouter.of(context).replace(const SignInRoute());
                        },
                        child: const Text('Старт'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF1A025)),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Image.asset('assets/icons/goodNeighbors.png', width: 211),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
