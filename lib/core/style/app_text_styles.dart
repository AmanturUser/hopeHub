import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle splash = TextStyle(
      color: AppColors.white,
      fontSize: 24,
      fontWeight: FontWeight.w600,
  );
  static TextStyle authLogoText = const TextStyle(
    color: AppColors.authLogo,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
  static TextStyle authText = const TextStyle(
    color: AppColors.authText,
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );
  static TextStyle authEmailLabel = const TextStyle(
    color: AppColors.authText,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
  static TextStyle formHint = const TextStyle(
    color: AppColors.formHint,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static TextStyle error = const TextStyle(
    color: AppColors.error,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static TextStyle appBar = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  static TextStyle detail = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textMain
  );

  static TextStyle subDetail = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.textMain
  );
}