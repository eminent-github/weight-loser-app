import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_today/models/today_diet_model.dart';
import 'package:weight_loss_app/modules/diet/diet_food_item_detial/model/diet_food_item_detail_model.dart';
import 'package:weight_loss_app/modules/recipe/add_recipe/widgets/add_recipe_circular.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';

class HomeFoodItemDetial extends StatefulWidget {
  const HomeFoodItemDetial({super.key, required this.activeFoodPlanVM});
  final ActiveFoodPlanVM activeFoodPlanVM;

  @override
  State<HomeFoodItemDetial> createState() => _HomeFoodItemDetialState();
}

class _HomeFoodItemDetialState extends State<HomeFoodItemDetial> {
  final ApiService apiService = ApiService();

  Future<FoodItemDetailModel> getFoodDetail(String foodId) async {
    log("foodId:$foodId");

    String? token = await StorageServivce.getToken();
    var response = await apiService.get(
      "${ApiUrls.foodDetailEndPoint}/$foodId",
      authToken: token,
    );
    log("status code: ${response.statusCode} body : ${response.body}");
    if (response.statusCode == 200) {
      var dataObj = await jsonDecode(response.body);
      return FoodItemDetailModel.fromJson(dataObj);
    } else {
      throw Exception('Failed to load data');
    }
  }

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
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.18,
                  width: width,
                  child: widget.activeFoodPlanVM.foodImage == null
                      ? Image.asset(AppAssets.dietImgUrl, fit: BoxFit.cover)
                      : widget.activeFoodPlanVM.custom == "custom"
                          ? LoadingImage(
                              imageUrl: widget.activeFoodPlanVM.foodImage!,
                              fit: BoxFit.cover,
                            )
                          : widget.activeFoodPlanVM.custom == "scanner"
                              ? S3LoadingImage(
                                  imageUrl: widget.activeFoodPlanVM.foodImage!,
                                  fit: BoxFit.cover,
                                )
                              : S3LoadingImage(
                                  imageUrl:
                                      "${ApiUrls.s3ImageBaseUrl}Diet/${widget.activeFoodPlanVM.foodImage}",
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
                            widget.activeFoodPlanVM.name!,
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
                      "Serves: ${widget.activeFoodPlanVM.servingSize}",
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
                          carbs: widget.activeFoodPlanVM.carbs!,
                          fat: widget.activeFoodPlanVM.fat!,
                          protien: widget.activeFoodPlanVM.protein!,
                          fatColor: const Color(0xffF36124),
                          carbColor: AppColors.lightBlueChartColor,
                          protienColor: const Color(0xff8665FD),
                          calories: widget.activeFoodPlanVM.calories!,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.15,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularPercentIndicator(
                              center: Text("${widget.activeFoodPlanVM.carbs}g",
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
                                fontWeight: FontWeight.w400,
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
                              center:
                                  Text("${widget.activeFoodPlanVM.protein}g",
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
                                  fontWeight: FontWeight.w400,
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
                              center: Text("${widget.activeFoodPlanVM.fat}g",
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
                                  fontWeight: FontWeight.w400,
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
                  future: getFoodDetail(widget.activeFoodPlanVM.foodId!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text(
                        'No Ingredients Found',
                        style: AppTextStyles.formalTextStyle(),
                      ));
                    } else {
                      FoodItemDetailModel foodItemDetailModel = snapshot.data!;
                      return foodItemDetailModel.foodDetailVM == null
                          ? const SizedBox()
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
                                    child: foodItemDetailModel
                                                .foodDetailVM!.ingredients ==
                                            null
                                        ? const SizedBox()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: foodItemDetailModel
                                                .foodDetailVM!.ingredients!
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
                                      child: foodItemDetailModel
                                                  .foodDetailVM!.procedure ==
                                              null
                                          ? const SizedBox()
                                          : Html(
                                              data: foodItemDetailModel
                                                  .foodDetailVM!.procedure!,
                                              style: {
                                                'body': Style(
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
                                await launchUrl(
                                    Uri.parse("https://fdc.nal.usda.gov/"));
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
      ),
    );
  }
}
