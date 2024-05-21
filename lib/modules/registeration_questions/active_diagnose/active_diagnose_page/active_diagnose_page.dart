import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/modules/registeration_questions/models/get_question_with_answer_model.dart';
import 'package:weight_loss_app/modules/registeration_questions/widgets/stepper.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';
import '../../../../widgets/qus_understand_widget.dart';
import '../../widgets/qus_next_button.dart';
import '../controller/active_diagnose_controller.dart';

class ActiveDiagnosePage extends GetView<ActiveDiagnoseController> {
  const ActiveDiagnosePage({
    super.key,
    required this.getQuestionWithAnswerModel,
  });
  final GetQuestionWithAnswerModel getQuestionWithAnswerModel;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double height = screenSize.height;
    double width = screenSize.width;
    return Scaffold(
      body: InternetCheckWidget<ConnectivityService>(
        child: Obx(() {
          return Stack(
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
                              const Expanded(child: QusStepper(question: 5)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.25,
                          child: UnderstandWidget(
                            headerText: AppTexts.qusUnderstandText,
                            requestText:
                                getQuestionWithAnswerModel.response!.question!,
                            height: height * 0.25,
                            width: width,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: width * 0.8,
                      child: ListView.builder(
                        itemCount:
                            getQuestionWithAnswerModel.response!.option!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: height * 0.01),
                          child: Obx(
                            () => InkWell(
                              onTap: () {
                                controller.selectedIndex.value = index;
                                if (getQuestionWithAnswerModel
                                        .response!
                                        .option![controller.selectedIndex.value]
                                        .option ==
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
                                      getQuestionWithAnswerModel
                                          .response!.option![index].option!,
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
                    Visibility(
                      visible: controller.isYesSelected.value,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.1),
                            child: const AutoSizeText(
                              "Unfortunately, the current program of WeightLoser does not cater to individuals diagnosed with eating disorders.",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Color(0xFF434343),
                                fontSize: 14,
                                fontFamily: AppTextStyles.fontFamily,
                              ),
                              softWrap: true,
                              maxLines: 3,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                        ],
                      ),
                    ),
                    QusNextButton(
                      height: height * 0.07,
                      width: width * 0.5,
                      callBack: () {
                        controller.activeDiagnoseAnswerApi(
                            context,
                            getQuestionWithAnswerModel.response!.order!,
                            getQuestionWithAnswerModel.response!.id!,
                            getQuestionWithAnswerModel
                                .response!
                                .option![controller.selectedIndex.value]
                                .option!);
                      },
                    ),
                    const SizedBox.shrink()
                  ],
                ),
              ),
              controller.isLoading.value
                  ? const OverlayWidget()
                  : const SizedBox(),
            ],
          );
        }),
      ),
    );
  }
}
