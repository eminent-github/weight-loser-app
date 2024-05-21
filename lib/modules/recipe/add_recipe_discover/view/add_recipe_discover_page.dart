import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/modules/diet/diet_food_item_detial/model/diet_food_item_detail_model.dart';
import 'package:weight_loss_app/modules/recipe/add_recipe_discover/model/recipe_detial_model.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_button_widget.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

import '../../../../common/app_assets.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';
import '../../add_recipe/widgets/add_recipe_circular.dart';
import '../controller/add_recipe_discover_controller.dart';

class AddRecipeDiscoverPage extends GetView<AddRecipeDiscoverController> {
  const AddRecipeDiscoverPage({
    super.key,
    required this.recipeDetialData,
    required this.mealType,
  });
  final RecipeDetialModel recipeDetialData;
  final String mealType;

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
          AppTexts.recipeText,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
        // actions: [
        //   InkWell(
        //     onTap: recipeDetialData.isFavourite
        //         ? () {
        //             customSnackbar(
        //                 title: AppTexts.alert, message: "Already Favourite");
        //           }
        //         : () {
        //             controller.addFavouriteFood(
        //               planId: recipeDetialData.planId,
        //               id: int.parse(recipeDetialData.foodId),
        //             );
        //           },
        //     child: Padding(
        //       padding: EdgeInsets.only(right: width * 0.03),
        //       child: Icon(
        //         recipeDetialData.isFavourite
        //             ? Icons.bookmark_added_rounded
        //             : Icons.bookmark_border_outlined,
        //         color: AppColors.abstractionTextColor,
        //       ),
        //     ),
        //   )
        // ],
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
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .titleMedium!
                                        .color!,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600,
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
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .titleMedium!
                                            .color!,
                                        fontSize: 9,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' 30 Minutes',
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
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .titleMedium!
                                              .color!,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        )),
                                    radius: height * 0.039,
                                    lineWidth: 5.5,
                                    restartAnimation: true,
                                    animationDuration: 1,
                                    animation: true,
                                    percent: recipeDetialData.carbs / 100,
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
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .titleMedium!
                                          .color!,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
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
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .titleMedium!
                                              .color!,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        )),
                                    radius: height * 0.039,
                                    lineWidth: 5.5,
                                    restartAnimation: true,
                                    animationDuration: 1,
                                    animation: true,
                                    percent: recipeDetialData.protein / 100,
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
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .titleMedium!
                                            .color!,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
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
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .titleMedium!
                                              .color!,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        )),
                                    radius: height * 0.039,
                                    lineWidth: 5.5,
                                    restartAnimation: true,
                                    animationDuration: 1,
                                    animation: true,
                                    percent: recipeDetialData.fat / 100,
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
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .titleMedium!
                                            .color!,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
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
                            return Center(
                                child: Text(
                              'Loading...',
                              style: AppTextStyles.formalTextStyle(
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .titleMedium!
                                    .color!,
                              ),
                            ));
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text(
                              'No Ingredients Found',
                              style: AppTextStyles.formalTextStyle(
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .titleMedium!
                                    .color!,
                              ),
                            ));
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
                                              color: Theme.of(context)
                                                  .primaryTextTheme
                                                  .titleMedium!
                                                  .color!,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
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
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryTextTheme
                                                                  .titleMedium!
                                                                  .color!,
                                                              fontSize: 11,
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
                                              color: Theme.of(context)
                                                  .primaryTextTheme
                                                  .titleMedium!
                                                  .color!,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
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
                                                      color: Theme.of(context)
                                                          .primaryTextTheme
                                                          .titleMedium!
                                                          .color!,
                                                      fontSize: 11,
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
                          controller.foodSelectedItem.value = mealType;
                          // print(
                          //     "selected : ${controller.foodSelectedItem.value} meal : $mealType");
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                  child: Container(
                                height: height * 0.24,
                                width: width * 0.8,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        AppTexts.addToMyFoodListText,
                                        style: AppTextStyles.formalTextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Obx(
                                            () => Container(
                                              height: height * 0.05,
                                              width: width * 0.29,
                                              decoration: ShapeDecoration(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                shadows: const [
                                                  BoxShadow(
                                                    color: Color(0x3F000000),
                                                    blurRadius: 4,
                                                    offset: Offset(0, 0),
                                                    spreadRadius: 0,
                                                  )
                                                ],
                                              ),
                                              child: DropdownButton<String>(
                                                value: controller
                                                    .foodSelectedItem.value,
                                                isExpanded: true,
                                                underline: const SizedBox(),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                onChanged: (newValue) {
                                                  controller.foodSelectedItem
                                                      .value = newValue!;
                                                },
                                                items: controller.foodMenuItems
                                                    .map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                  (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    width *
                                                                        0.02),
                                                        child: AutoSizeText(
                                                          value,
                                                          minFontSize: 10,
                                                          style: AppTextStyles
                                                              .formalTextStyle(),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).toList(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      CustomButtonWidget(
                                        height: height * 0.04,
                                        width: width * 0.25,
                                        text: 'Add',
                                        onPressed: () {
                                          Navigator.pop(context);
                                          controller.saveUserTodayDiet(
                                            todayDietModel: recipeDetialData,
                                            foodId: recipeDetialData.foodId,
                                            mealType: controller
                                                .foodSelectedItem.value,
                                          );
                                          // Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ));
                            },
                          );
                        },
                      ),
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
