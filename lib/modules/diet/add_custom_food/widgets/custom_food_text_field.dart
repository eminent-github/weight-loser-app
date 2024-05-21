import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';

class CustomFoodTextField extends StatelessWidget {
  const CustomFoodTextField(
      {super.key,
      required this.controller,
      required this.labelText,
      this.suffixText,
      this.iconColor,
      this.iconHeight,
      this.hintTextColor,
      this.keyboardType,
      this.inputFormatters});
  final TextEditingController controller;

  final String? suffixText;
  final String labelText;
  final Color? hintTextColor;
  final Color? iconColor;

  final double? iconHeight;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.07,
      // width: width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.editProfileFieldColor,
      ),
      child: Row(
        children: [
          SizedBox(
            width: width * 0.05,
          ),
          Expanded(
            child: TextFormField(
              style: AppTextStyles.formalTextStyle(
                fontSize: 12,
              ),
              controller: controller,
              inputFormatters: inputFormatters,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                hintText: labelText,
                hintStyle: AppTextStyles.formalTextStyle(
                  fontSize: 12,
                  color: hintTextColor ?? AppColors.iconColor,
                ),
                suffixText: suffixText,
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            width: width * 0.05,
          ),
        ],
      ),
    );
  }
}
