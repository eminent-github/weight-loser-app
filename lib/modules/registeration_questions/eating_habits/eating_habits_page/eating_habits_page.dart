import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/modules/registeration_questions/widgets/transitions.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';
import '../../../../widgets/qus_understand_widget.dart';
import '../../widgets/qus_bottom_progress.dart';
import '../../widgets/qus_next_button.dart';
import '../../widgets/qus_top_progress_widget.dart';
import '../controller/eating_habits_controller.dart';

class EatingHabitsPage extends GetView<EatingHabitsController> {
  const EatingHabitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double height = screenSize.height;
    double width = screenSize.width;
    return Scaffold(
      body: InternetCheckWidget<ConnectivityService>(
        child: Obx(
          () => Stack(
            children: [
              SafeArea(
                child: Column(
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
                                      progress: 0 / secondModuleTotalScreen,
                                      title: AppTexts.qusSecondModule,
                                      height: height * 0.008,
                                      width: width * 0.15,
                                      titleTextColor: AppColors.black,
                                      progressColor: AppColors.dietModuleColor,
                                    ),
                                    QusTopProgressWidget(
                                      progress: 0,
                                      title: AppTexts.qusThirdModule,
                                      height: height * 0.008,
                                      width: width * 0.15,
                                      titleTextColor: AppColors.greyDim,
                                    ),
                                    QusTopProgressWidget(
                                      progress: 0,
                                      title: AppTexts.qusFourthModule,
                                      height: height * 0.008,
                                      width: width * 0.15,
                                      titleTextColor: AppColors.greyDim,
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
                            headerText: AppTexts.eatingHabitTitleText,
                            requestText: controller.getQuestionWithAnswerModel
                                        .value.response ==
                                    null
                                ? "What are your dietary habits? (Select one)"
                                : "${controller.getQuestionWithAnswerModel.value.response!.question!} (Select one)",
                            color: AppColors.dietModuleColor,
                            height: height * 0.27,
                            width: width,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.3,
                      width: width * 0.8,
                      child: controller
                                  .getQuestionWithAnswerModel.value.response ==
                              null
                          ? const SizedBox()
                          : ListView.builder(
                              itemCount: controller.getQuestionWithAnswerModel
                                  .value.response!.option!.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: height * 0.01),
                                child: Obx(
                                  () => InkWell(
                                    onTap: () {
                                      controller.selectedIndex.value = index;
                                    },
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      height: height * .057,
                                      width: width,
                                      decoration: BoxDecoration(
                                        color: controller.selectedIndex.value ==
                                                index
                                            ? AppColors.dietModuleColor
                                            : AppColors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: const Color(0xffC8C5C5),
                                            width: 0.5),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            controller
                                                .getQuestionWithAnswerModel
                                                .value
                                                .response!
                                                .option![index]
                                                .option!,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontFamily:
                                                  AppTextStyles.fontFamily,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          controller.selectedIndex.value ==
                                                  index
                                              ? const Icon(
                                                  Icons.check_circle_rounded)
                                              : const SizedBox(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
                    QusNextButton(
                      height: height * 0.07,
                      width: width * 0.5,
                      callBack: () {
                        controller.eatingHabitsAnswerApi(
                          controller.getQuestionWithAnswerModel.value.response!
                              .order!,
                          controller
                              .getQuestionWithAnswerModel.value.response!.id!,
                          controller.getQuestionWithAnswerModel.value.response!
                              .option![controller.selectedIndex.value].option!,
                        );
                      },
                    ),
                    SizedBox(
                      height: height * 0.1,
                      width: width * 0.85,
                      child: QusLinearProgress(
                        width: width * 0.6,
                        height: height * 0.015,
                        progress: 0 / totalScreens,
                        progressText: "${0 ~/ totalScreens}",
                      ),
                    ),
                  ],
                ),
              ),
              controller.isLoading.value ? const OverlayWidget() : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
