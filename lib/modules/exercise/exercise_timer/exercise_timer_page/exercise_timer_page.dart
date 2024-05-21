import 'dart:developer';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

import '../../../../common/app_text_styles.dart';
import '../../../../widgets/custom_progress_timer/circular_countdown_timer.dart';
import '../controller/exercise_timer_controller.dart';

class ExerciseTimerPage extends GetView<ExerciseTimerController> {
  const ExerciseTimerPage({
    super.key,
    required this.exerciseIndex,
  });
  final int exerciseIndex;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height - kToolbarHeight;
    double width = screenSize.width;
    int remainingTime =
        controller.exerciseItemDetailModel!.userExerciseDuration!;

    return WillPopScope(
      onWillPop: () async {
        log("time ${controller.countDownController.getSeconds()}");
        controller.countDownController.pause();
        controller.videoPlayerController.pause();
        remainingTime == 0
            ? true
            : controller.updateExerciseTime(
                exerciseIndex,
                duration: controller.countDownController.isStarted
                    ? controller.countDownController.getSeconds()!
                    : controller.exerciseItemDetailModel!.userExerciseDuration
                        .toString(),
                exerciseId:
                    controller.exerciseItemDetailModel!.exerciseId.toString(),
                planId: controller.exerciseItemDetailModel!.planId.toString(),
              );
        // Get.back();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Exercise',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          iconTheme: Theme.of(context).iconTheme,
          elevation: 0,
          centerTitle: true,
        ),
        body: InternetCheckWidget<ConnectivityService>(
          child: Obx(
            () => Stack(
              children: [
                SafeArea(
                  child: SizedBox(
                    height: height,
                    width: width,
                    child: Column(
                      children: [
                        controller.isShowVideoPlayer.value
                            ? SizedBox(
                                height: height * 0.3,
                                child: GetBuilder(
                                  init: controller,
                                  builder: (controller) => Container(
                                    width: width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: Colors.black),
                                    child: controller.chewieController !=
                                                null &&
                                            controller.videoPlayerController
                                                .value.isInitialized
                                        ? AspectRatio(
                                            aspectRatio: controller
                                                .videoPlayerController
                                                .value
                                                .aspectRatio,
                                            child: Chewie(
                                              controller:
                                                  controller.chewieController!,
                                            ),
                                          )
                                        : const Center(
                                            child: CircularProgressIndicator()),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: height * 0.02,
                              ),
                              CircularCountDownTimer(
                                width: width * 0.6,
                                height: height * 0.35,
                                controller: controller.countDownController,
                                duration: remainingTime,
                                isReverse: true,
                                autoStart: false,
                                fillColor: const Color(0xffD3D3D3),
                                ringColor: AppColors.buttonColor,
                                strokeWidth: 8,
                                textStyle: AppTextStyles.formalTextStyle(
                                    fontSize: 35.0,
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .titleMedium!
                                        .color!,
                                    fontWeight: FontWeight.bold),
                                // imageUrl: AppAssets.exerciseRunningPerson,
                                onComplete: remainingTime == 0
                                    ? () {}
                                    : () async {
                                        controller.isStopped.value = true;
                                        print(controller.countDownController
                                            .getSeconds()!);
                                        controller.updateExerciseTime(
                                          exerciseIndex,
                                          duration: controller
                                              .countDownController
                                              .getSeconds()!,
                                          exerciseId: controller
                                              .exerciseItemDetailModel!
                                              .exerciseId
                                              .toString(),
                                          planId: controller
                                              .exerciseItemDetailModel!.planId
                                              .toString(),
                                        );
                                        // Get.back();
                                      },
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Text(
                                controller.exerciseItemDetailModel!.name!,
                                style: AppTextStyles.formalTextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .titleMedium!
                                      .color!,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Text(
                                'Every drop of sweat is a step towards your success',
                                style: AppTextStyles.formalTextStyle(
                                  fontSize: 10,
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .titleMedium!
                                      .color!,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.04,
                              ),
                              remainingTime == 0
                                  ? Text(
                                      "Exercise Completed",
                                      style: AppTextStyles.formalTextStyle(
                                        color: AppColors.buttonColor,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )
                                  : Material(
                                      borderRadius: BorderRadius.circular(6),
                                      color: AppColors.buttonColor,
                                      child: InkWell(
                                        onTap: remainingTime == 0
                                            ? () {}
                                            : controller.countDownController
                                                    .isStarted
                                                ? () {
                                                    if (!controller
                                                        .countDownController
                                                        .isPaused) {
                                                      controller
                                                          .countDownController
                                                          .pause();
                                                      controller.isStopped
                                                          .value = true;
                                                    } else {
                                                      controller
                                                          .countDownController
                                                          .resume();
                                                      controller.isStopped
                                                          .value = false;
                                                    }
                                                  }
                                                : () {},
                                        child: SizedBox(
                                          width: width * 0.13,
                                          height: height * 0.06,
                                          child: Icon(
                                            controller.isStopped.value
                                                ? Icons.play_arrow_outlined
                                                : Icons.pause,
                                            color: AppColors.white,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                controller.isLoading.value
                    ? const OverlayWidget()
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
