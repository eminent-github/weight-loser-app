import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sp_showcaseview/showcaseview.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/cbt/cbt_first/binding/cbt_binding.dart';
import 'package:weight_loss_app/modules/cbt/cbt_first/view/cbt_page.dart';
import 'package:weight_loss_app/modules/cheat_food/binding/cheat_food_binding.dart';
import 'package:weight_loss_app/modules/cheat_food/view/cheat_food_page.dart';
import 'package:weight_loss_app/modules/dashbored/controller/dashboared_controller.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/controller/home_controller.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/home_page/home_page.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_today/models/today_diet_model.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_today/screens/dinner_screen.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_today/screens/lunch_screen.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_today/screens/snack_screen.dart';
import 'package:weight_loss_app/modules/deep_sleep/binding/deep_sleep_binding.dart';
import 'package:weight_loss_app/modules/deep_sleep/deep_sleep_page/deep_sleep_page.dart';
import 'package:weight_loss_app/modules/diet/diet_plan_detail/controller/diet_plan_detail_controller.dart';
import 'package:weight_loss_app/modules/exercise/exercise_plan_detail/binding/exercise_plan_detial_binding.dart';
import 'package:weight_loss_app/modules/exercise/exercise_plan_detail/exercise_plan_detial_page/exercise_plan_detial_page.dart';
import 'package:weight_loss_app/modules/exercise/exercise_plan_detail/models/exercise_item_detial_model.dart';
import 'package:weight_loss_app/modules/exercise/exercise_reps/exercise_reps_page.dart';
import 'package:weight_loss_app/modules/exercise/exercise_timer/binding/exercise_timer_binding.dart';
import 'package:weight_loss_app/modules/exercise/exercise_timer/exercise_timer_page/exercise_timer_page.dart';
import 'package:weight_loss_app/modules/mind/mind_plan_detail/binding/mind_paln_detial_binding.dart';
import 'package:weight_loss_app/modules/mind/mind_plan_detail/mind_paln_detail_page/mind_paln_detail_page.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

import '../../../../../../../common/app_colors.dart';
import '../../../../../../../common/app_text_styles.dart';
import '../../../../../../../widgets/progress_bar.dart';
import '../controller/home_inner_today_controller.dart';
import '../screens/breakfast_screen.dart';
import '../widgets/excercise_performance_widget.dart';
import '../widgets/home_component_count.dart';
import '../widgets/post_item_widget.dart';
import '../widgets/stress_buster.dart';
import '../widgets/widget_todo_item.dart';

final GlobalKey inSightKey = GlobalKey();
final GlobalKey breakFastKey = GlobalKey();
final GlobalKey cheatFoodKey = GlobalKey();
final GlobalKey workOutKey = GlobalKey();
final GlobalKey todosKey = GlobalKey();

class HomeInnerTodayPage extends GetView<HomeInnerTodayController> {
  const HomeInnerTodayPage({
    super.key,
    required this.tabController,
  });
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    var height = screenSize.height;
    var width = screenSize.width;
    if (!controller.storage.hasData('isShowCase')) {
      controller.storage.write('isShowCase', true);
      Future.delayed(
        const Duration(seconds: 2),
        () {
          ShowCaseWidget.of(context).startShowCase(
            [
              menueGlobalKey,
              favoritGlobalKey,
              todayKey,
              dietkey,
              exerciseksy,
              mindksy,
              inSightKey,
              breakFastKey,
              cheatFoodKey,
              workOutKey,
              todosKey,
              bottomKey,
              progressKey,
              diaryKey
            ],
          );
        },
      );
    }
    return Obx(
      () => Stack(
        children: [
          Column(
            children: [
              // SizedBox(
              //   height: height * 0.03,
              // ),
              // Container(
              //   width: width * 0.8,
              //   height: height * 0.08,
              //   decoration: ShapeDecoration(
              //     color: Colors.white,
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(6)),
              //     shadows: const [
              //       BoxShadow(
              //         color: Color(0x3F000000),
              //         blurRadius: 4,
              //         offset: Offset(0, 0),
              //         spreadRadius: 0,
              //       )
              //     ],
              //   ),
              //   child: const Center(
              //     child: Text(
              //       'Backend Banner',
              //       textAlign: TextAlign.center,
              //       style: TextStyle(
              //         fontSize: 18,
              //       ),
              //     ),
              //   ),
              // ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                  child: SingleChildScrollView(
                    controller: controller.scrollController,
                    child: Column(
                      children: [
                        Showcase(
                          key: inSightKey,
                          description:
                              'Check your daily cognitive behavioral therapy lesson here.',
                          disableDefaultTargetGestures: false,
                          onBarrierClick: () {
                            controller.scrollController.animateTo(
                              300,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          child: GestureDetector(
                            onTap: () => debugPrint('menu button clicked'),
                            child: Column(
                              key: controller.insighKey,
                              children: [
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                HomeComponentCount(
                                  title: "Insights",
                                  height: height,
                                  width: width,
                                  count: 1,
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                PostItemWidget(
                                  title: controller.getTodayCBTTitle.value
                                      .replaceAll("\r", "")
                                      .replaceAll("\n", "")
                                      .replaceAll("Â", ""),
                                  keywrod: "Journaling your thoughts",
                                  imageUrl: 'assets/images/home_cbt.png',
                                  isNew: true,
                                  backColor: const Color(0xffEBB456),
                                  heigth: height,
                                  width: width,
                                  iconButtonType: Icons.menu_book_sharp,
                                  onPressed: () {
                                    Get.to(() => const CbtPage(),
                                        binding: CbtBinding());
                                  },
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                              ],
                            ),
                          ),
                        ),
                        HomeComponentCount(
                          title: "Today's Budget",
                          height: height,
                          width: width,
                          count: 2,
                        ),
                        SizedBox(
                          height: height * 0.15,
                          width: width,
                          child:
                              controller.getTodayBudget.value.budgetVM == null
                                  ? Center(
                                      child: Text(
                                        "Please wait Loading...",
                                        style: AppTextStyles.formalTextStyle(),
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          width: width * 0.25,
                                          child: CirculerProgress(
                                            textColor: Theme.of(context)
                                                .primaryTextTheme
                                                .titleMedium!
                                                .color!,
                                            onTap: () {
                                              if (controller
                                                      .getTodayBudget
                                                      .value
                                                      .budgetVM!
                                                      .consCalories! >
                                                  controller
                                                      .getTodayBudget
                                                      .value
                                                      .budgetVM!
                                                      .targetCalories!) {
                                                customSnackbar(
                                                    title: AppTexts.alert,
                                                    message:
                                                        "You are exceeding the limit.");
                                              }
                                            },
                                            size: min(width, height) * 0.12,
                                            lineWidth: 6,
                                            progress: controller
                                                        .getTodayBudget
                                                        .value
                                                        .budgetVM!
                                                        .consCalories ==
                                                    0
                                                ? 0
                                                : (controller
                                                                .getTodayBudget
                                                                .value
                                                                .budgetVM!
                                                                .consCalories! /
                                                            controller
                                                                .getTodayBudget
                                                                .value
                                                                .budgetVM!
                                                                .targetCalories!) >
                                                        1
                                                    ? 1
                                                    : controller
                                                            .getTodayBudget
                                                            .value
                                                            .budgetVM!
                                                            .consCalories! /
                                                        controller
                                                            .getTodayBudget
                                                            .value
                                                            .budgetVM!
                                                            .targetCalories!,
                                            progressText:
                                                "${controller.getTodayBudget.value.budgetVM!.consCalories}\nkcal",
                                            progressType: "Calories",
                                            progressColor: controller
                                                        .getTodayBudget
                                                        .value
                                                        .budgetVM!
                                                        .consCalories! >
                                                    controller
                                                        .getTodayBudget
                                                        .value
                                                        .budgetVM!
                                                        .targetCalories!
                                                ? AppColors.abstractionTextColor
                                                : AppColors.buttonColor,
                                          ),
                                        ),
                                        CirculerProgress(
                                          textColor: Theme.of(context)
                                              .primaryTextTheme
                                              .titleMedium!
                                              .color!,
                                          onTap: () {
                                            if (controller.getTodayBudget.value
                                                    .budgetVM!.carbs! >
                                                controller.getTodayBudget.value
                                                    .budgetVM!.targetCarbs!) {
                                              customSnackbar(
                                                  title: AppTexts.alert,
                                                  message:
                                                      "You are exceeding the limit.");
                                            }
                                          },
                                          size: min(width, height) * 0.09,
                                          progress: controller.getTodayBudget
                                                      .value.budgetVM!.carbs ==
                                                  0.0
                                              ? 0
                                              : (controller
                                                              .getTodayBudget
                                                              .value
                                                              .budgetVM!
                                                              .carbs! /
                                                          controller
                                                              .getTodayBudget
                                                              .value
                                                              .budgetVM!
                                                              .targetCarbs!) >
                                                      1
                                                  ? 1
                                                  : controller
                                                          .getTodayBudget
                                                          .value
                                                          .budgetVM!
                                                          .carbs! /
                                                      controller
                                                          .getTodayBudget
                                                          .value
                                                          .budgetVM!
                                                          .targetCarbs!,
                                          progressText:
                                              "${controller.getTodayBudget.value.budgetVM!.carbs!.toPrecision(1)}g",
                                          progressType: "Carbs",
                                          progressColor: controller
                                                      .getTodayBudget
                                                      .value
                                                      .budgetVM!
                                                      .carbs! >
                                                  controller
                                                      .getTodayBudget
                                                      .value
                                                      .budgetVM!
                                                      .targetCarbs!
                                              ? AppColors.abstractionTextColor
                                              : const Color(0xffDEBDA2),
                                        ),
                                        CirculerProgress(
                                          textColor: Theme.of(context)
                                              .primaryTextTheme
                                              .titleMedium!
                                              .color!,
                                          onTap: () {
                                            if (controller.getTodayBudget.value
                                                    .budgetVM!.fat! >
                                                controller.getTodayBudget.value
                                                    .budgetVM!.targetFat!) {
                                              customSnackbar(
                                                  title: AppTexts.alert,
                                                  message:
                                                      "You are exceeding the limit.");
                                            }
                                          },
                                          size: min(width, height) * 0.09,
                                          progress: controller.getTodayBudget
                                                      .value.budgetVM!.fat ==
                                                  0.0
                                              ? 0
                                              : (controller.getTodayBudget.value
                                                              .budgetVM!.fat! /
                                                          controller
                                                              .getTodayBudget
                                                              .value
                                                              .budgetVM!
                                                              .targetFat!) >
                                                      1
                                                  ? 1
                                                  : controller
                                                          .getTodayBudget
                                                          .value
                                                          .budgetVM!
                                                          .fat! /
                                                      controller
                                                          .getTodayBudget
                                                          .value
                                                          .budgetVM!
                                                          .targetFat!,
                                          progressText:
                                              "${controller.getTodayBudget.value.budgetVM!.fat!.toPrecision(1)}g",
                                          progressType: "Fat",
                                          progressColor: controller
                                                      .getTodayBudget
                                                      .value
                                                      .budgetVM!
                                                      .fat! >
                                                  controller
                                                      .getTodayBudget
                                                      .value
                                                      .budgetVM!
                                                      .targetFat!
                                              ? AppColors.abstractionTextColor
                                              : const Color(0xffFAD56D),
                                        ),
                                        CirculerProgress(
                                          textColor: Theme.of(context)
                                              .primaryTextTheme
                                              .titleMedium!
                                              .color!,
                                          onTap: () {
                                            if (controller.getTodayBudget.value
                                                    .budgetVM!.protein! >
                                                controller.getTodayBudget.value
                                                    .budgetVM!.targetProtein!) {
                                              customSnackbar(
                                                  title: AppTexts.alert,
                                                  message:
                                                      "You are exceeding the limit.");
                                            }
                                          },
                                          size: min(width, height) * 0.09,
                                          progress: controller
                                                      .getTodayBudget
                                                      .value
                                                      .budgetVM!
                                                      .protein ==
                                                  0.0
                                              ? 0
                                              : (controller
                                                              .getTodayBudget
                                                              .value
                                                              .budgetVM!
                                                              .protein! /
                                                          controller
                                                              .getTodayBudget
                                                              .value
                                                              .budgetVM!
                                                              .targetProtein!) >
                                                      1
                                                  ? 1
                                                  : controller
                                                          .getTodayBudget
                                                          .value
                                                          .budgetVM!
                                                          .protein! /
                                                      controller
                                                          .getTodayBudget
                                                          .value
                                                          .budgetVM!
                                                          .targetProtein!,
                                          progressText:
                                              "${controller.getTodayBudget.value.budgetVM!.protein!.toPrecision(1)}g",
                                          progressType: "Protein",
                                          progressColor: controller
                                                      .getTodayBudget
                                                      .value
                                                      .budgetVM!
                                                      .protein! >
                                                  controller
                                                      .getTodayBudget
                                                      .value
                                                      .budgetVM!
                                                      .targetProtein!
                                              ? AppColors.abstractionTextColor
                                              : const Color(0xffFD898D),
                                        ),

                                        // CirculerProgress(
                                        //   size: height * 0.045,
                                        //   progress: controller
                                        //               .getTodayQuota
                                        //               .value
                                        //               .budgetVM!
                                        //               .targetSodium ==
                                        //           0.0
                                        //       ? 0
                                        //       : (controller
                                        //                       .getTodayQuota
                                        //                       .value
                                        //                       .budgetVM!
                                        //                       .sodium! /
                                        //                   controller
                                        //                       .getTodayQuota
                                        //                       .value
                                        //                       .budgetVM!
                                        //                       .targetSodium!) >
                                        //               1
                                        //           ? 1
                                        //           : controller
                                        //                   .getTodayQuota
                                        //                   .value
                                        //                   .budgetVM!
                                        //                   .sodium! /
                                        //               controller
                                        //                   .getTodayQuota
                                        //                   .value
                                        //                   .budgetVM!
                                        //                   .targetSodium!,
                                        //   progressText:
                                        //       "${controller.getTodayQuota.value.budgetVM!.sodium!.toPrecision(1)}g",
                                        //   progressType: "Sodium",
                                        //   progressColor: controller
                                        //               .getTodayQuota
                                        //               .value
                                        //               .budgetVM!
                                        //               .sodium! >
                                        //           controller
                                        //               .getTodayQuota
                                        //               .value
                                        //               .budgetVM!
                                        //               .targetSodium!
                                        //       ? AppColors.abstractionTextColor
                                        //       : const Color(0xffDEBDA2),
                                        // ),
                                      ],
                                    ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Showcase(
                          key: breakFastKey,
                          description:
                              "Tap 'Add' for suggested meals, or 'Replace' for other options that suit your taste",
                          disableDefaultTargetGestures: false,
                          onBarrierClick: () {
                            controller.scrollController.animateTo(
                              600,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                            //  controller.scrollController.jumpTo(600);
                          },
                          child: GestureDetector(
                            onTap: () => debugPrint('menu button clicked'),
                            child: SizedBox(
                              //key: controller.breakFastKey,
                              height: height * 0.45,
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: TabBar(
                                      controller: controller.tabController,
                                      indicatorSize: TabBarIndicatorSize.label,
                                      indicatorColor: AppColors.buttonColor,
                                      labelPadding: const EdgeInsets.all(0),
                                      indicatorPadding: const EdgeInsets.all(0),
                                      labelColor: AppColors.buttonColor,
                                      indicatorWeight: 4,
                                      labelStyle:
                                          AppTextStyles.formalTextStyle(),
                                      unselectedLabelColor:
                                          const Color(0xFFB7B7B7),
                                      unselectedLabelStyle:
                                          AppTextStyles.formalTextStyle(),
                                      tabs: controller.innerHomeScreenTabsList,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 9,
                                    child: controller.isFoodLoading.value
                                        ? const Center(
                                            child: CircularProgressIndicator
                                                .adaptive(),
                                          )
                                        : controller.getTodayFoodList.isEmpty
                                            ? Center(
                                                child: Material(
                                                  color: AppColors.buttonColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      tabController
                                                          .animateTo(1);
                                                    },
                                                    child: SizedBox(
                                                        width: width * 0.45,
                                                        height: 51,
                                                        child: Center(
                                                          child: Text(
                                                            'Activate your Plan',
                                                            style: AppTextStyles
                                                                .formalTextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        )),
                                                  ),
                                                ),
                                              )
                                            : TabBarView(
                                                controller:
                                                    controller.tabController,
                                                children: [
                                                  BreakFastScreen(
                                                    getTodayDietBreakfastList:
                                                        controller
                                                            .getTodayFoodList
                                                            .where((element) =>
                                                                element
                                                                    .mealType ==
                                                                "Breakfast")
                                                            .toList(),
                                                  ),
                                                  LunchScreen(
                                                    getTodayDietLunchList:
                                                        controller
                                                            .getTodayFoodList
                                                            .where((element) =>
                                                                element
                                                                    .mealType ==
                                                                "Lunch")
                                                            .toList(),
                                                  ),
                                                  SnackScreen(
                                                    getTodayDietSnackList: controller
                                                        .getTodayFoodList
                                                        .where((element) =>
                                                            element.mealType ==
                                                                "Snacks" ||
                                                            element.mealType ==
                                                                "Snack")
                                                        .toList(),
                                                  ),
                                                  DinnerScreen(
                                                    getTodayDietDinnerList:
                                                        controller
                                                            .getTodayFoodList
                                                            .where((element) =>
                                                                element
                                                                    .mealType ==
                                                                "Dinner")
                                                            .toList(),
                                                  ),
                                                ],
                                              ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        // GestureDetector(
                        //     onTap: () {
                        //     //  Get.to(() =>const PaymentDiscountPage());
                        //      // Get.to( PaymentPage());
                        //      Get.to(const StripeScreen());
                        //     },
                        //     child: const Text('feature toturial')),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        Showcase(
                          key: cheatFoodKey,
                          description:
                              "Unlock your cheat meal after 7 days of task completion. You can add your cheat meal here.",
                          disableDefaultTargetGestures: false,
                          onBarrierClick: () {
                            controller.scrollController.animateTo(700,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease);
                            // controller.scrollController.jumpTo(700);
                          },
                          // =>
                          //     debugPrint('Barrier clicked'),
                          child: InkWell(
                            onTap: !controller.hasInternet.value
                                ? () {}
                                : () {
                                    Get.to(
                                      () => CheatFoodPage(
                                          cheatScore: controller.getTodayBudget
                                                  .value.cheatScore ??
                                              0.0),
                                      binding: CheatFoodBinding(),
                                    );
                                  },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: height * 0.02,
                                  horizontal: width * 0.02),
                              child: Column(
                                key: controller.cheatFoodKey,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Cheat Food',
                                            style:
                                                AppTextStyles.formalTextStyle(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .primaryTextTheme
                                                  .titleMedium!
                                                  .color!,
                                            ),
                                          ),
                                          SvgPicture.asset(
                                            AppAssets.cheatFoodSvgUrl,
                                            color: const Color(0xFFFF9606),
                                          )
                                        ],
                                      ),
                                      Text(
                                        'Redeemed',
                                        style: AppTextStyles.formalTextStyle(
                                          color: const Color(0xFFD9D9D9),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.015,
                                  ),
                                  LinearPercentIndicator(
                                    // width: width * 0.85,
                                    animation: true,
                                    lineHeight: height * .015,
                                    animationDuration: 1000,
                                    percent: controller.getTodayBudget.value
                                                .cheatScore ==
                                            null
                                        ? 0.0
                                        : controller.getTodayBudget.value
                                                        .cheatScore! /
                                                    7 >
                                                1
                                            ? 1
                                            : controller.getTodayBudget.value
                                                    .cheatScore! /
                                                7,
                                    backgroundColor: const Color(0xffD9D9D9),
                                    barRadius: const Radius.circular(20),
                                    progressColor: const Color(0xFFFF9606),
                                    alignment: MainAxisAlignment.center,
                                    padding: const EdgeInsets.all(0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Showcase(
                          key: workOutKey,
                          description: "Access your daily workouts here.",
                          disableDefaultTargetGestures: false,
                          onBarrierClick: () {
                            print('tab to work out');
                            controller.scrollController.animateTo(
                              1200,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                            // controller.scrollController.jumpTo(1200);
                          },
                          child: Column(
                            children: [
                              HomeComponentCount(
                                title: "Today's Workout",
                                height: height,
                                width: width,
                                count: 3,
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              controller.getTodayExerciseList.isEmpty
                                  ? Center(
                                      child: Text(
                                        "No Today Exercise Found",
                                        style: AppTextStyles.formalTextStyle(
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .titleMedium!
                                              .color!,
                                        ),
                                      ),
                                    )
                                  : Column(
                                      children: [
                                        ExercisePerformanceWidget(
                                          width: width,
                                          height: height,
                                          exercise: controller
                                              .getTodayExerciseList[0],
                                          onPressed: !controller
                                                  .hasInternet.value
                                              ? () {}
                                              : () async {
                                                  if (controller
                                                      .getTodayExerciseList[0]
                                                      .isRep!) {
                                                    await Get.to(
                                                      () => ExerciseRepsPage(
                                                        exerciseItemDetailModel:
                                                            ExerciseItemDetailModel(
                                                          calories: controller
                                                              .getTodayExerciseList[
                                                                  0]
                                                              .calories,
                                                          day: controller
                                                              .getTodayExerciseList[
                                                                  0]
                                                              .day,
                                                          videoDuration: controller
                                                              .getTodayExerciseList[
                                                                  0]
                                                              .exerciseDuration,
                                                          userExerciseDuration:
                                                              controller
                                                                  .getTodayExerciseList[
                                                                      0]
                                                                  .durationCompleted,
                                                          exerciseId: controller
                                                              .getTodayExerciseList[
                                                                  0]
                                                              .exerciseId,
                                                          planId: controller
                                                              .getTodayExerciseList[
                                                                  0]
                                                              .planId,
                                                          name: controller
                                                              .getTodayExerciseList[
                                                                  0]
                                                              .name,
                                                          title: controller
                                                              .getTodayExerciseList[
                                                                  0]
                                                              .title,
                                                          exercisePlanId: controller
                                                              .getTodayExerciseList[
                                                                  0]
                                                              .exerciseId,
                                                          fileName: controller
                                                              .getTodayExerciseList[
                                                                  0]
                                                              .exerciseImage,
                                                          videoFile: controller
                                                              .getTodayExerciseList[
                                                                  0]
                                                              .videoFile,
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    await Get.to(
                                                      () =>
                                                          const ExerciseTimerPage(
                                                              exerciseIndex: 2),
                                                      binding:
                                                          ExerciseTimerBinding(
                                                        exerciseItemDetailModel:
                                                            ExerciseItemDetailModel(
                                                          calories: controller
                                                              .getTodayExerciseList[
                                                                  0]
                                                              .calories,
                                                          day: controller
                                                              .getTodayExerciseList[
                                                                  0]
                                                              .day,
                                                          videoDuration: controller
                                                              .getTodayExerciseList[
                                                                  0]
                                                              .exerciseDuration,
                                                          userExerciseDuration:
                                                              controller
                                                                  .getTodayExerciseList[
                                                                      0]
                                                                  .durationCompleted,
                                                          exerciseId: controller
                                                              .getTodayExerciseList[
                                                                  0]
                                                              .exerciseId,
                                                          planId: controller
                                                              .getTodayExerciseList[
                                                                  0]
                                                              .planId,
                                                          name: controller
                                                              .getTodayExerciseList[
                                                                  0]
                                                              .name,
                                                          title: controller
                                                              .getTodayExerciseList[
                                                                  0]
                                                              .title,
                                                          exercisePlanId: controller
                                                              .getTodayExerciseList[
                                                                  0]
                                                              .exerciseId,
                                                          fileName: controller
                                                              .getTodayExerciseList[
                                                                  0]
                                                              .exerciseImage,
                                                          videoFile: controller
                                                              .getTodayExerciseList[
                                                                  0]
                                                              .videoFile,
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  controller
                                                      .getTodayExerciseApi();
                                                },
                                          // onRefreshTap: () async {
                                          //   try {
                                          //     ActiveExercisePlanVM
                                          //         repExercise =
                                          //         await controller
                                          //             .replaceExercise(
                                          //                 index);
                                          //     controller.getTodayQuota.value
                                          //             .activeExercisePlanVM![
                                          //         index] = repExercise;
                                          //     // setState(() {});
                                          //   } catch (e) {
                                          //     customSnackbar(
                                          //         title: AppTexts.error,
                                          //         message: e.toString());
                                          //   }
                                          // },
                                        ),
                                        IconButton(
                                          onPressed:
                                              !controller.hasInternet.value
                                                  ? () {}
                                                  : () {
                                                      Get.to(
                                                        () => ExercisePlanDetialPage(
                                                            planTitle: controller
                                                                .getTodayExerciseList[
                                                                    0]
                                                                .planTitle!,
                                                            planImage: null),
                                                        binding:
                                                            ExercisePlanDetialBinding(),
                                                        arguments:
                                                            PlanIdAndDuration(
                                                          duration: int.parse(controller
                                                                  .getTodayExerciseList[
                                                                      0]
                                                                  .planDuration ??
                                                              "70"),
                                                          planId: controller
                                                              .getTodayExerciseList[
                                                                  0]
                                                              .planId,
                                                          day: controller
                                                              .getTodayExerciseList[
                                                                  0]
                                                              .day,
                                                        ),
                                                      );
                                                    },
                                          icon: const Icon(
                                            Icons
                                                .arrow_drop_down_circle_outlined,
                                            size: 35,
                                          ),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        HomeComponentCount(
                          title: "Stress Buster",
                          height: height,
                          width: width,
                          count: 4,
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.04),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 16.70,
                                height: 25.83,
                                child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Image.asset(
                                      "assets/images/commas.png",
                                      height: 11.83,
                                      color: AppColors.black,
                                    )),
                              ),
                              Container(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(
                                  controller.getTodayMeditation.value.qoutes ==
                                          null
                                      ? "Qoute of the Day"
                                      : controller.getTodayMeditation.value
                                              .qoutes!.qoute ??
                                          'The first and best victory is to concern yourself',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .titleMedium!
                                          .color!,
                                      fontFamily: AppTextStyles.fontFamily,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            StressBusterWidget(
                              height: height,
                              width: width,
                              onPressed: !controller.hasInternet.value
                                  ? () {}
                                  : controller.getTodayMeditation.value
                                              .mindVideos ==
                                          null
                                      ? () {
                                          customSnackbar(
                                              title: AppTexts.alert,
                                              message:
                                                  "Please Activate Mind Plan");
                                        }
                                      : controller.getTodayMeditation.value
                                              .mindVideos!.isEmpty
                                          ? () {
                                              customSnackbar(
                                                  title: AppTexts.alert,
                                                  message:
                                                      "Please Activate Mind Plan");
                                            }
                                          : () {
                                              // print(
                                              //     "plan ${controller.getTodayQuota.value.activeMindPlanVM![0].duration}");
                                              Get.to(
                                                () => MindPalnDetailPage(
                                                  planImage: null,
                                                  planTitle: controller
                                                      .getTodayMeditation
                                                      .value
                                                      .mindVideos![0]
                                                      .title!,
                                                ),
                                                binding:
                                                    MindPalnDetailBinding(),
                                                arguments: PlanIdAndDuration(
                                                  duration: int.tryParse(
                                                    controller
                                                            .getTodayMeditation
                                                            .value
                                                            .mindVideos![0]
                                                            .planDuration ??
                                                        "70",
                                                  ),
                                                  planId: controller
                                                      .getTodayMeditation
                                                      .value
                                                      .mindVideos![0]
                                                      .mindPlanId,
                                                  day: controller
                                                      .getTodayMeditation
                                                      .value
                                                      .mindVideos![0]
                                                      .day!,
                                                ),
                                              );
                                            },
                              imageUrl: "assets/icons/medi_svg.svg",
                              title: 'Mindfulness\n10 Minutes',
                            ),
                            StressBusterWidget(
                              height: height,
                              width: width,
                              onPressed: () {
                                Get.to(
                                  () => const DeepSleepPage(),
                                  binding: DeepSleepBinding(),
                                );
                              },
                              imageUrl: "assets/icons/sleep_svg.svg",
                              title: 'Sleep',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Showcase(
                            key: todosKey,
                            description: "Check your daily tasks here.",
                            disableDefaultTargetGestures: false,
                            onBarrierClick: () {
                              // controller.scrollController.jumpTo(800);
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  // height: height * 0.05,
                                  width: width * 0.9,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Today's to do",
                                        style: AppTextStyles.formalTextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .titleMedium!
                                              .color!,
                                        ),
                                      )),
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                controller.getTodayTodosList.isEmpty
                                    ? Center(
                                        child: Text(
                                          "No Todo's Avialable for Today",
                                          style: AppTextStyles.formalTextStyle(
                                            color: Theme.of(context)
                                                .primaryTextTheme
                                                .titleMedium!
                                                .color!,
                                          ),
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount:
                                            controller.getTodayTodosList.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          Todos userTodo = controller
                                              .getTodayTodosList[index];
                                          // print(userTodo.image);
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                top: 12.0),
                                            child: TodoListItemWidget(
                                              todoPressed: !controller
                                                      .hasInternet.value
                                                  ? () {}
                                                  : () {
                                                      controller.saveTodosApi(
                                                          context,
                                                          completed: userTodo
                                                                  .completed!
                                                              ? false
                                                              : true,
                                                          titile:
                                                              userTodo.title!,
                                                          todosId:
                                                              userTodo.id!);
                                                    },
                                              todosModel: userTodo,
                                            ),
                                          );
                                        },
                                      ),
                                SizedBox(
                                  height: height * 0.1,
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          controller.loaderOverlayLoading.value
              ? const OverlayWidget()
              : const SizedBox(),
        ],
      ),
    );

    // ShowCaseWidget(
    //   onStart: (index, key) {},
    //   onComplete: (index, key) {
    //     if (index == 2) {
    //       SystemChrome.setSystemUIOverlayStyle(
    //         SystemUiOverlayStyle.light.copyWith(
    //           statusBarIconBrightness: Brightness.dark,
    //           statusBarColor: Colors.white,
    //         ),
    //       );
    //     }
    //   },
    //   blurValue: 1,
    //   builder: Builder(
    //     builder: (context) =>

    //   ),
    //   autoPlayDelay: const Duration(seconds: 3),
    // );
  }
}
