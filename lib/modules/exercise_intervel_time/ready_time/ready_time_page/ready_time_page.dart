import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/modules/exercise_intervel_time/workouts/binding/workout_binding.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../workouts/workout_page/workout_page.dart';
import '../controller/ready_time_controller.dart';
import '../widgets/custom_ready_time_timer/circular_countdown_timer.dart';

class ReadyTimePage extends GetView<ReadyTimeController> {
  const ReadyTimePage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData(color: AppColors.black),
        elevation: 0,
      ),
      body: InternetCheckWidget<ConnectivityService>(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.07,
              ),
              SvgPicture.asset(
                AppAssets.exerciseSvgUrl,
                height: height * 0.35,
              ),
              SizedBox(
                height: height * 0.07,
              ),
              Text(
                'Ready to go!',
                style: AppTextStyles.formalTextStyle(
                  color: AppColors.buttonColor,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                'Jumping Jacks',
                style: AppTextStyles.formalTextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              SizedBox(
                width: width,
                height: height * 0.12,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: CircularReadyTimeTimer(
                        width: width * 0.24,
                        height: height * 0.12,
                        fillColor: AppColors.buttonColor,
                        ringColor: AppColors.progressBackgroundColor,
                        duration: 12,
                        textStyle: AppTextStyles.formalTextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                        isReverse: true,
                        strokeCap: StrokeCap.round,
                        isReverseAnimation: true,
                        supportText: "s",
                        startAngleValue: 1.5,
                        onComplete: () {
                          Get.off(() => const WorkoutPage(),
                              binding: WorkoutBinding());
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      top: 0,
                      right: width * 0.15,
                      child: IconButton(
                        onPressed: () {
                          Get.off(() => const WorkoutPage(),
                              binding: WorkoutBinding());
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
