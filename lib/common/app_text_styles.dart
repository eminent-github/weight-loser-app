import 'package:flutter/material.dart';
import 'package:weight_loss_app/common/app_colors.dart';

class AppTextStyles {
  static const String fontFamily = "Poppins";

  static TextStyle formalTextStyle({
    Color color = AppColors.black,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  static const discountPaymentTimerTitle = TextStyle(
    color: Color(0xFF434343),
    fontSize: 12,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
  );
  static const discountPaymentTimer = TextStyle(
    color: Color(0xFFFF003A),
    fontSize: 31,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
  );

  static const bottomAppbarStyle = TextStyle(
    color: Color(0xFFF6F1F1),
    fontSize: 8,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
  );

  static BoxShadow boxShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.1),
    spreadRadius: 10,
    blurRadius: 10,
    offset: const Offset(0, 3),
  );
}
