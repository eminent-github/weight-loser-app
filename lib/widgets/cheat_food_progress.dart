import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';

class CheatFoodProgress extends StatelessWidget {
  const CheatFoodProgress({
    super.key,
    required this.size,
    required this.progress,
    this.progressColor = Colors.black,
    required this.remainingProgress,
  });
  final double size;
  final double progress;
  final double remainingProgress;
  final Color progressColor;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.sizeOf(context);
    double height = screenHeight.height - kToolbarHeight;
    double width = screenHeight.width;

    return CircularPercentIndicator(
      backgroundColor: const Color(0xffF7B149),
      radius: size,
      percent: progress,
      startAngle: 90,
      lineWidth: 14,
      progressColor: progressColor,
      circularStrokeCap: CircularStrokeCap.round,
      center: SizedBox(
        width: width * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: width * 0.045,
                  height: height * 0.03,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2E8332),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(
                  width: width * 0.03,
                ),
                Expanded(
                  child: AutoSizeText(
                    'Cheat Food: ${progress * 100}%',
                    minFontSize: 5,
                    style: AppTextStyles.formalTextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: width * 0.045,
                  height: height * 0.03,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF7B149),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(
                  width: width * 0.03,
                ),
                Expanded(
                  child: AutoSizeText(
                    'Remaining: ${remainingProgress * 100}%',
                    minFontSize: 5,
                    style: AppTextStyles.formalTextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
