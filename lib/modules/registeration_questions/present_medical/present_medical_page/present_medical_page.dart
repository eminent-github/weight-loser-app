import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/modules/registeration_questions/widgets/stepper.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';
import '../../../../widgets/qus_understand_widget.dart';
import '../../stopping_point/binding/stopping_point_binding.dart';
import '../../stopping_point/stopping_point_page/stopping_point_page.dart';
import '../../widgets/qus_next_button.dart';
import '../controller/present_medical_controller.dart';

class PresentMedicalPage extends GetView<PresentMedicalController> {
  const PresentMedicalPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Scaffold(
      body: InternetCheckWidget<ConnectivityService>(
        child: Obx(
          () => Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: height * 0.08,
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
                                const Expanded(child: QusStepper(question: 6)),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.27,
                            child: UnderstandWidget(
                              headerText: AppTexts.qusUnderstandText,
                              requestText: controller.getQuestionWithAnswerModel
                                  .response!.question!,
                              height: height * 0.27,
                              width: width,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        // height: height * 0.4,
                        width: width * 0.8,
                        child: ListView.builder(
                          itemCount: controller.getQuestionWithAnswerModel
                              .response!.option!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              GetBuilder<PresentMedicalController>(
                            init: controller,
                            builder: (context) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: height * 0.01),
                                child: InkWell(
                                  onTap: () {
                                    // controller.selectedIndex.value = index;
                                    controller.toggleSelection(index);
                                  },
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: height * .057,
                                    width: width,
                                    decoration: BoxDecoration(
                                      color: controller
                                              .getQuestionWithAnswerModel
                                              .response!
                                              .option![index]
                                              .isSelected
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
                                          controller.getQuestionWithAnswerModel
                                              .response!.option![index].option!,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily:
                                                AppTextStyles.fontFamily,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        controller
                                                .getQuestionWithAnswerModel
                                                .response!
                                                .option![index]
                                                .isSelected
                                            ? const Icon(
                                                Icons.check_circle_rounded)
                                            : const SizedBox(),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      QusNextButton(
                        height: height * 0.07,
                        width: width * 0.5,
                        callBack: () {
                          var list = controller
                              .getQuestionWithAnswerModel.response!.option!
                              .where((element) => element.isSelected == true)
                              .toList();

                          if (list.length >= 3) {
                            Get.to(const StoppingPointPage(),
                                binding: StoppingPointBinding());
                          } else {
                            if (list.isEmpty) {
                              customSnackbar(
                                  title: AppTexts.alert,
                                  message: "Please select one");
                            } else {
                              controller.presentMedicalAnswerApi(
                                context,
                                controller.getQuestionWithAnswerModel.response!
                                    .order!,
                                controller
                                    .getQuestionWithAnswerModel.response!.id!,
                                list.map((e) => e.option).toList().toString(),
                                list.any((element) =>
                                    element.option == "Celiac disease"),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
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
