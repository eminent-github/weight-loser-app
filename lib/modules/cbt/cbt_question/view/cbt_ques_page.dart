import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/modules/cbt/cbt_question/model.dart/cbt_applause_widget.dart';
import 'package:weight_loss_app/modules/cbt/cbt_question/controller/cbt_ques_controller.dart';
import 'package:weight_loss_app/modules/cbt/model/cbt_questions_model.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_button_widget.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';

class CbtQuestionPage extends GetView<CbtQuestionController> {
  const CbtQuestionPage({
    super.key,
    required this.cbtQuestionsList,
  });
  final List<CBTQuestionsModel> cbtQuestionsList;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;

    return WillPopScope(
      onWillPop: () async {
        return await _showExitWarningDialog(context);
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          iconTheme: Theme.of(context).iconTheme,
          title: Text(
            "Cognitive behavioral technique",
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          centerTitle: true,
          // actions: [
          //   GestureDetector(
          //     onTap: () {},
          //     child: const Icon(Icons.bookmark_border),
          //   ),
          //   IconButton(
          //     icon: const Icon(Icons.ios_share),
          //     onPressed: () {},
          //   ),
          //   SizedBox(
          //     width: width * 0.03,
          //   ),
          // ],
        ),
        body: InternetCheckWidget<ConnectivityService>(
          child: cbtQuestionsList.isEmpty
              ? Center(
                  child: Text(
                    "No Question Found",
                    style: AppTextStyles.formalTextStyle(),
                  ),
                )
              : Obx(
                  () => Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 0.01,
                            ),
                            SizedBox(
                              height: height * 0.015,
                              width: width,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.05),
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: cbtQuestionsList.length,
                                    childAspectRatio: 6,
                                    crossAxisSpacing: width * 0.02,
                                  ),
                                  itemCount: cbtQuestionsList.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color:
                                            index < controller.currentStep.value
                                                ? AppColors.buttonColor
                                                : AppColors.stepperColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Container(
                              height: height * 0.001,
                              width: width * 0.9,
                              color: AppColors.borderColor,
                            ),
                            SizedBox(height: height * 0.02),
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.04),
                                  width: width * 0.9,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(
                                      color: AppColors.borderColor,
                                      width: width * 0.003,
                                    ),
                                  ),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: height * 0.04,
                                        ),
                                        Html(
                                          data: cbtQuestionsList[
                                                  controller.currentStep.value]
                                              .question!,
                                          style: {
                                            'body': Style(
                                                textAlign: TextAlign.justify,
                                                fontFamily:
                                                    AppTextStyles.fontFamily,
                                                fontSize: FontSize(15),
                                                fontWeight: FontWeight.bold),
                                          },
                                        ),
                                        // Text(
                                        //   cbtQuestionsList[
                                        //           controller.currentStep.value]
                                        //       .question!,
                                        //   style: AppTextStyles.formalTextStyle(
                                        //       fontSize: 15,
                                        //       fontWeight: FontWeight.bold),
                                        //   textAlign: TextAlign.justify,
                                        // ),
                                        SizedBox(
                                          height: height * 0.02,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: height * 0.027,
                                  width: width * 0.114,
                                  decoration: BoxDecoration(
                                    color: AppColors.buttonColor,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      AppTexts.quizCbtText,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: AppTextStyles.fontFamily,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            SizedBox(
                              // height: height * 0.4,
                              width: width * 0.8,
                              child: ListView.builder(
                                itemCount: cbtQuestionsList[
                                        controller.currentStep.value]
                                    .option!
                                    .length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  Option option = cbtQuestionsList[
                                          controller.currentStep.value]
                                      .option![index];
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: height * 0.01),
                                    child: Obx(
                                      () => RadioListTile(
                                        value: index,
                                        groupValue:
                                            controller.selectedIndex.value,
                                        onChanged: (value) {
                                          controller.selectedIndex.value =
                                              value!;
                                        },
                                        title: Text(
                                          option.options == null
                                              ? "option"
                                              : option.options!.endsWith("\n")
                                                  ? option.options!
                                                      .replaceAll("\n", "")
                                                  : option.options!,
                                          style: AppTextStyles.formalTextStyle(
                                              color: Theme.of(context)
                                                  .primaryTextTheme
                                                  .titleMedium!
                                                  .color!,
                                              fontSize: 15),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          side: BorderSide(
                                            color: AppColors.buttonColor,
                                            width: 0.7,
                                          ),
                                        ),
                                        fillColor: MaterialStatePropertyAll(
                                            AppColors.buttonColor),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            CustomButtonWidget(
                              height: height * 0.06,
                              width: width * 0.45,
                              borderRadius: BorderRadius.circular(8),
                              text: AppTexts.next,
                              onPressed: () {
                                if (controller.selectedIndex.value > -1) {
                                  controller.nextStep(
                                    context,
                                    cbtQuestionsList.length,
                                    id: cbtQuestionsList[
                                            controller.currentStep.value]
                                        .id!,
                                    order: cbtQuestionsList[
                                            controller.currentStep.value]
                                        .order!,
                                    answer: cbtQuestionsList[
                                            controller.currentStep.value]
                                        .option![controller.selectedIndex.value]
                                        .options!,
                                    type: cbtQuestionsList[
                                            controller.currentStep.value]
                                        .type!,
                                    cbtQuestionsModel: cbtQuestionsList[
                                        controller.currentStep.value],
                                  );
                                }
                              },
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                          ],
                        ),
                      ),
                      controller.isLoading.value
                          ? const OverlayWidget()
                          : const SizedBox(),
                      controller.isAnswerSelected.value
                          ? CbtApplauseWidget(
                              isTrue: cbtQuestionsList[
                                      controller.currentStep.value]
                                  .option![0]
                                  .cbtAnswer!
                                  .trim()
                                  .contains(cbtQuestionsList[
                                          controller.currentStep.value]
                                      .option![controller.selectedIndex.value]
                                      .options!
                                      .trim()),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Future<bool> _showExitWarningDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Warning', style: AppTextStyles.formalTextStyle()),
              content: Text(
                  'You will lose your progress. Do you want to leave this screen?',
                  style: AppTextStyles.formalTextStyle()),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Cancel', style: AppTextStyles.formalTextStyle()),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Exit', style: AppTextStyles.formalTextStyle()),
                ),
              ],
            );
          },
        ) ??
        false;
  }
}
