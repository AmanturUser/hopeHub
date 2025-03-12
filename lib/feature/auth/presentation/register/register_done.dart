import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hope_hub/core/auto_route/auto_route.dart';

import '../../../../core/style/app_text_styles.dart';

class RegisterDoneScreen extends StatelessWidget {
  const RegisterDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Column(
                children: [
                  Text(
                    'Поздравляем!',
                    style: AppTextStyles.authText,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Вы теперь часть крутого сообщества',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.authText.copyWith(fontSize: 24,fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 48),
                  // Смайлик
                  Container(

                    height: 150,
                    child: Image.asset('assets/icons/smile.png'),
                  ),
                ],
              ),

              // Кнопка
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        AutoRouter.of(context)
                            .replaceAll([const HomeRoute()]);
                        // Добавьте здесь обработку нажатия
                      },
                      child: const Text(
                        'Начать',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
