import 'dart:math';

import 'package:flutter/material.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_text_styles.dart';
import '../../../common/app_texts.dart';

class QusNextButton extends StatelessWidget {
  const QusNextButton({
    super.key,
    required this.callBack,
    required this.height,
    required this.width,
    this.text,
  });
  final VoidCallback callBack;
  final double height;
  final double width;
  final String? text;

  @override
  Widget build(BuildContext context) {
    var textSize = min(width, height);
    return Material(
      color: AppColors.blue,
      elevation: 4.0,
      borderRadius: BorderRadius.circular(6.0),
      child: InkWell(
        onTap: callBack,
        borderRadius: BorderRadius.circular(6.0),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Center(
            child: Text(
              text ?? AppTexts.next,
              style: TextStyle(
                fontSize: textSize * 0.3,
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontFamily: AppTextStyles.fontFamily,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
