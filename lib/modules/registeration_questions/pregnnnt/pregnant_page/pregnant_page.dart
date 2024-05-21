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
import '../controller/pregnant_controller.dart';

class PregnantPage extends GetView<PregnantController> {
  const PregnantPage({super.key});

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
                              const Expanded(child: QusStepper(question: 1)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.27,
                          child: UnderstandWidget(
                            headerText: AppTexts.qusUnderstandText,
                            requestText: AppTexts.qusUnderstandPregnantText,
                            height: height * 0.27,
                            width: width,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.15,
                      width: width * 0.8,
                      child: ListView.builder(
                        itemCount: controller.isPregnentList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: height * 0.01),
                          child: Obx(
                            () => InkWell(
                              onTap: () {
                                controller.selectedIndex.value = index;
                                if (controller.isPregnentList[
                                        controller.selectedIndex.value] ==
                                    "Yes") {
                                  controller.isYesSelected.value = true;
                                } else {
                                  controller.isYesSelected.value = false;
                                }
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: height * .057,
                                width: width,
                                decoration: BoxDecoration(
                                  color: controller.selectedIndex.value == index
                                      ? AppColors.understandWidgetColor
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
                                      controller.isPregnentList[index],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: AppTextStyles.fontFamily,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    controller.selectedIndex.value == index
                                        ? const Icon(Icons.check_circle_rounded)
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => Visibility(
                        visible: controller.isYesSelected.value,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.07),
                              child: const Text.rich(
                                textAlign: TextAlign.start,
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Regrettably, ",
                                      style: TextStyle(
                                        color: Color(0xFF434343),
                                        fontSize: 14,
                                        fontFamily: AppTextStyles.fontFamily,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          AppTexts.pregnantYesSelectedBoldText,
                                      style: TextStyle(
                                        color: Color(0xFF434343),
                                        fontSize: 14,
                                        fontFamily: AppTextStyles.fontFamily,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextSpan(
                                      text: AppTexts.pregnantYesSelectedText,
                                      style: TextStyle(
                                        color: Color(0xFF434343),
                                        fontSize: 14,
                                        fontFamily: AppTextStyles.fontFamily,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.07),
                              child: const Text(
                                AppTexts.pregnantYesSelectedBottomText,
                                style: TextStyle(
                                  color: Color(0xFF434343),
                                  fontSize: 14,
                                  fontFamily: AppTextStyles.fontFamily,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    QusNextButton(
                      height: height * 0.07,
                      width: width * 0.5,
                      callBack: () {
                        controller.pregnentApi();
                      },
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
