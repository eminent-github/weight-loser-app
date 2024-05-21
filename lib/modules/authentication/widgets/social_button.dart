import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/app_colors.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.height,
    required this.width,
    required this.iconPath,
    this.iconColor,
    required this.callback,
  });

  final double height;
  final double width;
  final String iconPath;
  final Color? iconColor;

  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      elevation: 15,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: callback,
        borderRadius: BorderRadius.circular(15),
        child: SizedBox(
          height: height * 0.07,
          width: width * 0.14,
          child: Center(
            child: SvgPicture.asset(
              iconPath,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
