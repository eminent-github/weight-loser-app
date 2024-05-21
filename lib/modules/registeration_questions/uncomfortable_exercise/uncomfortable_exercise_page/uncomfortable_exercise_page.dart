import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/registeration_questions/uncomfortable_exercise/controller/uncomfortable_exercise_controller.dart';
import 'package:weight_loss_app/modules/registeration_questions/widgets/qus_bottom_progress.dart';
import 'package:weight_loss_app/modules/registeration_questions/widgets/qus_top_progress_widget.dart';
import 'package:weight_loss_app/modules/registeration_questions/widgets/transitions.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_large_button.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';
import 'package:weight_loss_app/widgets/qus_understand_widget.dart';

class UnComfortableExercisePage
    extends GetView<UnComfortableExerciseController> {
  const UnComfortableExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: InternetCheckWidget<ConnectivityService>(
        child: SafeArea(
          child: Obx(
            () => Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    progress: 2 / thirdModuleTotalScreen,
                                    title: AppTexts.qusThirdModule,
                                    height: height * 0.008,
                                    width: width * 0.15,
                                    titleTextColor: AppColors.black,
                                    progressColor:
                                        AppColors.exerciseModuleColor,
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
                        height: height * 0.25,
                        child: Center(
                          child: UnderstandWidget(
                            color: AppColors.exerciseModuleColor,
                            headerText: "Let us understand your active routine",
                            requestText: controller.getQuestionWithAnswerModel
                                        .value.response ==
                                    null
                                ? AppTexts.questionUnComfortableExerciseTitle
                                : controller.getQuestionWithAnswerModel.value
                                    .response!.question!,
                            textColor: AppColors.white,
                            height: height * 0.25,
                            width: width,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      SizedBox(
                        height: height * 0.4,
                        width: width * 0.8,
                        child: controller.getQuestionWithAnswerModel.value
                                    .response ==
                                null
                            ? const SizedBox()
                            : GridView.builder(
                                itemCount: controller.getQuestionWithAnswerModel
                                    .value.response!.option!.length,
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.02),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 20,
                                        crossAxisSpacing: width * 0.1,
                                        crossAxisCount: 2,
                                        childAspectRatio: 1.25),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: height * 0.004),
                                    child: GetBuilder(
                                      init: controller,
                                      builder: (context) {
                                        return InkWell(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          onTap: () {
                                            controller.toggleSelection(index);
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: AppColors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 3,
                                                      offset:
                                                          const Offset(0, 2),
                                                      color: AppColors.greyDim
                                                          .withOpacity(0.5),
                                                      spreadRadius: 1,
                                                    )
                                                  ],
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Expanded(
                                                      flex: 4,
                                                      child: SvgPicture.network(
                                                        ApiUrls.imageBaseUrl +
                                                            controller
                                                                .getQuestionWithAnswerModel
                                                                .value
                                                                .response!
                                                                .option![index]
                                                                .explanationAnswer,
                                                        fit: BoxFit.contain,
                                                        placeholderBuilder:
                                                            (context) {
                                                          return const Center(
                                                              child:
                                                                  CircularProgressIndicator());
                                                        },
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              AppColors.white,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10)),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 2,
                                                              offset:
                                                                  const Offset(
                                                                      0, -1),
                                                              color: AppColors
                                                                  .greyDim
                                                                  .withOpacity(
                                                                      0.5),
                                                              spreadRadius: 1,
                                                            )
                                                          ],
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            controller
                                                                .getQuestionWithAnswerModel
                                                                .value
                                                                .response!
                                                                .option![index]
                                                                .option!,
                                                            style: AppTextStyles
                                                                .formalTextStyle(
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: const Color(
                                                                  0xff565656),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              controller
                                                      .getQuestionWithAnswerModel
                                                      .value
                                                      .response!
                                                      .option![index]
                                                      .isSelected
                                                  ? Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            width * 0.008),
                                                        child: const Icon(
                                                          Icons
                                                              .check_circle_rounded,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      CustomLargeButton(
                        text: AppTexts.questionCuisineButton,
                        height: height,
                        width: width * 0.55,
                        onPressed: () {
                          var list = controller.getQuestionWithAnswerModel.value
                              .response!.option!
                              .where((element) => element.isSelected == true)
                              .toList();
                          if (list.isNotEmpty) {
                            controller.unComfortableExerciseAnswerApi(
                              controller.getQuestionWithAnswerModel.value
                                  .response!.order!,
                              controller.getQuestionWithAnswerModel.value
                                  .response!.id!,
                              list.map((e) => e.option).toList().toString(),
                            );
                          } else {
                            customSnackbar(
                                title: AppTexts.error,
                                message: "Please select atleast one item");
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      SizedBox(
                        height: height * 0.05,
                        width: width * 0.85,
                        child: QusLinearProgress(
                          width: width * 0.6,
                          height: height * 0.015,
                          progress: 7 / totalScreens,
                          progressText: "${(7 * (100 / totalScreens)).round()}",
                        ),
                      ),
                    ],
                  ),
                ),
                controller.isLoading.value
                    ? const OverlayWidget()
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
