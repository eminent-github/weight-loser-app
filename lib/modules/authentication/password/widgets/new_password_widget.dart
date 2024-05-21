import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';

class CustomShadowNewPasswordTextField extends StatelessWidget {
  const CustomShadowNewPasswordTextField({
    super.key,
    required this.controller,
    this.validatorFunction,
    required this.labelText,
    required this.prefixIcon,
    this.suffixIcon,
    this.iconColor,
    this.iconHeight,
    this.hintTextColor,
    required this.obscuringCharacter,
    this.inputFormatters,
    required this.obscureText,
    this.focusNode,
  });
  final TextEditingController controller;
  final String? Function(String? value)? validatorFunction;
  final IconData prefixIcon;
  final Widget? suffixIcon;
  final String labelText;
  final Color? hintTextColor;
  final Color? iconColor;
  final bool obscureText;
  final String obscuringCharacter;
  final double? iconHeight;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.07,
      width: width * 0.8,
      decoration: BoxDecoration(
        color: const Color(0xFFffffff),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 2.0, // soften the shadow
            spreadRadius: 1.0, //extend the shadow
            offset: const Offset(
              1.0, // Move to right 5  horizontally
              1.0, // Move to bottom 5 Vertically
            ),
          )
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: width * 0.03,
          ),
          Padding(
            padding: EdgeInsets.only(top: height * 0.0),
            child: Icon(
              prefixIcon,
              color: iconColor ?? AppColors.iconColor,
              size: iconHeight ?? height * 0.04,
            ),
          ),
          SizedBox(
            width: width * 0.03,
          ),
          Expanded(
            child: TextFormField(
              style: const TextStyle(
                fontSize: 12,
                fontFamily: AppTextStyles.fontFamily,
              ),
              focusNode: focusNode,
              controller: controller,
              inputFormatters: inputFormatters,
              obscuringCharacter: obscuringCharacter,
              obscureText: obscureText,
              decoration: InputDecoration(
                  hintText: labelText,
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: hintTextColor ?? AppColors.iconColor,
                    fontFamily: AppTextStyles.fontFamily,
                  ),
                  border: InputBorder.none),
            ),
          ),
          SizedBox(
            width: width * 0.03,
          ),
          SizedBox(
            child: suffixIcon,
          ),
          SizedBox(
            width: width * 0.03,
          ),
        ],
      ),
    );
  }
}
