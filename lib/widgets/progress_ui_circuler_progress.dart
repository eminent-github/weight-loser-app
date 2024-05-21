import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';

class CircularProgressIndicatorUi extends StatelessWidget {
  const CircularProgressIndicatorUi(
      {super.key,
      required this.size,
      required this.progress,
      this.progressCategory = "",
      this.progressColor = Colors.black,
      this.textColor = Colors.black,
      required this.progressType,
      required this.underText});

  final double size;
  final double progress;
  final String progressCategory;
  final String progressType;
  final Color progressColor;
  final Color textColor;
  final String underText;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;

    return SizedBox(
      height: height * 0.14,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              height: height * 0.11,
              width: width * 0.22,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: const Color(0xffAFD3E2)),
                  borderRadius: BorderRadius.circular(20)),
              child: CircularPercentIndicator(
                radius: size,
                percent: progress,
                startAngle: 90,
                lineWidth: 6.5,
                progressColor: progressColor,
                circularStrokeCap: CircularStrokeCap.round,
                center: Text(
                  progressType,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 13,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )),
          Text(
            underText,
            style: const TextStyle(
              color: Color(0xFF454545),
              fontSize: 13,
              fontFamily: AppTextStyles.fontFamily,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
