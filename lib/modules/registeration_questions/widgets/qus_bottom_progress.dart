import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_text_styles.dart';

class QusLinearProgress extends StatelessWidget {
  const QusLinearProgress({
    super.key,
    required this.progress,
    this.height = 15,
    this.width = 100,
    required this.progressText,
  });
  final double progress;
  final double height;
  final double width;
  final String progressText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LinearPercentIndicator(
          width: width * 0.95,
          animation: true,
          lineHeight: height,
          animationDuration: 500,
          percent: progress,
          backgroundColor: const Color(0xffC7C7C7),
          barRadius: const Radius.circular(20),
          progressColor: AppColors.themeColor,
          alignment: MainAxisAlignment.center,
          padding: const EdgeInsets.all(0),
        ),
        AutoSizeText(
          "$progressText% Complete",
          minFontSize: 5,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            fontFamily: AppTextStyles.fontFamily,
          ),
        )
      ],
    );
  }
}
