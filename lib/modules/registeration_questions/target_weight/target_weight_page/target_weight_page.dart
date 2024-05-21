// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/modules/registeration_questions/user_relevance/models/user_relevance_model.dart';
import 'package:weight_loss_app/modules/registeration_questions/widgets/stepper.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';
import '../../../../widgets/qus_understand_widget.dart';
import '../../user_relevance/user_relevance_page/user_relevance_page.dart';
import '../../widgets/qus_next_button.dart';
import '../controller/target_weight_controller.dart';

class TargetWeightPage extends GetView<TargetWeightController> {
  const TargetWeightPage({
    super.key,
    required this.userWeight,
    required this.userHeight,
    required this.isKg,
  });
  final double userHeight;
  final double userWeight;
  final bool isKg;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double height = screenSize.height;
    double width = screenSize.width;
    log("----------$isKg ++++++++$userWeight");
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
                              const Expanded(child: QusStepper(question: 4)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.27,
                          child: UnderstandWidget(
                            headerText: AppTexts.qusGoalWeightText,
                            requestText: AppTexts.qustargetWeightText,
                            isShowDiscription: true,
                            discriptionText:
                                "It helps us create your personalized plan",
                            height: height * 0.27,
                            width: width,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      // height: height * 0.45,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: width * 0.23,
                                height: height * 0.038,
                                decoration: BoxDecoration(
                                  color: isKg == false
                                      ? AppColors.greyDim
                                      : AppColors.white,
                                  border: Border.all(
                                    color: AppColors.greyDim,
                                    width: 0.5,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    bottomLeft: Radius.circular(25),
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Pound",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: AppTextStyles.fontFamily,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: width * 0.23,
                                height: height * 0.038,
                                decoration: BoxDecoration(
                                  color: isKg == true
                                      ? AppColors.greyDim
                                      : AppColors.white,
                                  border: Border.all(
                                    color: AppColors.greyDim,
                                    width: 0.5,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(25),
                                    bottomRight: Radius.circular(25),
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Kilogram",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: AppTextStyles.fontFamily,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: height * 0.2,
                            width: width * 0.5,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: isKg
                                  ? Text(
                                      "${((controller.sliderValue.value) * 0.453592).round()} kg",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontFamily: AppTextStyles.fontFamily,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  : Text(
                                      "${((controller.sliderValue.value)).round()} lb",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontFamily: AppTextStyles.fontFamily,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.75,
                            child: Obx(
                              () => Slider(
                                value: controller.sliderValue.value,
                                min: 90,
                                max: userWeight - (isKg ? 2.205 : 1),
                                onChanged: (value) {
                                  controller.sliderValue.value = value;
                                },
                                inactiveColor: AppColors.greyDim,
                                activeColor: controller.sliderValue.value == 90
                                    ? const Color(0xFF707070)
                                    : AppColors.themeColor,
                              ),
                            ),
                          ),
                          QusNextButton(
                            height: height * 0.07,
                            width: width * 0.5,
                            callBack: () async {
                              if (controller
                                      .bmi(userHeight, isKg)
                                      .toPrecision(1) >
                                  18.5) {
                                bool isOk =
                                    await controller.targetWeightApi(isKg);
                                if (isOk) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserRelevancePage(
                                        userRelevanceModel: UserRelevanceModel(
                                          title: "You got it",
                                          subtitle:
                                              "Setting clear goals increases the likelihood of success.",
                                          imageUrl:
                                              AppAssets.targetAttractImgUrl,
                                          buttonText: "Next",
                                          id: "targetWeight",
                                          color:
                                              AppColors.understandWidgetColor,
                                          textColor: AppColors.black,
                                          subTextColor:
                                              AppColors.black.withOpacity(0.7),
                                        ),
                                        fazoolText: "",
                                        buttonTextColor: AppColors.black,
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                customSnackbar(
                                  title: "Alert",
                                  message:
                                      "You cannot select the weight lower than 18.5 BMI",
                                  duration: 3000,
                                );
                              }
                            },
                          ),
                        ],
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
    );
  }
}
