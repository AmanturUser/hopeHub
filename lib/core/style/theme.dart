import 'package:flutter/material.dart';
import 'package:hope_hub/core/style/app_colors.dart';

import 'app_text_styles.dart';

var themeData = ThemeData(
  // Base colors
  primaryColor: const Color(0xFF2B2B2B),
  scaffoldBackgroundColor: AppColors.scaffoldBackground,
  // Cream background color
  // Text theme
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Color(0xFF2B2B2B),
    ),
    titleLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Color(0xFF2B2B2B),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
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

  // AppBar theme
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    surfaceTintColor: AppColors.scaffoldBackground,
    backgroundColor: AppColors.scaffoldBackground,
    elevation: 4,
    shadowColor: Color(0xFF171D01),
    iconTheme: IconThemeData(color: Color(0xFF2F3036)),
    titleTextStyle: TextStyle(
      color: Color(0xFF2F3036),
      fontSize: 24,
      fontWeight: FontWeight.w600,
    ),
  ),

  // Card theme
  cardTheme: CardTheme(
    color: AppColors.card,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    margin: const EdgeInsets.only(
      bottom: 14,
    ),
  ),

  // List tile theme
  listTileTheme: const ListTileThemeData(
    contentPadding: EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),
    minLeadingWidth: 0,
    titleTextStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xFF2B2B2B),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shadowColor: const Color(0xFF324000),
      padding: const EdgeInsets.all(16),
      // Padding 16px
      backgroundColor: const Color(0xFF899F3B),
      // Green main color #899F3B
      foregroundColor: Colors.white,
      elevation: 0,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Radius 12px
        side: const BorderSide(
          color: Color(0xFF607516), // Border color #607516
          width: 1, // Border width 1px
        ),
      ),
    ).copyWith(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          return const Color(0xFF899F3B); // Green main color
        },
      ),
      foregroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          return Colors.white;
        },
      ),
    ),
  ),
  progressIndicatorTheme:
      const ProgressIndicatorThemeData(color: AppColors.mainGreen),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFFFFFDEB),
    selectedItemColor: Color(0xFF899F3B), // Цвет активного элемента (зеленый)
    unselectedItemColor: Color(0xFFC8CEB3), // Цвет неактивных элементов
    selectedIconTheme: IconThemeData(size: 24),
    unselectedIconTheme: IconThemeData(size: 24),
    selectedLabelStyle: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w600,
      color: Color(0xFF899F3B)
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: Color(0xFFB6BBA6)
    ),
    type: BottomNavigationBarType.fixed, // Фиксированный стиль без смещений
    showSelectedLabels: true,
    showUnselectedLabels: true,
  ),

);
