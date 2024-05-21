import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/modules/registeration_questions/widgets/stepper.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';
import '../../../../widgets/qus_understand_widget.dart';
import '../../widgets/qus_next_button.dart';
import '../controller/height_controller.dart';

class HeightPage extends GetView<HeightController> {
  const HeightPage({super.key});

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
                              const Expanded(child: QusStepper(question: 2)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.27,
                          child: UnderstandWidget(
                            headerText: AppTexts.qusUnderstandText,
                            requestText: AppTexts.qusUnderstandHeightText,
                            height: height * 0.27,
                            width: width,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(
                                () => GestureDetector(
                                  onTap: () {
                                    controller.isCm.value =
                                        !controller.isCm.value;
                                    controller.isFt.value =
                                        !controller.isFt.value;
                                  },
                                  child: Container(
                                    width: width * 0.2,
                                    height: height * 0.035,
                                    decoration: BoxDecoration(
                                      color: controller.isFt.value == true
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
                                        "Ft",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: AppTextStyles.fontFamily,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Obx(
                                () => GestureDetector(
                                  onTap: () {
                                    controller.isCm.value =
                                        !controller.isCm.value;
                                    controller.isFt.value =
                                        !controller.isFt.value;
                                  },
                                  child: Container(
                                    width: width * 0.2,
                                    height: height * 0.035,
                                    decoration: BoxDecoration(
                                      color: controller.isCm.value == true
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
                                        "Cm",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: AppTextStyles.fontFamily,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          controller.isCm.value == true
                              ? Container(
                                  height: height * 0.08,
                                  width: width * 0.35,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(8),
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
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: ((controller
                                                        .sliderValue.value) *
                                                    2.54)
                                                .floor()
                                                .toString(),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 30,
                                              fontFamily:
                                                  AppTextStyles.fontFamily,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: 'cm',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.50,
                                              fontFamily:
                                                  AppTextStyles.fontFamily,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: height * 0.08,
                                  width: width * 0.35,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Obx(
                                        () => Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: (controller
                                                            .sliderValue.value /
                                                        12)
                                                    .floor()
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 30,
                                                  fontFamily:
                                                      AppTextStyles.fontFamily,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              const TextSpan(
                                                text: 'ft',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17.50,
                                                  fontFamily:
                                                      AppTextStyles.fontFamily,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: width * 0.001,
                                        height: height * 0.05,
                                        color: AppColors.greyDim,
                                      ),
                                      Obx(
                                        () => Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: (controller
                                                            .sliderValue.value %
                                                        12)
                                                    .floor()
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 30,
                                                  fontFamily:
                                                      AppTextStyles.fontFamily,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              const TextSpan(
                                                text: 'in',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17.50,
                                                  fontFamily:
                                                      AppTextStyles.fontFamily,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                          SizedBox(
                            width: width * 0.75,
                            child: Slider(
                              value: controller.sliderValue.value,
                              min: 54,
                              max: 90,
                              onChanged: (value) {
                                controller.sliderValue.value = value;
                              },
                              inactiveColor: AppColors.greyDim,
                              activeColor: controller.sliderValue.value == 54
                                  ? const Color(0xFF707070)
                                  : AppColors.themeColor,
                            ),
                          ),
                          QusNextButton(
                            height: height * 0.07,
                            width: width * 0.5,
                            callBack: () {
                              controller.heightApi();
                            },
                          ),
                          const SizedBox.shrink()
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
