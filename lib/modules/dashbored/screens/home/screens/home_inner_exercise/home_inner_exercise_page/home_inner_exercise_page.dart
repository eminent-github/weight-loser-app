import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';

import '../../../../../../../common/app_assets.dart';
import '../../../../../../../common/app_colors.dart';
import '../../../../../../../common/app_text_styles.dart';
import '../../../../../../exercise/exercise_my_plans/binding/exercise_my_plans_binding.dart';
import '../../../../../../exercise/exercise_my_plans/exercise_my_plans_page/exercise_my_plans_page.dart';
// import '../../../../../../exercise_intervel_time/interval_time/binding/interval_time_binding.dart';
// import '../../../../../../exercise_intervel_time/interval_time/interval_time_page/interval_time_page.dart';
import '../controller/home_inner_exercise_controller.dart';
import '../widgets/exercise_item.dart';

class HomeInnerExercisePage extends GetView<HomeInnerExerciseController> {
  const HomeInnerExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    var height =
        screenSize.height - kBottomNavigationBarHeight - kToolbarHeight;
    var width = screenSize.width;
    return SafeArea(
      child: InternetCheckWidget<ConnectivityService>(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              width: width * 0.84,
              height: height * 0.22,
              decoration: ShapeDecoration(
                image: const DecorationImage(
                  image: AssetImage(AppAssets.exerciseImgUrl),
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1)),
                shadows: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 1),
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * 0.025,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const ExerciseMyPlansPage(),
                          binding: ExerciseMyPlansBinding());
                    },
                    child: Container(
                      width: width * 0.23,
                      height: height * 0.04,
                      decoration: ShapeDecoration(
                        color: AppColors.buttonColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3)),
                      ),
                      child: Center(
                        child: Text(
                          'My Plans',
                          style: AppTextStyles.formalTextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   width: width * 0.4,
                  //   height: height * 0.04,
                  //   decoration: ShapeDecoration(
                  //     shape: RoundedRectangleBorder(
                  //       side:
                  //           BorderSide(width: 0.50, color: AppColors.buttonColor),
                  //       borderRadius: BorderRadius.circular(3),
                  //     ),
                  //   ),
                  //   child: Center(
                  //     child: Text(
                  //       'Create Custom plans',
                  //       style: AppTextStyles.formalTextStyle(
                  //         color: AppColors.buttonColor,
                  //         fontSize: 12,
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
            SizedBox(
              height: height * 0.015,
            ),
            Container(
              width: width,
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 0.50,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Color(0xFFEAEAEA),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: width * 0.07),
            //   child: InkWell(
            //     onTap: () {
            //       Get.to(() => const IntervalTimePage(),
            //           binding: IntervalTimeBinding());
            //     },
            //     child: Row(
            //       children: [
            //         Text(
            //           'Interval Time ',
            //           style: AppTextStyles.formalTextStyle(
            //             color: AppColors.buttonColor,
            //             fontSize: 18,
            //           ),
            //         ),
            //         Icon(
            //           Icons.arrow_forward,
            //           color: AppColors.buttonColor,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.07),
              child: Row(
                children: [
                  Text(
                    'Popular Exercises',
                    style: AppTextStyles.formalTextStyle(
                      color: AppColors.buttonColor,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: height * 0.005,
            ),
            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(
                        color: AppColors.buttonColor,
                      ))
                    : controller.getExercisePlans.value.favouritePlanList !=
                            null
                        ? ExerciseItems(
                            exercisePlans: controller.getExercisePlans.value,
                          )
                        : Center(
                            child: Text(
                              "No Plan Available",
                              style: AppTextStyles.formalTextStyle(
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .titleMedium!
                                    .color!,
                              ),
                            ),
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
