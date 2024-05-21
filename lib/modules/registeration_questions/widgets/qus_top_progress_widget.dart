import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_text_styles.dart';

class QusTopProgressWidget extends StatelessWidget {
  const QusTopProgressWidget({
    super.key,
    required this.progress,
    this.height = 15,
    this.width = 100,
    this.titleTextColor = AppColors.black,
    this.progressColor = AppColors.themeColor,
    required this.title,
  });
  final double progress;
  final double height;
  final double width;
  final String title;
  final Color titleTextColor;
  final Color progressColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: titleTextColor,
            fontSize: 9,
            fontFamily: AppTextStyles.fontFamily,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(
          height: height,
        ),
        LinearPercentIndicator(
          width: width,
          // animation: true,
          lineHeight: height,
          // animationDuration: 500,
          percent: progress,
          backgroundColor:const Color(0xffC7C7C7),
          barRadius: const Radius.circular(20),
          progressColor: progressColor,
          alignment: MainAxisAlignment.center,
          padding: const EdgeInsets.all(0),
        ),
      ],
    );
  }
}
