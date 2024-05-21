import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/modules/exercise_intervel_time/workouts/screens/rest/break_page.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../done_page/workout_complete_page.dart';
import '../controller/workout_controller.dart';
import '../screens/interval_counter/interval_counter_page/interval_counter_page.dart';
import '../screens/intervel_timer/interval_timer_page/interval_timer_page.dart';

class WorkoutPage extends GetView<WorkoutController> {
  const WorkoutPage({super.key});

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
          backgroundColor: AppColors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: AppColors.black),
        ),
        body: InternetCheckWidget<ConnectivityService>(
          child: PageView(
            controller: controller.pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              controller.currentPage.value = index;
            },
            children: controller.workoutList
                .map(
                  (e) => e.isDuration
                      ? const IntervalTimerPage()
                      : IntervalCounterPage(),
                )
                .toList(),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: SizedBox(
              height: height * 0.07,
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: GestureDetector(
                      onTap: () {
                        if (controller.currentPage > 0) {
                          controller.pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: Obx(
                        () => Row(
                          children: [
                            Icon(
                              Icons.arrow_back,
                              color: controller.currentPage.value == 0
                                  ? AppColors.stepperColor
                                  : AppColors.black,
                            ),
                            Text(
                              ' Previous',
                              style: AppTextStyles.formalTextStyle(
                                color: controller.currentPage.value == 0
                                    ? AppColors.stepperColor
                                    : AppColors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Container(
                        width: width * 0.005,
                        height: height * 0.04,
                        color: AppColors.stepperColor,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: GestureDetector(
                      onTap: () async {
                        if (controller.currentPage.value + 1 <
                            controller.workoutList.length) {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RestPage(),
                            ),
                          );
                          controller.pageController
                              .jumpToPage(controller.currentPage.value + 1);
                        } else if (controller.currentPage.value ==
                            controller.workoutList.length - 1) {
                          Get.to(const WorkoutCompletePage());
                        }
                      },
                      child: Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              controller.currentPage.value <
                                      controller.workoutList.length - 1
                                  ? 'Skip '
                                  : 'Done',
                              style: AppTextStyles.formalTextStyle(
                                color: AppColors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            controller.currentPage.value <
                                    controller.workoutList.length - 1
                                ? const Icon(Icons.arrow_forward,
                                    color: AppColors.black)
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
              content: Text('Do you want to leave this screen?',
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
