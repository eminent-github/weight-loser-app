import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/modules/registeration_questions/widgets/qus_bottom_progress.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';
import '../../../../widgets/qus_understand_widget.dart';
import '../../widgets/qus_next_button.dart';
import '../../widgets/qus_top_progress_widget.dart';
import '../../widgets/transitions.dart';
import '../controller/sleep_hours_controller.dart';
import '../widgets/custom_clock.dart';

class SleepHoursPage extends GetView<SleepHoursController> {
  const SleepHoursPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Scaffold(
      body: InternetCheckWidget<ConnectivityService>(
        child: SafeArea(
          child: Obx(
            () => Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: height * 0.1,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: SizedBox(
                                  height: height,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.02),
                                    child: const Icon(
                                        Icons.arrow_back_ios_new_rounded),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    QusTopProgressWidget(
                                      progress: secondModuleTotalScreen /
                                          secondModuleTotalScreen,
                                      title: AppTexts.qusSecondModule,
                                      height: height * 0.008,
                                      width: width * 0.15,
                                      titleTextColor: AppColors.greyDim,
                                      progressColor: AppColors.dietModuleColor,
                                    ),
                                    QusTopProgressWidget(
                                      progress: thirdModuleTotalScreen /
                                          thirdModuleTotalScreen,
                                      title: AppTexts.qusThirdModule,
                                      height: height * 0.008,
                                      width: width * 0.15,
                                      titleTextColor: AppColors.greyDim,
                                      progressColor:
                                          AppColors.exerciseModuleColor,
                                    ),
                                    QusTopProgressWidget(
                                      progress: 0 / fourthModuleTotalScreen,
                                      title: AppTexts.qusFourthModule,
                                      height: height * 0.008,
                                      width: width * 0.15,
                                      titleTextColor: AppColors.black,
                                      progressColor: AppColors.sleepModuleColor,
                                    ),
                                    QusTopProgressWidget(
                                      progress: 0,
                                      title: AppTexts.qusFifthModule,
                                      height: height * 0.008,
                                      width: width * 0.15,
                                      titleTextColor: AppColors.greyDim,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.27,
                          child: UnderstandWidget(
                            headerText: AppTexts.sleepRoutineTitleText,
                            requestText: controller.getQuestionWithAnswerModel
                                        .value.response ==
                                    null
                                ? AppTexts.qusUnderstandSleepHoursText
                                : controller.getQuestionWithAnswerModel.value
                                    .response!.question!,
                            color: AppColors.sleepModuleColor,
                            height: height * 0.27,
                            width: width,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.27,
                      width: width * 0.55,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await controller.startSelectedTime(context);
                            },
                            child: MyCustomClock(
                              height: height,
                              width: width,
                              minutes: controller.startTime.value.minute,
                              hours: controller.startTime.value.hour,
                              getAMPM: controller.getStartAMPM(),
                            ),
                          ),
                          Text(
                            'To',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.formalTextStyle(
                              fontSize: 18,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await controller.endSelectedTime(context);
                            },
                            child: MyCustomClock(
                              height: height,
                              width: width,
                              minutes: controller.endTime.value.minute,
                              hours: controller.endTime.value.hour,
                              getAMPM: controller.getEndAMPM(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    QusNextButton(
                      height: height * 0.07,
                      width: width * 0.5,
                      callBack: () {
                        if (controller.endTime.value.hour !=
                            controller.startTime.value.hour) {
                          controller.sleepingHoursAnswerApi(
                            controller.getQuestionWithAnswerModel.value
                                .response!.order!,
                            controller
                                .getQuestionWithAnswerModel.value.response!.id!,
                            '${controller.startTime.value.format(context)} To ${controller.endTime.value.format(context)}',
                          );
                        } else {
                          customSnackbar(
                              title: "Alert",
                              message: "Please select correct sleep hours.");
                        }
                      },
                    ),
                    SizedBox(
                      height: height * 0.1,
                      width: width * 0.85,
                      child: QusLinearProgress(
                        width: width * 0.6,
                        height: height * 0.015,
                        progress: 10 / totalScreens,
                        progressText: "${(10 * (100 / totalScreens)).round()}",
                      ),
                    ),
                  ],
                ),
                controller.isLoading.value ? const OverlayWidget() : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
