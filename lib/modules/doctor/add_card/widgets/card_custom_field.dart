import 'package:flutter/material.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';

class CardCustomField extends StatelessWidget {
  const CardCustomField({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.maxLength,
  });
  final String title;
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final int? maxLength;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.formalTextStyle(
            color: const Color(0xFF0D0D0D),
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Container(
          height: height * 0.07,
          decoration: ShapeDecoration(
            color: AppColors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 0.7,
                color: Color(0xFFE0F4FF),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: TextField(
                controller: controller,
                keyboardType: keyboardType,
                style: AppTextStyles.formalTextStyle(
                  fontSize: 12,
                ),
                maxLength: maxLength,
                buildCounter: (context,
                        {required currentLength,
                        required isFocused,
                        maxLength}) =>
                    null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: AppTextStyles.formalTextStyle(
                    color: const Color(0xFFA5BECC),
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
