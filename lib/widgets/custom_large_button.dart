import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import '../common/app_text_styles.dart';

class CustomLargeButton extends StatelessWidget {
  const CustomLargeButton(
      {super.key,
      this.height,
      this.width,
      this.child,
      this.color,
      this.text,
      this.borderRadius,
      this.onPressed});
  final Color? color;
  final double? height;
  final double? width;
  final Widget? child;
  final String? text;
  final VoidCallback? onPressed;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? AppColors.buttonColor,
      borderRadius: borderRadius ?? BorderRadius.circular(5),
      child: InkWell(
        onTap: onPressed,
        borderRadius: borderRadius ?? BorderRadius.circular(5),
        // splashColor: AppColors.white,
        child: Container(
          height: height! * 0.07,
          width: width,
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: AppColors.buttonColor.withOpacity(0.2),
                blurRadius: 2,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: child ??
                AutoSizeText(
                  '$text',
                  minFontSize: 10,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: AppTextStyles.fontFamily,
                    fontWeight: FontWeight.w700,
                    color: CupertinoColors.white,
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
