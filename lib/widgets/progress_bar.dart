import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';

class CirculerProgress extends StatelessWidget {
  const CirculerProgress(
      {super.key,
      required this.size,
      required this.progress,
      this.progressCategory = "",
      this.progressColor = Colors.black,
      this.textColor = Colors.black,
      required this.progressType,
      required this.progressText,
      this.onTap,
      this.lineWidth = 6});
  final double size;
  final double progress;
  final String progressText;
  final String progressCategory;
  final String progressType;
  final Color progressColor;
  final Color textColor;
  final double lineWidth;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    // print(progress);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: CircularPercentIndicator(
        radius: size,
        percent: progress,
        startAngle: 90,
        lineWidth: lineWidth,
        progressColor: progressColor,
        circularStrokeCap: CircularStrokeCap.round,
        center: Padding(
          padding: EdgeInsets.symmetric(horizontal: size * 0.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                progressType,
                textAlign: TextAlign.center,
                minFontSize: 5,
                style: AppTextStyles.formalTextStyle(
                  fontSize: 10,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AutoSizeText(
                progressText,
                maxLines: 2,
                textAlign: TextAlign.center,
                minFontSize: 5,
                style: AppTextStyles.formalTextStyle(
                  fontSize: 11,
                  color: textColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
