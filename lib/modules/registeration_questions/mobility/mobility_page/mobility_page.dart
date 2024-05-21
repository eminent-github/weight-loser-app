import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';
import '../../../../widgets/qus_understand_widget.dart';
import '../../user_relevance/models/user_relevance_model.dart';
import '../../user_relevance/user_relevance_page/user_relevance_page.dart';
import '../../widgets/qus_bottom_progress.dart';
import '../../widgets/qus_next_button.dart';
import '../../widgets/qus_top_progress_widget.dart';
import '../../widgets/transitions.dart';
import '../controller/mobility_controller.dart';

class MobilityPage extends GetView<MobilityController> {
  const MobilityPage({super.key});

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
                SingleChildScrollView(
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
                                        progress: secondModuleTotalScreen /
                                            secondModuleTotalScreen,
                                        title: AppTexts.qusSecondModule,
                                        height: height * 0.008,
                                        width: width * 0.15,
                                        titleTextColor: AppColors.greyDim,
                                        progressColor:
                                            AppColors.dietModuleColor,
                                      ),
                                      QusTopProgressWidget(
                                        progress: 4 / thirdModuleTotalScreen,
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
                            height: height * 0.27,
                            child: UnderstandWidget(
                              headerText:
                                  AppTexts.qusUnderstandExerciseModuleText,
                              requestText: controller.getQuestionWithAnswerModel
                                          .value.response ==
                                      null
                                  ? AppTexts.qusUnderstandMobilityText
                                  : controller.getQuestionWithAnswerModel.value
                                      .response!.question!,
                              color: AppColors.exerciseModuleColor,
                              textColor: AppColors.white,
                              height: height * 0.27,
                              width: width,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.36,
                        width: width * 0.8,
                        child: controller.getQuestionWithAnswerModel.value
                                    .response ==
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
                                        // var selectedOption = controller
                                        //     .genderList[controller.selectedIndex.value];
                                        // log('this is selected option: $selectedOption');
                                      },
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        height: height * .07,
                                        width: width,
                                        decoration: BoxDecoration(
                                          color: controller
                                                      .selectedIndex.value ==
                                                  index
                                              ? AppColors.exerciseModuleColor
                                              : AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: const Color(0xffC8C5C5),
                                              width: 0.5),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.04),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 9,
                                              child: AutoSizeText(
                                                controller
                                                    .getQuestionWithAnswerModel
                                                    .value
                                                    .response!
                                                    .option![index]
                                                    .option!,
                                                maxLines: 2,
                                                minFontSize: 9,
                                                style: AppTextStyles
                                                    .formalTextStyle(
                                                  fontSize: 13,
                                                  color: controller
                                                              .selectedIndex
                                                              .value ==
                                                          index
                                                      ? AppColors.white
                                                      : AppColors.black,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            controller.selectedIndex.value ==
                                                    index
                                                ? const Expanded(
                                                    flex: 1,
                                                    child: Icon(Icons
                                                        .check_circle_rounded))
                                                : const SizedBox.shrink(),
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
                        callBack: () async {
                          bool isOk = await controller.mobilityAnswerApi(
                            controller.getQuestionWithAnswerModel.value
                                .response!.order!,
                            controller
                                .getQuestionWithAnswerModel.value.response!.id!,
                            controller
                                .getQuestionWithAnswerModel
                                .value
                                .response!
                                .option![controller.selectedIndex.value]
                                .option!,
                          );
                          if (isOk) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserRelevancePage(
                                  userRelevanceModel: UserRelevanceModel(
                                    title: "Are we there?\nAlmost",
                                    subtitle:
                                        "Experience the magic of weight loss through mental mastery.",
                                    imageUrl: AppAssets.mobilityAttractImgUrl,
                                    buttonText: "Learn mind mastery",
                                    id: "mobility",
                                    color: AppColors.buttonColor,
                                    textColor: AppColors.white,
                                    subTextColor: AppColors.white,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.1,
                        width: width * 0.85,
                        child: QusLinearProgress(
                          width: width * 0.6,
                          height: height * 0.015,
                          progress: 9 / totalScreens,
                          progressText: "${(9 * (100 / totalScreens)).round()}",
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
      ),
    );
  }
}
