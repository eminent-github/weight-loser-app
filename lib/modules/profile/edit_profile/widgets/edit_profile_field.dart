import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';

class EditProfileTextField extends StatelessWidget {
  const EditProfileTextField(
      {super.key,
      required this.controller,
      required this.labelText,
      this.suffixIcon,
      this.iconColor,
      this.iconHeight,
      this.hintTextColor,
      this.readOnly = false,
      this.keyboardType,
      this.inputFormatters});
  final TextEditingController controller;

  final Widget? suffixIcon;
  final String labelText;
  final Color? hintTextColor;
  final Color? iconColor;
  final bool readOnly;
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
        color: readOnly
            ? const Color.fromARGB(255, 235, 235, 235)
            : AppColors.editProfileFieldColor,
      ),
      child: Row(
        children: [
          SizedBox(
            width: width * 0.06,
          ),
          SizedBox(
            width: width * 0.663,
            child: TextFormField(
              readOnly: readOnly,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: AppTextStyles.fontFamily,
                color: AppColors.black
              ),
              controller: controller,
              inputFormatters: inputFormatters,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                suffixIcon: suffixIcon,
                hintText: labelText,
                hintStyle: TextStyle(
                  fontSize: 12,
                  color: hintTextColor ?? AppColors.iconColor,
                  fontFamily: AppTextStyles.fontFamily,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
