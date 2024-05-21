import 'package:flutter/material.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';

class ProfileCustom extends StatelessWidget {
  const ProfileCustom({
    super.key,
    required this.title,
    required this.onTap,
    required this.width,
    required this.height,
  });
  final String title;
  final VoidCallback onTap;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: width * 0.04,
      ),
      child: Column(
        children: [
          ListTile(
            onTap: onTap,
            title: Text(
              title,
              style: AppTextStyles.formalTextStyle(),
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
              size: 28,
              color: AppColors.arrowColor,
            ),
          ),
          Container(
            height: height * 0.01,
            margin: EdgeInsets.only(right: width * 0.08, left: width * 0.04),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.dividerColor,
                  width: 2.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
