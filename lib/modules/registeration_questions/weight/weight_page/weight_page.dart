import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/modules/registeration_questions/widgets/stepper.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';
import '../../../../widgets/qus_understand_widget.dart';
import '../../widgets/qus_next_button.dart';
import '../controller/weight_controller.dart';

class WeightPage extends GetView<WeightController> {
  const WeightPage({
    super.key,
    this.userHeight,
  });
  final double? userHeight;
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
                              const Expanded(child: QusStepper(question: 3)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.27,
                          child: UnderstandWidget(
                            headerText: AppTexts.qusUnderstandText,
                            requestText: AppTexts.qusUnderstandWeightText,
                            discriptionText:
                                "It helps us create your personalized plan",
                            isShowDiscription: true,
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
                              GestureDetector(
                                onTap: () {
                                  controller.isKg.value =
                                      !controller.isKg.value;
                                  controller.isLbs.value =
                                      !controller.isLbs.value;
                                },
                                child: Container(
                                  width: width * 0.23,
                                  height: height * 0.038,
                                  decoration: BoxDecoration(
                                    color: controller.isLbs.value == true
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
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.isKg.value =
                                      !controller.isKg.value;
                                  controller.isLbs.value =
                                      !controller.isLbs.value;
                                },
                                child: Container(
                                  width: width * 0.23,
                                  height: height * 0.038,
                                  decoration: BoxDecoration(
                                    color: controller.isKg.value == true
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
                              child: controller.isKg.value == true
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
                            child: Slider(
                              value: controller.sliderValue.value,
                              min: 120,
                              max: 500,
                              onChanged: (value) {
                                controller.sliderValue.value = value;
                              },
                              inactiveColor: AppColors.greyDim,
                              activeColor: controller.sliderValue.value == 120
                                  ? const Color(0xFF707070)
                                  : AppColors.themeColor,
                            ),
                          ),
                          controller.isShowResriction.value
                              ? SizedBox(
                                  width: width * 0.85,
                                  child: const AutoSizeText(
                                    "*We're sorry, WeightLoser is not currently designed for BMI below 18.5 since WHO guidelines classifies BMI below 18.5 as underweight.",
                                    textAlign: TextAlign.center,
                                    minFontSize: 7,
                                    maxLines: 3,
                                    style: TextStyle(
                                      color: AppColors.abstractionTextColor,
                                      fontSize: 12,
                                      fontFamily: AppTextStyles.fontFamily,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          QusNextButton(
                            height: height * 0.07,
                            width: width * 0.5,
                            callBack: () {
                              log("bmi ${controller.bmi(userHeight!)}:height: $userHeight ");
                              if (controller.bmi(userHeight!).toPrecision(1) >
                                  18.5) {
                                controller.isShowResriction.value = false;
                                controller.weightApi(userHeight!);
                              } else {
                                controller.isShowResriction.value = true;
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
