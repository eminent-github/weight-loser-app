import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/modules/registeration_questions/user_relevance/models/user_relevance_model.dart';
import 'package:weight_loss_app/modules/registeration_questions/user_relevance/user_relevance_page/user_relevance_page.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';
import '../../../../widgets/custom_large_button.dart';
import '../../../../widgets/qus_understand_widget.dart';
import '../../widgets/qus_bottom_progress.dart';
import '../../widgets/qus_top_progress_widget.dart';
import '../../widgets/transitions.dart';
import '../controller/religious_controller.dart';

class ReligiousDietPage extends GetView<ReligiousDietController> {
  const ReligiousDietPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                                    progress: 2 / secondModuleTotalScreen,
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
                        height: height * 0.25,
                        child: Center(
                          child: UnderstandWidget(
                            color: AppColors.dietModuleColor,
                            headerText: AppTexts.eatingHabitTitleText,
                            requestText: controller
                                .getQuestionWithAnswerModel.response!.question!,
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
                        child: GridView.builder(
                          itemCount: controller.getQuestionWithAnswerModel
                              .response!.option!.length,
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.02),
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
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () {
                                      controller.toggleSelection(index);
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: width,
                                          decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 3,
                                                offset: const Offset(0, 2),
                                                color: AppColors.greyDim
                                                    .withOpacity(0.5),
                                                spreadRadius: 1,
                                              )
                                            ],
                                          ),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                flex: 4,
                                                child: SizedBox(
                                                  width: width,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10)),
                                                    child: LoadingImage(
                                                      imageUrl: controller
                                                          .getQuestionWithAnswerModel
                                                          .response!
                                                          .option![index]
                                                          .explanationAnswer,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: AppColors.white,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 2,
                                                        offset:
                                                            const Offset(0, -1),
                                                        color: AppColors.greyDim
                                                            .withOpacity(0.5),
                                                        spreadRadius: 1,
                                                      )
                                                    ],
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      controller
                                                          .getQuestionWithAnswerModel
                                                          .response!
                                                          .option![index]
                                                          .option!,
                                                      style: AppTextStyles
                                                          .formalTextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w700,
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
                                                .response!
                                                .option![index]
                                                .isSelected
                                            ? Align(
                                                alignment: Alignment.topRight,
                                                child: Padding(
                                                  padding: EdgeInsets.all(
                                                      width * 0.008),
                                                  child: Icon(
                                                    Icons.check_circle_rounded,
                                                    size: 20,
                                                    color: AppColors.white,
                                                    shadows: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.8),
                                                        spreadRadius: 5,
                                                        blurRadius: 7,
                                                        offset: const Offset(3,
                                                            3), // changes position of shadow
                                                      ),
                                                    ],
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
                        onPressed: () async {
                          var list = controller
                              .getQuestionWithAnswerModel.response!.option!
                              .where((element) => element.isSelected == true)
                              .toList();
                          if (list.isNotEmpty) {
                            bool isOk = await controller
                                .religiousChoicePrefrenceAnswerApi(
                              controller
                                  .getQuestionWithAnswerModel.response!.order!,
                              controller
                                  .getQuestionWithAnswerModel.response!.id!,
                              list.map((e) => e.option).toList().toString(),
                            );
                            if (isOk) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserRelevancePage(
                                    userRelevanceModel: UserRelevanceModel(
                                      title: "We're here for you!",
                                      subtitle:
                                          "Research shows that staying positive significantly influences our goal management.",
                                      imageUrl: AppAssets.cuisineAttractImgUrl,
                                      buttonText: "Let's delve deeper!",
                                      id: "cuisine",
                                      color: AppColors.dietModuleColor,
                                      textColor: AppColors.black,
                                      subTextColor:
                                          AppColors.black.withOpacity(0.7),
                                    ),
                                    buttonTextColor: AppColors.black,
                                  ),
                                ),
                              );
                            }
                          } else {
                            customSnackbar(
                                title: AppTexts.error,
                                message: "Please select any Item");
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
                          progress: 2 / totalScreens,
                          progressText: "${(2 * (100 / totalScreens)).round()}",
                        ),
                      ),
                    ],
                  ),
                ),
                controller.isLoading.value ? OverlayWidget() : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
