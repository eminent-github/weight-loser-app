import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';

class DairyMindPage extends StatelessWidget {
  const DairyMindPage(
      {super.key,
      required this.meditationTime,
      required this.totalMeditationTime});
  final int meditationTime;
  final int totalMeditationTime;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height * 0.05,
          ),
          Text(
            'Meditation Progress',
            style: AppTextStyles.formalTextStyle(
              color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
            ),
          ),
          SizedBox(
            height: height * 0.015,
          ),
          Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      meditationTime < 60
                          ? '$meditationTime Seconds'
                          : "${meditationTime ~/ 60} Minutes",
                      style: AppTextStyles.formalTextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context)
                            .primaryTextTheme
                            .titleMedium!
                            .color!,
                      ),
                    ),
                    Text(
                      'Total Time',
                      style: AppTextStyles.formalTextStyle(
                        fontSize: 9,
                        color: Theme.of(context)
                            .primaryTextTheme
                            .titleMedium!
                            .color!,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                LinearPercentIndicator(
                  animation: true,
                  lineHeight: height * .013,
                  percent: meditationTime / totalMeditationTime == 0.0
                      ? 0
                      : meditationTime / totalMeditationTime,
                  barRadius: const Radius.circular(20),
                  progressColor: AppColors.buttonColor,
                  padding: const EdgeInsets.all(0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
