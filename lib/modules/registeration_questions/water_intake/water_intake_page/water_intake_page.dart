import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';
import '../../../../widgets/qus_understand_widget.dart';
import '../../widgets/qus_bottom_progress.dart';
import '../../widgets/qus_next_button.dart';
import '../../widgets/qus_top_progress_widget.dart';
import '../../widgets/transitions.dart';
import '../controller/water_intake_controller.dart';

class WaterIntakePage extends GetView<WaterIntakeController> {
  const WaterIntakePage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
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
                                      progress: 4 / secondModuleTotalScreen,
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
                            headerText: "Tell us your dietary habits",
                            requestText: controller.getQuestionWithAnswerModel
                                        .value.response ==
                                    null
                                ? AppTexts.qusUnderstandWaterIntakeText
                                : controller.getQuestionWithAnswerModel.value
                                    .response!.question!,
                            color: AppColors.dietModuleColor,
                            height: height * 0.27,
                            width: width,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.25,
                      width: width * 0.8,
                      child: controller
                                  .getQuestionWithAnswerModel.value.response ==
                              null
                          ? const SizedBox()
                          : ListView.builder(
                              itemCount: controller.waterIntakeList.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: height * 0.01),
                                child: Obx(
                                  () => InkWell(
                                    onTap: () {
                                      controller.selectedIndex.value = index;
                                      // var selectedOption = controller
                                      //     .genderList[controller.selectedIndex.value];
                                      // log('this is selected option: $selectedOption');
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
                                          Expanded(
                                            flex: 4,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: SvgPicture.network(
                                                ApiUrls.imageBaseUrl +
                                                    controller
                                                        .getQuestionWithAnswerModel
                                                        .value
                                                        .response!
                                                        .option![index]
                                                        .explanationAnswer,
                                                fit: BoxFit.contain,
                                                placeholderBuilder: (context) {
                                                  return const Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                },
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 7,
                                            child: Text(
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
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: controller
                                                        .selectedIndex.value ==
                                                    index
                                                ? const Center(
                                                    child: Icon(Icons
                                                        .check_circle_rounded))
                                                : const SizedBox(),
                                          ),
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
                        controller.waterIntakeAnswerApi(
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
                        progress: 4 / totalScreens,
                        progressText: "${(4 * (100 / totalScreens)).round()}",
                      ),
                    ),
                  ],
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
