import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/diary/controller/diary_controller.dart';
import 'package:weight_loss_app/modules/diary/screens/dairy_exercise_page.dart';
import 'package:weight_loss_app/modules/diary/screens/dairy_mind_page.dart';
import 'package:weight_loss_app/modules/diary/screens/diary_water_page.dart';
import 'package:weight_loss_app/modules/diary/widgets/diary_book_widget.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';
import 'package:weight_loss_app/modules/diary/screens/dairy_diet/diary_diet_page/diary_diet_page.dart';

class DiaryPage extends GetView<DiaryController> {
  const DiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Scaffold(
      body: InternetCheckWidget<ConnectivityService>(
        child: Obx(
          () => SafeArea(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Diary',
                      style: Theme.of(context).appBarTheme.titleTextStyle,
                    ),
                    Row(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: controller.subtractOneDay,
                          child: Padding(
                            padding: EdgeInsets.all(height * 0.005),
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium!
                                  .color!,
                              size: 22,
                            ),
                          ),
                        ),
                        Obx(
                          () => Center(
                            child: Text(
                              DateFormat("MMMM, dd")
                                  .format(controller.selectedDate.value),
                              textAlign: TextAlign.center,
                              style: AppTextStyles.formalTextStyle(
                                fontSize: 16,
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .titleMedium!
                                    .color!,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: controller.addOneDay,
                          child: Padding(
                            padding: EdgeInsets.all(height * 0.005),
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium!
                                  .color!,
                              size: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                controller.isLoading.value
                    ? OverlayWidget(
                        height: height * 0.8,
                      )
                    : Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.03),
                            child: SizedBox(
                              height: height * 0.2,
                              child: controller.diaryData.value.budgetVM == null
                                  ? Center(
                                      child: Text(
                                        "No Reccord Found",
                                        style: AppTextStyles.formalTextStyle(
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .titleMedium!
                                              .color!,
                                        ),
                                      ),
                                    )
                                  : Row(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Goal',
                                                style: AppTextStyles
                                                    .formalTextStyle(
                                                  color: Theme.of(context)
                                                      .primaryTextTheme
                                                      .titleMedium!
                                                      .color!,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          '${controller.diaryData.value.budgetVM!.targetCalories ?? 0}',
                                                      style: AppTextStyles
                                                          .formalTextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .appBarTheme
                                                                  .titleTextStyle!
                                                                  .color!,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 38),
                                                    ),
                                                    TextSpan(
                                                      text: 'kcal',
                                                      style: AppTextStyles
                                                          .formalTextStyle(
                                                        color: Theme.of(context)
                                                            .appBarTheme
                                                            .titleTextStyle!
                                                            .color!,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.08,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 4,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Meals',
                                                            style: AppTextStyles.formalTextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryTextTheme
                                                                    .titleMedium!
                                                                    .color!,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          LinearPercentIndicator(
                                                            animation: true,
                                                            lineHeight:
                                                                height * 0.013,
                                                            animationDuration:
                                                                500,
                                                            percent: 1,
                                                            backgroundColor:
                                                                const Color(
                                                                    0xffC7C7C7),
                                                            barRadius:
                                                                const Radius
                                                                    .circular(
                                                                    20),
                                                            progressColor:
                                                                const Color(
                                                                    0xff508F66),
                                                            alignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0),
                                                          ),
                                                          AutoSizeText(
                                                            '${controller.diaryData.value.budgetVM!.consCalories} Consumed',
                                                            maxLines: 1,
                                                            minFontSize: 5,
                                                            style: AppTextStyles
                                                                .formalTextStyle(
                                                              fontSize: 10,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryTextTheme
                                                                  .titleMedium!
                                                                  .color!,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Center(
                                                        child: Text(
                                                          '-',
                                                          style: AppTextStyles
                                                              .formalTextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryTextTheme
                                                                      .titleMedium!
                                                                      .color!,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 4,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Exercise',
                                                            style: AppTextStyles.formalTextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryTextTheme
                                                                    .titleMedium!
                                                                    .color!,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          LinearPercentIndicator(
                                                            animation: true,
                                                            lineHeight:
                                                                height * 0.013,
                                                            animationDuration:
                                                                500,
                                                            percent: 1,
                                                            backgroundColor:
                                                                const Color(
                                                                    0xffC7C7C7),
                                                            barRadius:
                                                                const Radius
                                                                    .circular(
                                                                    20),
                                                            progressColor:
                                                                AppColors
                                                                    .dietColor,
                                                            alignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0),
                                                          ),
                                                          AutoSizeText(
                                                            '${controller.diaryData.value.exerBurnCal!.toInt()} Burnt',
                                                            maxLines: 1,
                                                            minFontSize: 5,
                                                            style: AppTextStyles
                                                                .formalTextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryTextTheme
                                                                  .titleMedium!
                                                                  .color!,
                                                              fontSize: 10,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Expanded(
                                          flex: 1,
                                          child: SizedBox(),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: CircularPercentIndicator(
                                            radius: min(width, height) * 0.15,
                                            percent: (controller.diaryData.value.budgetVM!.consCalories! - controller.diaryData.value.exerBurnCal!.toInt()) /
                                                        controller
                                                            .diaryData
                                                            .value
                                                            .budgetVM!
                                                            .targetCalories! >
                                                    1
                                                ? 1
                                                : (controller.diaryData.value.budgetVM!.consCalories! - controller.diaryData.value.exerBurnCal!.toInt()) /
                                                            controller
                                                                .diaryData
                                                                .value
                                                                .budgetVM!
                                                                .targetCalories! <
                                                        0
                                                    ? 0
                                                    : (controller
                                                                .diaryData
                                                                .value
                                                                .budgetVM!
                                                                .consCalories! -
                                                            controller
                                                                .diaryData
                                                                .value
                                                                .exerBurnCal!
                                                                .toInt()) /
                                                        controller
                                                            .diaryData
                                                            .value
                                                            .budgetVM!
                                                            .targetCalories!,
                                            startAngle: 90,
                                            lineWidth: 8,
                                            progressColor: (controller
                                                            .diaryData
                                                            .value
                                                            .budgetVM!
                                                            .consCalories! -
                                                        controller.diaryData
                                                            .value.exerBurnCal!
                                                            .toInt()) >
                                                    controller
                                                        .diaryData
                                                        .value
                                                        .budgetVM!
                                                        .targetCalories!
                                                ? AppColors.abstractionTextColor
                                                : (controller
                                                                .diaryData
                                                                .value
                                                                .budgetVM!
                                                                .consCalories! -
                                                            controller
                                                                .diaryData
                                                                .value
                                                                .exerBurnCal!
                                                                .toInt()) <
                                                        controller
                                                            .diaryData
                                                            .value
                                                            .budgetVM!
                                                            .targetCalories!
                                                    ? AppColors.buttonColor
                                                    : AppColors.green,
                                            circularStrokeCap:
                                                CircularStrokeCap.round,
                                            center: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width * 0.05),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  AutoSizeText(
                                                    "${controller.diaryData.value.budgetVM!.balanceCalories}",
                                                    textAlign: TextAlign.center,
                                                    maxLines: 1,
                                                    minFontSize: 20,
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryTextTheme
                                                          .titleMedium!
                                                          .color!,
                                                      fontSize: 38,
                                                      fontFamily: AppTextStyles
                                                          .fontFamily,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0.8,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Balance",
                                                    style: AppTextStyles
                                                        .formalTextStyle(
                                                      fontSize: 15,
                                                      color: Theme.of(context)
                                                          .primaryTextTheme
                                                          .titleMedium!
                                                          .color!,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          DiaryBookWidget(
                            breakfastCalories:
                                controller.diaryData.value.breakFastCal != null
                                    ? controller.diaryData.value.breakFastCal!
                                        .toInt()
                                    : 0,
                            lunchCalories:
                                controller.diaryData.value.lunchCal != null
                                    ? controller.diaryData.value.lunchCal!
                                        .toInt()
                                    : 0,
                            snacksCalories:
                                controller.diaryData.value.snackCal != null
                                    ? controller.diaryData.value.snackCal!
                                        .toInt()
                                    : 0,
                            dinnerCalories:
                                controller.diaryData.value.dinnerCal != null
                                    ? controller.diaryData.value.dinnerCal!
                                        .toInt()
                                    : 0,
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          SizedBox(
                            height: height * 0.5,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: height * 0.08,
                                  child: TabBar(
                                    controller: controller.tabController,
                                    indicatorColor: AppColors.buttonColor,
                                    labelPadding: const EdgeInsets.all(0),
                                    indicator: const BoxDecoration(),
                                    indicatorPadding: const EdgeInsets.all(0),
                                    labelColor: AppColors.buttonColor,
                                    indicatorWeight: 4,
                                    labelStyle: AppTextStyles.formalTextStyle(),
                                    unselectedLabelColor:
                                        const Color(0xFFB7B7B7),
                                    unselectedLabelStyle:
                                        AppTextStyles.formalTextStyle(),
                                    tabs: controller.dairyScreenTabsList,
                                    tabAlignment: TabAlignment.fill,
                                  ),
                                ),
                                Expanded(
                                  child: TabBarView(
                                    controller: controller.tabController,
                                    children: [
                                      DiaryDietPage(
                                        breakfastList: controller.diaryData
                                                .value.breakfastList ??
                                            [],
                                        luncheList: controller
                                                .diaryData.value.luncheList ??
                                            [],
                                        dinnerList: controller
                                                .diaryData.value.dinnerList ??
                                            [],
                                        snackList: controller
                                                .diaryData.value.snackList ??
                                            [],
                                      ),
                                      DiaryWaterPage(
                                        waterIntake: controller.diaryData.value
                                                    .waterInTake !=
                                                null
                                            ? controller
                                                .diaryData.value.waterInTake!
                                                .toInt()
                                            : 0,
                                      ),
                                      DairyExercisePage(
                                        burnCalories: controller.diaryData.value
                                                    .exerBurnCal ==
                                                null
                                            ? 0
                                            : controller
                                                .diaryData.value.exerBurnCal!
                                                .toInt(),
                                      ),
                                      DairyMindPage(
                                          meditationTime: controller.diaryData
                                                  .value.mindDuration ??
                                              0,
                                          totalMeditationTime: controller
                                                  .diaryData
                                                  .value
                                                  .mindTotalDuration ??
                                              0),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
