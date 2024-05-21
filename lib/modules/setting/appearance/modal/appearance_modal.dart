import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../common/app_colors.dart';

class ModalAppearance {
  final String text;
  final Color color;
  final IconData iconData;
  final Color iconColor;

  ModalAppearance(
      {required this.text,
      required this.color,
      required this.iconData,
      required this.iconColor});
}

List modalAppearance = [
  ModalAppearance(
      text: 'Light',
      color: Colors.white,
      iconData: Icons.check_circle,
    iconColor: AppColors.buttonColor
      ),
  ModalAppearance(
      text: 'Dark',
      color: Color(0xff6A6A6A),
      iconData: Icons.check_circle_outline,
      iconColor: AppColors.white),
  ModalAppearance(
      text: 'System Default',
      color: Color(0xffFAFAFA),
      iconData: Icons.check_circle_outline,
      iconColor: AppColors.white),
];
