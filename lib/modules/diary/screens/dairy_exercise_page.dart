import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';

class DairyExercisePage extends StatelessWidget {
  const DairyExercisePage({super.key, required this.burnCalories});

  final int burnCalories;
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
            'Calories Burnt',
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
                      '$burnCalories cal',
                      style: AppTextStyles.formalTextStyle(
                        color: Theme.of(context)
                            .primaryTextTheme
                            .titleMedium!
                            .color!,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'out of 80 cal assigned',
                      style: AppTextStyles.formalTextStyle(
                        color: Theme.of(context)
                            .primaryTextTheme
                            .titleMedium!
                            .color!,
                        fontSize: 9,
                        fontWeight: FontWeight.w400,
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
                  percent: burnCalories > 80 ? 1 : burnCalories / 80,
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
