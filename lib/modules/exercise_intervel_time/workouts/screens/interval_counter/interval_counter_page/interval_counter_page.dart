import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/widgets/custom_large_button.dart';

import '../../../../../../common/app_assets.dart';
import '../../../../../../common/app_colors.dart';
import '../../../../../../common/app_text_styles.dart';
import '../../../../done_page/workout_complete_page.dart';
import '../../../controller/workout_controller.dart';
import '../../rest/break_page.dart';
import '../controller/interval_counter_controller.dart';

class IntervalCounterPage extends GetView<IntervalCounterController> {
  IntervalCounterPage({super.key});
  final WorkoutController workoutController = Get.find<WorkoutController>();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppAssets.pushupImgUrl,
            width: width * 0.9,
            height: height * 0.25,
          ),
          SizedBox(
            height: height * 0.07,
          ),
          Text(
            'Push Ups',
            style: AppTextStyles.formalTextStyle(
              color: AppColors.buttonColor,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Text(
            'X16',
            style: AppTextStyles.formalTextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: height * 0.07,
          ),
          CustomLargeButton(
            height: height,
            width: width * 0.65,
            text: "Done",
            borderRadius: BorderRadius.circular(15),
            onPressed: () async {
              if (workoutController.currentPage.value + 1 <
                  workoutController.workoutList.length) {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RestPage(),
                  ),
                );
                workoutController.pageController
                    .jumpToPage(workoutController.currentPage.value + 1);
              } else if (workoutController.currentPage.value + 1 ==
                  workoutController.workoutList.length) {
                Get.to(const WorkoutCompletePage());
              }
            },
          ),
        ],
      ),
    );
  }
}
