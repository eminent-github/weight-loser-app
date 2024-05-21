import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/cbt/cbt_applause_done/binding/cbt_done_binding.dart';
import 'package:weight_loss_app/modules/cbt/cbt_applause_done/view/cbt_done_page.dart';
import 'package:weight_loss_app/modules/cbt/scoring/controller/scoring_controller.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_large_button.dart';

class ScoringPage extends GetView<ScoringController> {
  const ScoringPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    double height = size.height;
    double width = size.width;
    double progressRadious = min(width, height);
    return Scaffold(
      body: InternetCheckWidget<ConnectivityService>(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Great!',
                  style: AppTextStyles.formalTextStyle(
                    color: AppColors.buttonColor,
                    fontSize: 44,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                CircularPercentIndicator(
                  center: Container(
                    height: height * 0.4,
                    width: width * 0.5,
                    decoration: const BoxDecoration(
                        color: Color(0xFFF6F6F6), shape: BoxShape.circle),
                    child: Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'W',
                              style: AppTextStyles.formalTextStyle(
                                fontSize: 70,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: 'L',
                              style: AppTextStyles.formalTextStyle(
                                fontSize: 70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  radius: progressRadious * 0.27,
                  lineWidth: 8,
                  restartAnimation: true,
                  animationDuration: 800,
                  animation: true,
                  percent: 0.75,
                  circularStrokeCap: CircularStrokeCap.round,
                  startAngle: 90,
                  backgroundColor: Colors.transparent,
                  // fillColor: const Color(0xFFF6F6F6),
                  progressColor: AppColors.buttonColor,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'You Have gained',
                      style: AppTextStyles.formalTextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(
                      '20+ Score',
                      style: AppTextStyles.formalTextStyle(
                        color: AppColors.buttonColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                LinearPercentIndicator(
                  center: Text(
                    'Redeem Score',
                    style: AppTextStyles.formalTextStyle(
                      color: controller.scoringPercent > 0.4
                          ? AppColors.white
                          : AppColors.black,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  lineHeight: height * 0.03,
                  barRadius: const Radius.circular(50),
                  width: width * 0.8,
                  restartAnimation: true,
                  animationDuration: 800,
                  animation: true,
                  percent: controller.scoringPercent,
                  backgroundColor: const Color(0xffD9D9D9),
                  progressColor: AppColors.buttonColor,
                  alignment: MainAxisAlignment.center,
                ),
                CustomLargeButton(
                  height: height,
                  width: width * 0.5,
                  text: "Next",
                  onPressed: () {
                    Get.off(() => const CbtDonePage(totalOptions: 6),
                        binding: CbtDoneBinding());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
