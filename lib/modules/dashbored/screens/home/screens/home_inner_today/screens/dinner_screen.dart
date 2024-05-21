import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/controller/home_controller.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_today/controller/home_inner_today_controller.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_today/models/today_diet_model.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_today/widgets/home_food_item_detial.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_today/widgets/replace_dialog_widget.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/widgets/float_water_dialog.dart';
import 'package:weight_loss_app/modules/dashbored/screens/scanner/view/scanner_view.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

import '../../../../../../../common/app_colors.dart';
import '../../../../../../../common/app_text_styles.dart';
import '../widgets/food_item.dart';

class DinnerScreen extends StatefulWidget {
  const DinnerScreen({super.key, required this.getTodayDietDinnerList});
  final List<ActiveFoodPlanVM> getTodayDietDinnerList;

  @override
  State<DinnerScreen> createState() => _DinnerScreenState();
}

class _DinnerScreenState extends State<DinnerScreen> {
  final controller = Get.find<HomeInnerTodayController>();
  List<ActiveFoodPlanVM> suggessionFoodsList = [];
  @override
  void initState() {
    getSuggessionApiData();
    super.initState();
  }

  void getSuggessionApiData() async {
    suggessionFoodsList =
        await controller.dietFoodSuggession(mealType: "Dinner");
    if (mounted) {
      setState(() {});
    }
  }

  bool isAnyFoodTaken() {
    var mergedlist = <ActiveFoodPlanVM>[];
    mergedlist.addAll(widget.getTodayDietDinnerList);
    mergedlist.addAll(suggessionFoodsList);
    return mergedlist.any((element) => element.isTaken == true);
  }

  bool isAllItemTaken = false;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var height = screenSize.height;
    var width = screenSize.width;

    return widget.getTodayDietDinnerList.isEmpty
        ? Center(
            child: Text(
            "No Dinner Food Avialable",
            style: AppTextStyles.formalTextStyle(),
          ))
        : Container(
            padding: EdgeInsets.symmetric(vertical: height * 0.015),
            margin: EdgeInsets.symmetric(horizontal: width * 0.01),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: height * 0.15,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: FoodItemLeft(
                          width: width * 0.4,
                          imageTap: !controller.hasInternet.value
                              ? () {}
                              : () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HomeFoodItemDetial(
                                                activeFoodPlanVM: widget
                                                    .getTodayDietDinnerList[0],
                                              )));
                                },
                          calories: widget.getTodayDietDinnerList[0].calories
                              .toString(),
                          foodName: "${widget.getTodayDietDinnerList[0].name}",
                          custom:
                              widget.getTodayDietDinnerList[0].custom ?? "food",
                          imageUrl: widget.getTodayDietDinnerList[0].foodImage,
                          istaken: widget.getTodayDietDinnerList[0].isTaken!,
                          add: isAnyFoodTaken()
                              ? () {}
                              : () {
                                  controller.saveUserTodayDiet(context,
                                      todayDietModel:
                                          widget.getTodayDietDinnerList[0],
                                      mealType: "dinner");
                                },
                          replace: isAnyFoodTaken()
                              ? () {}
                              : () async {
                                  try {
                                    List<ActiveFoodPlanVM> replecedItem =
                                        await controller.replaceDiet(
                                      context,
                                      phaseId: widget
                                          .getTodayDietDinnerList[0].phase!,
                                      mealType: widget
                                          .getTodayDietDinnerList[0].mealType!,
                                    );
                                    await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ReplaceDialogWidget(
                                          replecedItemsList: replecedItem,
                                          homeInnerTodayController: controller,
                                          planId: widget
                                              .getTodayDietDinnerList[0]
                                              .planId!,
                                          replecedItemId: widget
                                              .getTodayDietDinnerList[0]
                                              .foodId!,
                                          mealType: "Dinner",
                                        );
                                      },
                                    );
                                  } catch (e) {
                                    customSnackbar(
                                        title: AppTexts.error,
                                        message: e.toString());
                                  }
                                },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.buttonColor,
                                ),
                              ),
                            ),
                            Container(
                              height: height * 0.12,
                              width: 1,
                              color: AppColors.buttonColor,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: suggessionFoodsList.isEmpty
                            ? const SizedBox()
                            : FoodItemRight(
                                width: width * 0.4,
                                imageTap: !controller.hasInternet.value
                                    ? () {}
                                    : () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeFoodItemDetial(
                                                      activeFoodPlanVM:
                                                          suggessionFoodsList[
                                                              0],
                                                    )));
                                      },
                                calories:
                                    suggessionFoodsList[0].calories.toString(),
                                foodName: "${suggessionFoodsList[0].name}",
                                custom: suggessionFoodsList[0].custom ?? "food",
                                imageUrl: suggessionFoodsList[0].foodImage,
                                istaken: suggessionFoodsList[0].isTaken!,
                                add: isAnyFoodTaken()
                                    ? () {}
                                    : () {
                                        controller.saveUserTodayDiet(context,
                                            todayDietModel:
                                                suggessionFoodsList[0],
                                            mealType: "dinner");
                                      },
                                replace: isAnyFoodTaken()
                                    ? () {}
                                    : () async {
                                        try {
                                          List<ActiveFoodPlanVM> replecedItem =
                                              await controller.replaceDiet(
                                            context,
                                            phaseId:
                                                suggessionFoodsList[0].phase!,
                                            mealType: suggessionFoodsList[0]
                                                .mealType!,
                                          );
                                          await showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return ReplaceDialogWidget(
                                                replecedItemsList: replecedItem,
                                                homeInnerTodayController:
                                                    controller,
                                                planId: suggessionFoodsList[0]
                                                    .planId!,
                                                replecedItemId:
                                                    suggessionFoodsList[0]
                                                        .foodId!,
                                                mealType: "Dinner",
                                              );
                                            },
                                          );
                                        } catch (e) {
                                          customSnackbar(
                                              title: AppTexts.error,
                                              message: e.toString());
                                        }
                                      },
                              ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(
                      () => ScannerPage(),
                    );
                  },
                  child: Text(
                    "Scan food",
                    style: AppTextStyles.formalTextStyle(
                      color: AppColors.buttonColor,
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 5,
                        child: suggessionFoodsList.isEmpty ||
                                suggessionFoodsList.length < 2
                            ? const SizedBox()
                            : FoodItemLeft(
                                width: width * 0.4,
                                imageTap: !controller.hasInternet.value
                                    ? () {}
                                    : () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeFoodItemDetial(
                                                      activeFoodPlanVM:
                                                          suggessionFoodsList[
                                                              1],
                                                    )));
                                      },
                                calories:
                                    suggessionFoodsList[1].calories.toString(),
                                foodName: "${suggessionFoodsList[1].name}",
                                custom: suggessionFoodsList[1].custom ?? "food",
                                imageUrl: suggessionFoodsList[1].foodImage,
                                istaken: suggessionFoodsList[1].isTaken!,
                                add: isAnyFoodTaken()
                                    ? () {}
                                    : () {
                                        controller.saveUserTodayDiet(context,
                                            todayDietModel:
                                                suggessionFoodsList[1],
                                            mealType: "dinner");
                                      },
                                replace: isAnyFoodTaken()
                                    ? () {}
                                    : () async {
                                        try {
                                          List<ActiveFoodPlanVM> replecedItem =
                                              await controller.replaceDiet(
                                            context,
                                            phaseId:
                                                suggessionFoodsList[1].phase!,
                                            mealType: suggessionFoodsList[1]
                                                .mealType!,
                                          );
                                          await showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return ReplaceDialogWidget(
                                                replecedItemsList: replecedItem,
                                                homeInnerTodayController:
                                                    controller,
                                                planId: suggessionFoodsList[1]
                                                    .planId!,
                                                replecedItemId:
                                                    suggessionFoodsList[1]
                                                        .foodId!,
                                                mealType: "Dinner",
                                              );
                                            },
                                          );
                                        } catch (e) {
                                          customSnackbar(
                                              title: AppTexts.error,
                                              message: e.toString());
                                        }
                                      },
                              ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: height * 0.12,
                              width: 1,
                              color: AppColors.buttonColor,
                            ),
                            Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.buttonColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: widget.getTodayDietDinnerList.length < 2
                            ? PlanWater(
                                imageTap: () {
                                  var homeCont = Get.find<HomeController>();
                                  waterIntakeDialog(context, homeCont);
                                },
                                width: width * 0.4,
                                imageUrl: AppAssets.glassofwaterImgUrl,
                              )
                            : FoodItemRight(
                                width: width * 0.4,
                                imageTap: !controller.hasInternet.value
                                    ? () {}
                                    : () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeFoodItemDetial(
                                                      activeFoodPlanVM: widget
                                                          .getTodayDietDinnerList[1],
                                                    )));
                                      },
                                calories: widget
                                    .getTodayDietDinnerList[1].calories
                                    .toString(),
                                foodName:
                                    "${widget.getTodayDietDinnerList[1].name}",
                                custom:
                                    widget.getTodayDietDinnerList[1].custom ??
                                        "food",
                                imageUrl:
                                    widget.getTodayDietDinnerList[1].foodImage,
                                istaken:
                                    widget.getTodayDietDinnerList[1].isTaken!,
                                add: isAnyFoodTaken()
                                    ? () {}
                                    : () {
                                        controller.saveUserTodayDiet(context,
                                            todayDietModel: widget
                                                .getTodayDietDinnerList[1],
                                            mealType: "dinner");
                                      },
                                replace: isAnyFoodTaken()
                                    ? () {}
                                    : () async {
                                        try {
                                          List<ActiveFoodPlanVM>
                                              replecedItemsList =
                                              await controller.replaceDiet(
                                            context,
                                            phaseId: widget
                                                .getTodayDietDinnerList[1]
                                                .phase!,
                                            mealType: widget
                                                .getTodayDietDinnerList[1]
                                                .mealType!,
                                          );
                                          await showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return ReplaceDialogWidget(
                                                replecedItemsList:
                                                    replecedItemsList,
                                                homeInnerTodayController:
                                                    controller,
                                                planId: widget
                                                    .getTodayDietDinnerList[1]
                                                    .planId!,
                                                replecedItemId: widget
                                                    .getTodayDietDinnerList[1]
                                                    .foodId!,
                                                mealType: "Dinner",
                                              );
                                            },
                                          );
                                        } catch (e) {
                                          customSnackbar(
                                              title: AppTexts.error,
                                              message: e.toString());
                                        }
                                      },
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  Future<void> waterIntakeDialog(
      BuildContext context, HomeController homeCont) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return FloatWaterIntakeDialog(
          controller: homeCont,
        );
      },
    );
  }
}
