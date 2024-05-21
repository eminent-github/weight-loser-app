import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_colors.dart';

void customSnackbar({
  String? title,
  String? message,
  Color? colorText,
  Color? backgroundColor,
  Widget? icon,
  int duration = 1500,
}) {
  Get.snackbar(
    title ?? "",
    message ?? "",
    backgroundColor: backgroundColor ?? AppColors.buttonColor,
    colorText: colorText ?? AppColors.white,
    snackPosition: SnackPosition.TOP,
    dismissDirection: DismissDirection.horizontal,
    duration: Duration(milliseconds: duration),
    icon: icon,
    instantInit: false,
    isDismissible: true,
  );
}
