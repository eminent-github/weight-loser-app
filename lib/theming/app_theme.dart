import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';

class AppTheme {
  AppTheme._();

  // Light Theme
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      titleTextStyle: AppTextStyles.formalTextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: AppColors.buttonColor),
      iconTheme: const IconThemeData(color: AppColors.black),
    ),
    primaryTextTheme: TextTheme(
      titleMedium: AppTextStyles.formalTextStyle(color: AppColors.black),
      titleSmall: AppTextStyles.formalTextStyle(color: const Color(0xFF666666)),
    ),
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.blue, background: AppColors.white),
    iconTheme: const IconThemeData(color: AppColors.black),
    cardTheme: CardTheme(color: AppColors.buttonColor),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[850],
      systemOverlayStyle: SystemUiOverlayStyle.light,
      titleTextStyle: AppTextStyles.formalTextStyle(
          fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.white),
      iconTheme: const IconThemeData(color: AppColors.white),
    ),
    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.blue, background: Colors.grey[850]),
    primaryTextTheme: TextTheme(
      titleMedium: AppTextStyles.formalTextStyle(color: AppColors.white),
      titleSmall: AppTextStyles.formalTextStyle(color: AppColors.white),
    ),
    scaffoldBackgroundColor: Colors.grey[850],
    iconTheme: const IconThemeData(color: AppColors.white),
    cardTheme: const CardTheme(color: AppColors.white),
  );
}
