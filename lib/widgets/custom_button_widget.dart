import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';

import '../common/app_colors.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget(
      {super.key,
      this.height,
      this.width,
      this.child,
      this.color,
      this.text,
      this.onPressed,
      this.borderRadius});
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
      color: AppColors.buttonColor,
      borderRadius: borderRadius ?? BorderRadius.circular(2),
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          height: height,
          width: width,
          child: Center(
            child: Text('$text',
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: CupertinoColors.white,
                    fontFamily: AppTextStyles.fontFamily)),
          ),
        ),
      ),
    );
  }
}
