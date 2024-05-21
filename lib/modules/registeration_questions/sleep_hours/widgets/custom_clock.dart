import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';

class MyCustomClock extends StatelessWidget {
  const MyCustomClock({
    super.key,
    required this.height,
    required this.width,
    required this.minutes,
    required this.hours,
    required this.getAMPM,
  });
  final double height;
  final double width;
  final int minutes;
  final int hours;
  final String getAMPM;
  @override
  Widget build(BuildContext context) {
    log("${24 % 12 }");
    return SizedBox(
      height: height * 0.08,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: width * 0.17,
            decoration: BoxDecoration(
              color: AppColors.sleepModuleColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                "${hours % 12 == 0 ? 12 : hours % 12}",
                style: AppTextStyles.formalTextStyle(
                  fontSize: 29.90,
                ),
              ),
            ),
          ),
          Text(
            ':',
            textAlign: TextAlign.center,
            style: AppTextStyles.formalTextStyle(
              fontSize: 37.90,
            ),
          ),
          Container(
            width: width * 0.17,
            decoration: BoxDecoration(
              color: const Color(0xffEDEDED),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                minutes.toString(),
                style: AppTextStyles.formalTextStyle(
                  fontSize: 29.90,
                ),
              ),
            ),
          ),
          Container(
            width: width * 0.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                width: 0.34,
                color: const Color(0xFFDADCE0),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: getAMPM == "AM"
                        ? AppColors.sleepModuleColor
                        : AppColors.white,
                    child: Center(
                      child: Text(
                        'AM',
                        style: AppTextStyles.formalTextStyle(
                          fontSize: 9.48,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: getAMPM == "PM"
                        ? AppColors.sleepModuleColor
                        : AppColors.white,
                    child: Center(
                      child: Text(
                        'PM',
                        style: AppTextStyles.formalTextStyle(
                          fontSize: 9.48,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
