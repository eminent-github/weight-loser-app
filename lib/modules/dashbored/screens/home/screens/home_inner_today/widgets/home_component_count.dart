import 'package:flutter/material.dart';

import '../../../../../../../common/app_colors.dart';
import '../../../../../../../common/app_text_styles.dart';

class HomeComponentCount extends StatelessWidget {
  const HomeComponentCount(
      {super.key,
      required this.height,
      required this.width,
      required this.count,
      required this.title});
  final double height;
  final double width;
  final int count;
  final String title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.05,
      width: width * 0.9,
      child: Row(
        children: [
          Container(
            height: height * 0.035,
            width: width * 0.06,
            decoration: BoxDecoration(
              color: AppColors.buttonColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                count.toString(),
                textAlign: TextAlign.center,
                style: AppTextStyles.formalTextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(
            width: width * 0.03,
          ),
          Text(
            title,
            style: AppTextStyles.formalTextStyle(
              color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
