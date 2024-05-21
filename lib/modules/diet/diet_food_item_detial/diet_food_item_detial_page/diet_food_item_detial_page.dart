import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/diet/diet_food_item_detial/controller/diet_food_item_detial_controller.dart';
import 'package:weight_loss_app/modules/recipe/add_recipe/widgets/add_recipe_circular.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

class DietFoodItemDetialPage extends GetView<DietFoodItemDetialController> {
  const DietFoodItemDetialPage({super.key});

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
        // actions: [
        //   Padding(
        //     padding: EdgeInsets.only(right: width * 0.03),
        //     child: const Icon(
        //       Icons.bookmark,
        //       color: AppColors.iconRecipeColor,
        //     ),
        //   )
        // ],
      ),
      body: InternetCheckWidget<ConnectivityService>(
        child: Obx(
          () => Stack(
            children: [
              SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.18,
                        width: width,
                        child: controller.dietPlanDetialModel!.fileName == null
                            ? Image.asset(
                                AppAssets.dietRecipeImgUrl,
                                fit: BoxFit.fill,
                              )
                            : S3LoadingImage(
                                imageUrl:
                                    "${ApiUrls.s3ImageBaseUrl}Diet/${controller.dietPlanDetialModel!.fileName!}",
                                fit: BoxFit.cover),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      SizedBox(
                        width: width * 0.9,
                        height: height * 0.028,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  controller.dietPlanDetialModel!.name!,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .titleMedium!
                                        .color!,
                                    fontSize: 19,
                                    fontFamily: AppTextStyles.fontFamily,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    AppTexts.cookingTimeText,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .titleMedium!
                                          .color!,
                                      fontSize: 9,
                                      fontFamily: AppTextStyles.fontFamily,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    " ${AppTexts.thirtyMinutesText}",
                                    style: TextStyle(
                                      color: AppColors.buttonColor,
                                      fontSize: 9,
                                      fontFamily: AppTextStyles.fontFamily,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
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
                            "Serves: ${controller.dietPlanDetialModel!.servingSize}",
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
                              fontWeight: FontWeight.w400,
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
                                carbs: controller.dietPlanDetialModel!.carbs!,
                                fat: controller.dietPlanDetialModel!.fat!,
                                protien:
                                    controller.dietPlanDetialModel!.protein!,
                                fatColor: const Color(0xffF36124),
                                carbColor: AppColors.lightBlueChartColor,
                                protienColor: const Color(0xff8665FD),
                                calories:
                                    controller.dietPlanDetialModel!.calories!,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.15,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularPercentIndicator(
                                    center: Text(
                                        "${controller.dietPlanDetialModel!.carbs}g",
                                        style: AppTextStyles.formalTextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .titleMedium!
                                              .color!,
                                        )),
                                    radius: height * 0.039,
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
                                    center: Text(
                                        "${controller.dietPlanDetialModel!.protein}g",
                                        style: AppTextStyles.formalTextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .titleMedium!
                                              .color!,
                                        )),
                                    radius: height * 0.039,
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
                                    center: Text(
                                        "${controller.dietPlanDetialModel!.fat}g",
                                        style: AppTextStyles.formalTextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .titleMedium!
                                              .color!,
                                        )),
                                    radius: height * 0.039,
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
                      controller.isLoading.value
                          ? Center(
                              child: CircularProgressIndicator(
                                color: AppColors.buttonColor,
                              ),
                            )
                          : Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: width * 0.1),
                                    child: Text(
                                      "Ingredients ",
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
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.1),
                                    child: controller.foodItemDetailModel.value
                                                .foodDetailVM ==
                                            null
                                        ? const SizedBox()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: controller
                                                .foodItemDetailModel
                                                .value
                                                .foodDetailVM!
                                                .ingredients!
                                                .map(
                                                  (e) => Padding(
                                                    padding: EdgeInsets.only(
                                                        top: height * 0.01),
                                                    child: Text(
                                                      e,
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
                                    padding: EdgeInsets.only(left: width * 0.1),
                                    child: Text(
                                      "How to cook",
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
                                      padding:
                                          EdgeInsets.only(top: height * 0.01),
                                      child: controller.foodItemDetailModel
                                                  .value.foodDetailVM ==
                                              null
                                          ? const SizedBox()
                                          : Html(
                                              data: controller
                                                  .foodItemDetailModel
                                                  .value
                                                  .foodDetailVM!
                                                  .procedure!,
                                              style: {
                                                'body': Style(
                                                  // textAlign: TextAlign.justify,
                                                  fontFamily:
                                                      AppTextStyles.fontFamily,
                                                  color: Theme.of(context)
                                                      .primaryTextTheme
                                                      .titleMedium!
                                                      .color!,
                                                  fontSize: FontSize(11),
                                                ),
                                              },
                                            ),
                                    ),
                                    // )
                                    // .toList(),
                                    // ),
                                  ),
                                ),

                                // CustomButtonWidget(
                                //   height: height * 0.05,
                                //   width: width * 0.4,
                                //   text: AppTexts.addMeal,
                                //   onPressed: () {
                                //     showDialog(
                                //       context: context,
                                //       builder: (context) {
                                //         return Dialog(
                                //             child: Container(
                                //           height: height * 0.24,
                                //           width: width * 0.8,
                                //           decoration: BoxDecoration(
                                //             color: AppColors.white,
                                //             borderRadius:
                                //                 BorderRadius.circular(6),
                                //           ),
                                //           child: Center(
                                //             child: Column(
                                //               mainAxisAlignment:
                                //                   MainAxisAlignment.spaceAround,
                                //               children: [
                                //                 Text(
                                //                   AppTexts.addToMyFoodListText,
                                //                   style: AppTextStyles
                                //                       .formalTextStyle(
                                //                     fontSize: 15,
                                //                   ),
                                //                 ),
                                //                 Row(
                                //                   mainAxisAlignment:
                                //                       MainAxisAlignment
                                //                           .spaceEvenly,
                                //                   children: [
                                //                     Obx(
                                //                       () => Container(
                                //                         height: height * 0.05,
                                //                         width: width * 0.29,
                                //                         decoration:
                                //                             ShapeDecoration(
                                //                           color: Colors.white,
                                //                           shape: RoundedRectangleBorder(
                                //                               borderRadius:
                                //                                   BorderRadius
                                //                                       .circular(
                                //                                           6)),
                                //                           shadows: const [
                                //                             BoxShadow(
                                //                               color: Color(
                                //                                   0x3F000000),
                                //                               blurRadius: 4,
                                //                               offset:
                                //                                   Offset(0, 0),
                                //                               spreadRadius: 0,
                                //                             )
                                //                           ],
                                //                         ),
                                //                         child: DropdownButton<
                                //                             String>(
                                //                           value: controller
                                //                               .foodSelectedItem
                                //                               .value,
                                //                           isExpanded: true,
                                //                           underline:
                                //                               const SizedBox(),
                                //                           borderRadius:
                                //                               BorderRadius
                                //                                   .circular(10),
                                //                           onChanged:
                                //                               (newValue) {
                                //                             controller
                                //                                 .foodSelectedItem
                                //                                 .value = newValue!;
                                //                           },
                                //                           items: controller
                                //                               .foodMenuItems
                                //                               .map<
                                //                                   DropdownMenuItem<
                                //                                       String>>(
                                //                             (String value) {
                                //                               return DropdownMenuItem<
                                //                                   String>(
                                //                                 value: value,
                                //                                 child: Padding(
                                //                                   padding: EdgeInsets.symmetric(
                                //                                       horizontal:
                                //                                           width *
                                //                                               0.02),
                                //                                   child:
                                //                                       AutoSizeText(
                                //                                     value,
                                //                                     minFontSize:
                                //                                         10,
                                //                                     style: AppTextStyles
                                //                                         .formalTextStyle(),
                                //                                   ),
                                //                                 ),
                                //                               );
                                //                             },
                                //                           ).toList(),
                                //                         ),
                                //                       ),
                                //                     ),
                                //                     Obx(
                                //                       () => Container(
                                //                         height: height * 0.05,
                                //                         width: width * 0.27,
                                //                         decoration:
                                //                             ShapeDecoration(
                                //                           color: Colors.white,
                                //                           shape: RoundedRectangleBorder(
                                //                               borderRadius:
                                //                                   BorderRadius
                                //                                       .circular(
                                //                                           6)),
                                //                           shadows: const [
                                //                             BoxShadow(
                                //                               color: Color(
                                //                                   0x3F000000),
                                //                               blurRadius: 4,
                                //                               offset:
                                //                                   Offset(0, 0),
                                //                               spreadRadius: 0,
                                //                             )
                                //                           ],
                                //                         ),
                                //                         child: DropdownButton<
                                //                             String>(
                                //                           value: controller
                                //                               .daySelectedItem
                                //                               .value,
                                //                           isExpanded: true,
                                //                           underline:
                                //                               const SizedBox(),
                                //                           borderRadius:
                                //                               BorderRadius
                                //                                   .circular(10),
                                //                           onChanged:
                                //                               (newValue) {
                                //                             controller
                                //                                 .daySelectedItem
                                //                                 .value = newValue!;
                                //                           },
                                //                           items: controller
                                //                               .dayMenuItems
                                //                               .map<
                                //                                   DropdownMenuItem<
                                //                                       String>>((String
                                //                                   value) {
                                //                             return DropdownMenuItem<
                                //                                 String>(
                                //                               value: value,
                                //                               child: Padding(
                                //                                 padding: EdgeInsets
                                //                                     .symmetric(
                                //                                         horizontal:
                                //                                             width *
                                //                                                 0.02),
                                //                                 child: Text(
                                //                                   value,
                                //                                   style: AppTextStyles
                                //                                       .formalTextStyle(),
                                //                                 ),
                                //                               ),
                                //                             );
                                //                           }).toList(),
                                //                         ),
                                //                       ),
                                //                     ),
                                //                   ],
                                //                 ),
                                //                 CustomButtonWidget(
                                //                   height: height * 0.04,
                                //                   width: width * 0.25,
                                //                   text: 'Add',
                                //                   onPressed: () {
                                //                     Navigator.pop(context);
                                //                     controller.addMeal(
                                //                       mealType: controller
                                //                           .foodSelectedItem
                                //                           .value,
                                //                       foodId: controller
                                //                           .dietPlanDetialModel!
                                //                           .foodId!,
                                //                       planId: controller
                                //                           .dietPlanDetialModel!
                                //                           .planId!,
                                //                       day: int.tryParse(controller
                                //                               .daySelectedItem
                                //                               .replaceAll(
                                //                                   RegExp(
                                //                                       r'[^0-9]'),
                                //                                   '')) ??
                                //                           0,
                                //                     );
                                //                     // Navigator.pop(context);
                                //                   },
                                //                 )
                                //               ],
                                //             ),
                                //           ),
                                //         ));
                                //       },
                                //     );
                                //   },
                                // ),
                              ],
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
                        height: height * 0.02,
                      ),
                    ],
                  ),
                ),
              ),
              controller.isAddFoodLoading.value
                  ? const OverlayWidget()
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
