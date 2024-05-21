import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/diet/add_your_food/model/own_food_deatil_model.dart';
import 'package:weight_loss_app/modules/diet/diet_food_item_detial/model/diet_food_item_detail_model.dart';
import 'package:weight_loss_app/modules/diet/own_food_detail/controller/own_food_detail_controller.dart';
import 'package:weight_loss_app/modules/recipe/add_recipe/widgets/add_recipe_circular.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_button_widget.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

class OwnFoodDetailPage extends GetView<OwnFoodDetailController> {
  const OwnFoodDetailPage({
    super.key,
    required this.recipeDetialData,
    required this.planFoodId,
    required this.planId,
  });
  final OwnFoodDetailModel recipeDetialData;

  final String planFoodId;
  final int planId;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          "Food",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
      ),
      body: InternetCheckWidget<ConnectivityService>(
        child: Obx(
          () => Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.18,
                        width: width,
                        child: recipeDetialData.fileName == null
                            ? Image.asset(
                                AppAssets.dietPlanImgUrl,
                                fit: BoxFit.cover,
                              )
                            : S3LoadingImage(
                                imageUrl:
                                    "${ApiUrls.s3ImageBaseUrl}Diet/${recipeDetialData.fileName}",
                                fit: BoxFit.cover,
                              ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      SizedBox(
                        width: width * 0.9,
                        height: height * 0.04,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 7,
                              child: Padding(
                                padding: EdgeInsets.only(right: width * 0.01),
                                child: AutoSizeText(
                                  recipeDetialData.name,
                                  minFontSize: 10,
                                  style: AppTextStyles.formalTextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .titleMedium!
                                        .color!,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: AutoSizeText.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Cooking Time: ',
                                      style: AppTextStyles.formalTextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .titleMedium!
                                            .color!,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '30 Minutes',
                                      style: AppTextStyles.formalTextStyle(
                                        color: AppColors.buttonColor,
                                        fontSize: 9,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                minFontSize: 5,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: width * 0.05),
                          child: Text(
                            "Serves: ${recipeDetialData.servingSize}",
                            style: const TextStyle(
                              color: AppColors.textServer2Color,
                              fontSize: 15,
                              fontFamily: AppTextStyles.fontFamily,
                              fontWeight: FontWeight.w400,
                              height: 1.60,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: width * 0.05),
                          child: Text(
                            AppTexts.nutritionPerServingText,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium!
                                  .color!,
                              fontSize: 11,
                              fontFamily: AppTextStyles.fontFamily,
                              fontWeight: FontWeight.w700,
                              height: 1.60,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.17,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: width * 0.33,
                              child: CaloriesChart(
                                carbs: recipeDetialData.carbs,
                                fat: recipeDetialData.fat,
                                protien: recipeDetialData.protein,
                                fatColor: const Color(0xffF36124),
                                carbColor: AppColors.lightBlueChartColor,
                                protienColor: const Color(0xff8665FD),
                                calories: recipeDetialData.calories,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.15,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularPercentIndicator(
                                    center: Text("${recipeDetialData.carbs}g",
                                        style: AppTextStyles.formalTextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .titleMedium!
                                              .color!,
                                        )),
                                    radius: height * 0.039,
                                    lineWidth: 5.5,
                                    animation: true,
                                    percent: 1,
                                    circularStrokeCap: CircularStrokeCap.round,
                                    startAngle: 0,
                                    backgroundColor: Colors.grey.shade400,
                                    progressColor: const Color(0xff1A95B0),
                                  ),
                                  SizedBox(
                                    height: height * 0.003,
                                  ),
                                  Text(
                                    AppTexts.carbs,
                                    style: AppTextStyles.formalTextStyle(
                                      fontSize: 10,
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .titleMedium!
                                          .color!,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width * 0.01,
                            ),
                            SizedBox(
                              height: height * 0.15,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularPercentIndicator(
                                    center: Text("${recipeDetialData.protein}g",
                                        style: AppTextStyles.formalTextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .titleMedium!
                                              .color!,
                                        )),
                                    radius: height * 0.039,
                                    lineWidth: 5.5,
                                    animation: true,
                                    percent: 1,
                                    circularStrokeCap: CircularStrokeCap.round,
                                    startAngle: 0,
                                    backgroundColor: Colors.grey.shade400,
                                    progressColor: const Color(0xff8665FD),
                                  ),
                                  SizedBox(
                                    height: height * 0.003,
                                  ),
                                  Text(AppTexts.protein,
                                      style: AppTextStyles.formalTextStyle(
                                        fontSize: 10,
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .titleMedium!
                                            .color!,
                                      ))
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width * 0.01,
                            ),
                            SizedBox(
                              height: height * 0.15,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularPercentIndicator(
                                    center: Text("${recipeDetialData.fat}g",
                                        style: AppTextStyles.formalTextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .titleMedium!
                                              .color!,
                                        )),
                                    radius: height * 0.039,
                                    lineWidth: 5.5,
                                    animation: true,
                                    percent: 1,
                                    circularStrokeCap: CircularStrokeCap.round,
                                    startAngle: 0,
                                    backgroundColor: Colors.grey.shade400,
                                    progressColor: const Color(0xffF36124),
                                  ),
                                  SizedBox(
                                    height: height * 0.003,
                                  ),
                                  Text("Fat",
                                      style: AppTextStyles.formalTextStyle(
                                        fontSize: 10,
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .titleMedium!
                                            .color!,
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width * 0.08,
                            ),
                          ],
                        ),
                      ),
                      FutureBuilder(
                        future:
                            controller.getFoodDetail(recipeDetialData.foodId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else {
                            FoodItemDetailModel foodItemDetailModel =
                                snapshot.data!;
                            return foodItemDetailModel.foodDetailVM == null
                                ? const SizedBox()
                                : Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: width * 0.1),
                                          child: Text(
                                            "Ingredients ",
                                            style:
                                                AppTextStyles.formalTextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                  .primaryTextTheme
                                                  .titleMedium!
                                                  .color!,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.1),
                                          child: foodItemDetailModel
                                                      .foodDetailVM!
                                                      .ingredients ==
                                                  null
                                              ? const SizedBox()
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: foodItemDetailModel
                                                      .foodDetailVM!
                                                      .ingredients!
                                                      .map(
                                                        (e) => Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: height *
                                                                      0.01),
                                                          child: Text(
                                                            e,
                                                            style: AppTextStyles
                                                                .formalTextStyle(
                                                              fontSize: 11,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryTextTheme
                                                                  .titleMedium!
                                                                  .color!,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: width * 0.1),
                                          child: Text(
                                            "How to Cook?",
                                            style:
                                                AppTextStyles.formalTextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                  .primaryTextTheme
                                                  .titleMedium!
                                                  .color!,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.1),
                                          child:
                                              //  Column(
                                              //   crossAxisAlignment:
                                              //       CrossAxisAlignment.start,
                                              // children: controller.foodItemDetailModel.value.foodDetailVM!.procedure
                                              //     .map(
                                              //       (e) =>
                                              Padding(
                                            padding: EdgeInsets.only(
                                                top: height * 0.01),
                                            child: foodItemDetailModel
                                                        .foodDetailVM!
                                                        .procedure ==
                                                    null
                                                ? const SizedBox()
                                                : Text(
                                                    foodItemDetailModel
                                                        .foodDetailVM!
                                                        .procedure!,
                                                    style: AppTextStyles
                                                        .formalTextStyle(
                                                      fontSize: 11,
                                                      color: Theme.of(context)
                                                          .primaryTextTheme
                                                          .titleMedium!
                                                          .color!,
                                                    ),
                                                  ),
                                          ),
                                          // )
                                          // .toList(),
                                          // ),
                                        ),
                                      ),
                                    ],
                                  );
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: width * 0.1),
                          child: Text(
                            "Refrences:",
                            style: AppTextStyles.formalTextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium!
                                  .color!,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width * 0.1),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 7,
                                  width: 7,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.buttonColor),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    try {
                                      await launchUrl(Uri.parse(
                                          "https://fdc.nal.usda.gov/"));
                                    } catch (e) {
                                      log(e.toString());
                                    }
                                  },
                                  child: const Text(
                                    "Link",
                                    style: TextStyle(
                                        fontSize: 11,
                                        decoration: TextDecoration.underline,
                                        fontFamily: AppTextStyles.fontFamily),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 7,
                                  width: 7,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.buttonColor),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    try {
                                      await launchUrl(Uri.parse(
                                          "https://www.nal.usda.gov/human-nutrition-and-food-safety/dri-calculator"));
                                    } catch (e) {
                                      log(e.toString());
                                    }
                                  },
                                  child: const Text(
                                    "Link",
                                    style: TextStyle(
                                        fontSize: 11,
                                        decoration: TextDecoration.underline,
                                        fontFamily: AppTextStyles.fontFamily),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      CustomButtonWidget(
                          height: height * 0.05,
                          width: width * 0.4,
                          text: AppTexts.addMeal,
                          onPressed: () {
                            controller.addReplacedFood(
                              planFoodId: planFoodId,
                              planId: planId,
                              recipeDetialData: recipeDetialData,
                            );
                          }),
                      SizedBox(
                        height: height * 0.02,
                      ),
                    ],
                  ),
                ),
              ),
              controller.isLoading.value
                  ? const OverlayWidget()
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
