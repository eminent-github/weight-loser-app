import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

import '../controller/diet_plan_detail_controller.dart';
import '../widget/food_item.dart';

class DietPlanDetailPage extends GetView<DietPlanDetailController> {
  final String? planTitle;
  final String? planImage;
  final RxBool isActivated;
  final VoidCallback? activateViewedPlan;
  const DietPlanDetailPage(
      {super.key,
      required this.isActivated,
      required this.planImage,
      this.planTitle,
      this.activateViewedPlan});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          planTitle!,
          style: AppTextStyles.formalTextStyle(
              fontSize: height * 0.024,
              fontWeight: FontWeight.w600,
              color: AppColors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.white),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: InternetCheckWidget<ConnectivityService>(
        child: Obx(
          () => Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: height * 0.3,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppAssets.dietImgUrl),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        planImage == null
                            ? Image.asset(
                                AppAssets.mindImgUrl,
                                fit: BoxFit.cover,
                              )
                            : S3LoadingImage(
                                imageUrl:
                                    "${ApiUrls.s3ImageBaseUrl}planImages/dietPlans/$planImage",
                                fit: BoxFit.cover),
                        Container(
                          color: AppColors.black.withAlpha(130),
                        ),
                      ],
                    ),
                  ),
                  isActivated.value
                      ? const SizedBox()
                      : Padding(
                          padding: EdgeInsets.only(
                              right: width * 0.06,
                              top: height * 0.01,
                              bottom: height * 0.01),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: MaterialButton(
                              onPressed: activateViewedPlan,
                              minWidth: width * 0.35,
                              color: AppColors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Text(
                                AppTexts.activate,
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                        ),
                  Container(
                    height: height * 0.065,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2)),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 1),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: controller.scrollController,
                      shrinkWrap: true,
                      itemCount: controller.planIdAndDuration.value.duration,
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      itemBuilder: (context, index) {
                        bool showLock = !isActivated.value && index >= 4;
                        bool isClickable = !showLock || index < 4;
                        bool isActiveClickable =
                            controller.planIdAndDuration.value.day! > 7
                                ? index <
                                    controller.planIdAndDuration.value.day!
                                : index <
                                    controller.planIdAndDuration.value.day! + 6;
                        return Obx(
                          () => isActivated.value
                              ? GestureDetector(
                                  onTap: isActiveClickable
                                      ? () {
                                          controller.selectedIndex.value =
                                              index;
                                          controller.dietActivePlans(
                                              controller.planIdAndDuration.value
                                                  .planId!,
                                              index + 1);
                                        }
                                      : null,
                                  child: Container(
                                    width: width * 0.15,
                                    margin: EdgeInsets.symmetric(
                                      vertical: showLock
                                          ? height * 0.010
                                          : height * 0.014,
                                    ),
                                    decoration: ShapeDecoration(
                                      color: controller.selectedIndex.value ==
                                              index
                                          ? AppColors.buttonColor
                                          : AppColors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          showLock
                                              ? Icon(
                                                  Icons.lock,
                                                  size: height * 0.0095,
                                                  color:
                                                      const Color(0xFFB1B1B1),
                                                )
                                              : const SizedBox(),
                                          Text(
                                            "Day ${index + 1}".toString(),
                                            style:
                                                AppTextStyles.formalTextStyle(
                                                    color: controller
                                                                .selectedIndex
                                                                .value ==
                                                            index
                                                        ? Colors.white
                                                        : controller
                                                                    .planIdAndDuration
                                                                    .value
                                                                    .day ==
                                                                (index + 1)
                                                            ? AppColors
                                                                .buttonColor
                                                            : const Color(
                                                                0xFFB1B1B1),
                                                    fontWeight: controller
                                                                .planIdAndDuration
                                                                .value
                                                                .day ==
                                                            (index + 1)
                                                        ? FontWeight.bold
                                                        : FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: isClickable
                                      ? () {
                                          controller.selectedIndex.value =
                                              index;
                                          controller.dietActivePlans(
                                              controller.planIdAndDuration.value
                                                  .planId!,
                                              index + 1);
                                        }
                                      : null,
                                  child: Container(
                                    width: width * 0.15,
                                    margin: EdgeInsets.symmetric(
                                      vertical: showLock
                                          ? height * 0.010
                                          : height * 0.014,
                                    ),
                                    decoration: ShapeDecoration(
                                      color: controller.selectedIndex.value ==
                                              index
                                          ? AppColors.buttonColor
                                          : AppColors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          showLock
                                              ? Icon(
                                                  Icons.lock,
                                                  size: height * 0.0095,
                                                  color:
                                                      const Color(0xFFB1B1B1),
                                                )
                                              : const SizedBox(),
                                          Text(
                                            "Day ${index + 1}".toString(),
                                            style:
                                                AppTextStyles.formalTextStyle(
                                              color: controller.selectedIndex
                                                          .value ==
                                                      index
                                                  ? Colors.white
                                                  : const Color(0xFFB1B1B1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: controller.isLoading.value
                        ? const Center(
                            child: OverlayWidget(),
                          )
                        : CustomScrollView(
                            slivers: [
                              SliverToBoxAdapter(
                                child: SizedBox(
                                  height: height * .02,
                                ),
                              ),

                              SliverToBoxAdapter(
                                child: Row(
                                  children: [
                                    mealTypeText(height, width,
                                        text: "Breakfast"),
                                  ],
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: SizedBox(
                                  height: height * .02,
                                ),
                              ),

                              FoodItems(
                                queryList: controller.getActivePlanList
                                    .where((element) =>
                                        element.mealType == "Breakfast")
                                    .toList(),
                                type: "Breakfast",
                                isActivated: isActivated.value,
                                isCurrentDay:
                                    controller.selectedIndex.value + 1 ==
                                        controller.planIdAndDuration.value.day,
                                totalDays:
                                    controller.planIdAndDuration.value.duration,
                              ),

                              ///-----------------------------------------------------------------
                              SliverToBoxAdapter(
                                child: SizedBox(
                                  height: height * .02,
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: Row(
                                  children: [
                                    mealTypeText(height, width, text: "Snacks"),
                                  ],
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: SizedBox(
                                  height: height * .02,
                                ),
                              ),

                              FoodItems(
                                queryList: controller.getActivePlanList
                                    .where((element) =>
                                        element.mealType == "Snacks" ||
                                        element.mealType == "Snack")
                                    .toList(),
                                type: "Snacks",
                                isCurrentDay:
                                    controller.selectedIndex.value + 1 ==
                                        controller.planIdAndDuration.value.day,
                                isActivated: isActivated.value,
                                totalDays:
                                    controller.planIdAndDuration.value.duration,
                              ),

                              ///-------------------------------------------------------
                              SliverToBoxAdapter(
                                child: SizedBox(
                                  height: height * .02,
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: Row(
                                  children: [
                                    mealTypeText(height, width, text: "Lunch"),
                                  ],
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: SizedBox(
                                  height: height * .02,
                                ),
                              ),
                              FoodItems(
                                queryList: controller.getActivePlanList
                                    .where((element) =>
                                        element.mealType == "Lunch")
                                    .toList(),
                                type: "Lunch",
                                isActivated: isActivated.value,
                                isCurrentDay:
                                    controller.selectedIndex.value + 1 ==
                                        controller.planIdAndDuration.value.day,
                                totalDays:
                                    controller.planIdAndDuration.value.duration,
                              ),
                              //---------------------------------------------------------------------------
                              SliverToBoxAdapter(
                                child: SizedBox(
                                  height: height * .02,
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: Row(
                                  children: [
                                    mealTypeText(height, width, text: "Dinner"),
                                  ],
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: SizedBox(
                                  height: height * .02,
                                ),
                              ),

                              FoodItems(
                                queryList: controller.getActivePlanList
                                    .where((element) =>
                                        element.mealType == "Dinner")
                                    .toList(),
                                type: "Dinner",
                                isActivated: isActivated.value,
                                isCurrentDay:
                                    controller.selectedIndex.value + 1 ==
                                        controller.planIdAndDuration.value.day,
                                totalDays:
                                    controller.planIdAndDuration.value.duration,
                              ),
                              //---------------------------------------------------------------------------
                              SliverToBoxAdapter(
                                child: SizedBox(
                                  height: height * .02,
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
              controller.isAddFavouriteLoading.value
                  ? const Center(
                      child: OverlayWidget(),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Widget mealTypeText(double height, double width, {required String text}) {
    return Container(
      height: height * 0.033,
      width: width * 0.2,
      margin: EdgeInsets.only(
        left: width * .07,
      ),
      decoration: ShapeDecoration(
        color: AppColors.buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Center(
        child: Text(
          text,
          style: AppTextStyles.formalTextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
