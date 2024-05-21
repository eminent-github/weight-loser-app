import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/modules/cbt/model/cbt_questions_model.dart';
import 'package:weight_loss_app/modules/cbt/randon_question/randon_question_page.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';
import '../../../../widgets/custom_button_widget.dart';

class CbtExplainPage extends StatelessWidget {
  const CbtExplainPage({
    super.key,
    required this.cbtQuestionsModel,
    required this.answer,
  });
  final CBTQuestionsModel cbtQuestionsModel;
  final String answer;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "Explanation",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: InternetCheckWidget<ConnectivityService>(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.08),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.02),
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
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
                            // Text(
                            //   cbtQuestionsModel.question!,
                            //   style: AppTextStyles.formalTextStyle(
                            //       fontSize: 15, fontWeight: FontWeight.bold),
                            //   textAlign: TextAlign.justify,
                            // ),
                            Html(
                              data: cbtQuestionsModel.question!,
                              style: {
                                'body': Style(
                                    textAlign: TextAlign.justify,
                                    fontFamily: AppTextStyles.fontFamily,
                                    fontSize: FontSize(15),
                                    fontWeight: FontWeight.bold),
                              },
                            ),
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
                              bottomRight: Radius.circular(8))),
                      child: const Center(
                        child: Text(
                          AppTexts.quizCbtText,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 15,
                            fontFamily: AppTextStyles.fontFamily,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: height * 0.02),
                const Center(
                  child: AutoSizeText(
                    "${AppTexts.correctAnswerCbtText} ",
                    style: TextStyle(
                      color: AppColors.textCbtColor,
                      fontSize: 15,
                      fontFamily: AppTextStyles.fontFamily,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01),
                Center(
                  // padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  child: AutoSizeText(
                    cbtQuestionsModel.option![0].cbtAnswer ??
                        "No Answer Available",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context)
                          .primaryTextTheme
                          .titleMedium!
                          .color!,
                      fontSize: 15,
                      fontFamily: AppTextStyles.fontFamily,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.07),
                  child: const Divider(
                    color: Color(0xFFC4C4C4),
                    thickness: 1,
                  ),
                ),
                SizedBox(height: height * 0.02),
                // Text(
                //   cbtQuestionsModel.option![0].explanation!,
                //   textAlign: TextAlign.justify,
                //   style: const TextStyle(
                //     color: AppColors.black,
                //     fontSize: 14,
                //     fontFamily: AppTextStyles.fontFamily,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
                Html(
                  data: cbtQuestionsModel.option![0].explanation != null
                      ? cbtQuestionsModel.option![0].explanation!
                          .replaceAll("\\", "")
                      : "No explanation available",
                  style: {
                    'body': Style(
                      textAlign: TextAlign.justify,
                      fontFamily: AppTextStyles.fontFamily,
                      fontSize: FontSize(15),
                    ),
                  },
                ),
                SizedBox(height: height * 0.03),
                Text(
                  "Your selected option is:",
                  style: TextStyle(
                    color:
                        Theme.of(context).primaryTextTheme.titleMedium!.color!,
                    fontSize: 16,
                    fontFamily: AppTextStyles.fontFamily,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: height * 0.02),
                ListView.builder(
                  itemCount: cbtQuestionsModel.option!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    Option option = cbtQuestionsModel.option![index];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: height * 0.005, horizontal: width * 0.05),
                      child: Container(
                        width: width,
                        decoration: BoxDecoration(
                          color: answer == option.options
                              ? const Color(0xFFC2C0C0)
                              : AppColors.white,
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                              color: const Color(0xffC8C5C5), width: 0.5),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.04,
                          vertical: height * 0.02,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Text(
                                option.options!.endsWith("\n")
                                    ? option.options!.replaceAll("\n", "")
                                    : option.options!,
                                style: TextStyle(
                                  color: answer == option.options
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 15,
                                  fontFamily: AppTextStyles.fontFamily,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: answer == option.options
                                    ? const Icon(
                                        Icons.check_circle_rounded,
                                        color: Colors.white,
                                      )
                                    : const SizedBox(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Center(
                  child: CustomButtonWidget(
                    height: height * 0.06,
                    width: width * 0.45,
                    text: AppTexts.next,
                    borderRadius: BorderRadius.circular(3),
                    onPressed: () async {
                      print("object    ${cbtQuestionsModel.isRandom!}");
                      if (cbtQuestionsModel.isRandom ?? false) {
                        await Get.to(() => RandomQuestionPage(
                              randomOption: cbtQuestionsModel.randomOption!,
                            ));
                        Get.back();
                      } else {
                        Get.back();
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
