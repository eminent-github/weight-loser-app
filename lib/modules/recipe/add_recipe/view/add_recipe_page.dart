import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:weight_loss_app/modules/recipe/search_ingredient/model/search_ingredients_model.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_button_widget.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';
import '../controller/add_recipe_controller.dart';
import '../widgets/add_recipe_circular.dart';

class AddRecipePage extends GetView<AddRecipeController> {
  const AddRecipePage({
    super.key,
    required this.recipeName,
    required this.servingSize,
    required this.ingredients,
  });
  final String recipeName;
  final int servingSize;
  final List<SearchIngredientsModel> ingredients;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double carbs = ingredients.fold(
        0, (previousValue, element) => previousValue + element.carbs!);
    double protien = ingredients.fold(
        0, (previousValue, element) => previousValue + element.protein!);
    double fat = ingredients.fold(
        0, (previousValue, element) => previousValue + element.fat!);
    int calories = ingredients.fold(
        0, (previousValue, element) => previousValue + element.calories!);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppTexts.addRecipe,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
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
                        height: height * 0.05,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.075),
                          child: const Text(
                            "Recipe Name",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Material(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(5),
                        elevation: 3,
                        child: SizedBox(
                          height: height * 0.075,
                          width: width * 0.85,
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.05),
                            child: Row(
                              children: [
                                Text(
                                  recipeName,
                                  style: AppTextStyles.formalTextStyle(
                                    color: AppColors.buttonColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Material(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(5),
                        elevation: 3,
                        child: SizedBox(
                          height: height * 0.075,
                          width: width * 0.85,
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(AppTexts.numberOfServing),
                                Text(
                                  servingSize.toString(),
                                  style: AppTextStyles.formalTextStyle(
                                    color: AppColors.buttonColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.075),
                          child: const Text(
                            "Ingredients",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.008,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: width * 0.075),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: ingredients
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Material(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    elevation: 3,
                                    child: ListTile(
                                      title: Text(
                                        e.name!,
                                        style: AppTextStyles.formalTextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      subtitle: Text(
                                        '${e.calories} cal،${e.servingSize} Serving',
                                        style: const TextStyle(
                                            fontFamily:
                                                AppTextStyles.fontFamily,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.subtitleColor),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
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
                                carbs: carbs,
                                fat: fat,
                                protien: protien,
                                fatColor: const Color(0xffF36124),
                                carbColor: AppColors.lightBlueChartColor,
                                protienColor: const Color(0xff8665FD),
                                calories: calories,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.15,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularPercentIndicator(
                                    center: Text("${carbs.toPrecision(0)}g",
                                        style: AppTextStyles.formalTextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
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
                                    center: Text("${protien.toPrecision(0)}g",
                                        style: AppTextStyles.formalTextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
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
                                    center: Text("${fat.toPrecision(0)}g",
                                        style: AppTextStyles.formalTextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
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
                      SizedBox(
                        height: height * 0.05,
                      ),
                      CustomButtonWidget(
                        height: height * 0.06,
                        width: width * 0.45,
                        text: AppTexts.addRecipe,
                        onPressed: () {
                          // print("file name ${ingredients.first.fileName}");
                          controller.addRecipeApi(
                              calories: calories,
                              carbs: carbs,
                              protein: protien,
                              fat: fat,
                              // fileName: ingredients.first.fileName!,
                              numberOfServing: servingSize,
                              ingredients: json.encode(
                                  ingredients.map((e) => e.name).toList()),
                              recipeName: recipeName);
                        },
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
