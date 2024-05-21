import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_text_styles.dart';

class CustomPasswordTextField extends StatelessWidget {
  const CustomPasswordTextField({
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
    required this.obscureText,
    this.focusNode,
    this.inputFormatters,
    this.textInputAction,
    this.keyboardType,
    this.validator,
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
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * 0.8,
      // height: height * 0.1,
      child: TextFormField(
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontSize: 11,
          fontFamily: AppTextStyles.fontFamily,
        ),
        maxLength: 30,
      
        buildCounter: (context,
                {required currentLength, required isFocused, maxLength}) =>
            const SizedBox(),
        focusNode: focusNode,
        controller: controller,
        inputFormatters: inputFormatters,
        obscuringCharacter: obscuringCharacter,
        validator: validator,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: BorderSide(
              color: AppColors.textBorderColor,
              width: 1,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: BorderSide(
              color: AppColors.textBorderColor,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(
              color: AppColors.red,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: BorderSide(
              color: AppColors.textBorderColor,
              width: 1,
            ),
          ),
          errorMaxLines: 2,
          prefixIcon: Icon(
            prefixIcon,
            color: iconColor ?? AppColors.iconColor,
            size: iconHeight ?? height * 0.03,
          ),
          suffixIcon: suffixIcon,
          label: Text(
            labelText,
            style: TextStyle(
              fontSize: 12,
              color: hintTextColor ?? AppColors.iconColor,
              fontFamily: AppTextStyles.fontFamily,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
