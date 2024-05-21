import 'package:flutter/material.dart';
import 'package:weight_loss_app/common/app_colors.dart';

class CallComponents extends StatelessWidget {
  const CallComponents({
    super.key,
    required this.callIcon,
    required this.onTap,
    this.backgroundColor,
  });
  final IconData callIcon;
  final VoidCallback onTap;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Material(
      color: backgroundColor ?? AppColors.buttonColor,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: SizedBox(
          width: width * 0.15,
          height: height * 0.08,
          child: Center(
            child: Icon(
              callIcon,
              color: AppColors.white,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
