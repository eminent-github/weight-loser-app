import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/modules/registeration_questions/deit_goal/binding/goal_diet_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/deit_goal/goal_diet_page/goal_diet_page.dart';
import 'package:weight_loss_app/widgets/custom_graph/custom_graph_painter.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../widgets/qus_next_button.dart';
import '../controller/user_goal_category_controller.dart';

class UserGoalCategoryPage extends GetView<UserGoalCategoryController> {
  const UserGoalCategoryPage({
    super.key,
    required this.imgUrl,
    required this.subTitle,
    required this.title,
    required this.currentWeight,
    required this.targetWeight,
    required this.weightUnit,
  });
  final String title;
  final String subTitle;
  final String imgUrl;
  final int currentWeight;
  final int targetWeight;
  final String weightUnit;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imgUrl,
                  height: height * 0.34,
                  width: width,
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: width * 0.1),
                    child: Text(
                      title,
                      style: AppTextStyles.formalTextStyle(
                        color: AppColors.buttonColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                SizedBox(
                  width: width * 0.8,
                  height: height * 0.12,
                  child: AutoSizeText(
                    subTitle,
                    textAlign: TextAlign.justify,
                    minFontSize: 5,
                    style: AppTextStyles.formalTextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                SizedBox(
                  height: height * 0.26,
                  width: width,
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: width * 0.07, right: width * 0.1),
                    child: CustomPaint(
                      painter: GraphLinePainter(
                        // hint:  0 month == Junuary
                        month: DateTime.now().month - 1,
                        curentWeight: currentWeight,
                        estimatedWeight: targetWeight,
                        weightUnit: weightUnit,
                        totalMonths: controller.monthsToLoseWeight(
                          currentWeight: weightUnit == "kg"
                              ? currentWeight * 2.2
                              : currentWeight,
                          goalWeight: weightUnit == "kg"
                              ? targetWeight * 2.2
                              : targetWeight,
                          weightPerWeek: 1,
                        ),
                      ),
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
                    Get.to(
                      const GoalDietPage(),
                      binding: GoalDietBinding(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
