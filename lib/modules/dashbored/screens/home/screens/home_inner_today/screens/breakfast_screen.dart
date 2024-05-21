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

class BreakFastScreen extends StatefulWidget {
  const BreakFastScreen({super.key, required this.getTodayDietBreakfastList});
  final List<ActiveFoodPlanVM> getTodayDietBreakfastList;

  @override
  State<BreakFastScreen> createState() => _BreakFastScreenState();
}

class _BreakFastScreenState extends State<BreakFastScreen> {
  final controller = Get.find<HomeInnerTodayController>();
  List<ActiveFoodPlanVM> suggessionFoodsList = [];
  @override
  void initState() {
    getSuggessionApiData();
    super.initState();
  }

  void getSuggessionApiData() async {
    suggessionFoodsList =
        await controller.dietFoodSuggession(mealType: "BreakFast");
    if (mounted) {
      setState(() {});
    }
  }

  bool isAnyFoodTaken() {
    var mergedlist = <ActiveFoodPlanVM>[];
    mergedlist.addAll(widget.getTodayDietBreakfastList);
    mergedlist.addAll(suggessionFoodsList);
    return mergedlist.any((element) => element.isTaken == true);
  }

  bool isAllItemTaken = false;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    var height = screenSize.height;
    var width = screenSize.width;

    return widget.getTodayDietBreakfastList.isEmpty
        ? Center(
            child: Text(
            "No Breakfast Food Avialable",
            style: AppTextStyles.formalTextStyle(
              color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
            ),
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
                                      builder: (context) => HomeFoodItemDetial(
                                        activeFoodPlanVM:
                                            widget.getTodayDietBreakfastList[0],
                                      ),
                                    ),
                                  );
                                },
                          calories: widget.getTodayDietBreakfastList[0].calories
                              .toString(),
                          foodName:
                              "${widget.getTodayDietBreakfastList[0].name}",
                          custom: widget.getTodayDietBreakfastList[0].custom ??
                              "food",
                          imageUrl:
                              widget.getTodayDietBreakfastList[0].foodImage,
                          istaken: widget.getTodayDietBreakfastList[0].isTaken!,
                          add: isAnyFoodTaken()
                              ? () {}
                              : () {
                                  controller.saveUserTodayDiet(context,
                                      todayDietModel:
                                          widget.getTodayDietBreakfastList[0],
                                      mealType: "breakfast");
                                },
                          replace: isAnyFoodTaken()
                              ? () {}
                              : () async {
                                  try {
                                    List<ActiveFoodPlanVM> replecedItemsList =
                                        await controller.replaceDiet(
                                      context,
                                      phaseId: widget
                                          .getTodayDietBreakfastList[0].phase!,
                                      mealType: widget
                                          .getTodayDietBreakfastList[0]
                                          .mealType!,
                                    );
                                    await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ReplaceDialogWidget(
                                          replecedItemsList: replecedItemsList,
                                          homeInnerTodayController: controller,
                                          planId: widget
                                              .getTodayDietBreakfastList[0]
                                              .planId!,
                                          replecedItemId: widget
                                              .getTodayDietBreakfastList[0]
                                              .foodId!,
                                          mealType: "BreakFast",
                                        );
                                      },
                                    );
                                    // print(repItem.name);
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
                                  calories: suggessionFoodsList[0]
                                      .calories
                                      .toString(),
                                  foodName: "${suggessionFoodsList[0].name}",
                                  custom:
                                      suggessionFoodsList[0].custom ?? "food",
                                  imageUrl: suggessionFoodsList[0].foodImage,
                                  istaken: suggessionFoodsList[0].isTaken!,
                                  add: isAnyFoodTaken()
                                      ? () {}
                                      : () {
                                          controller.saveUserTodayDiet(context,
                                              todayDietModel:
                                                  suggessionFoodsList[0],
                                              mealType: "breakfast");
                                        },
                                  replace: isAnyFoodTaken()
                                      ? () {}
                                      : () async {
                                          try {
                                            List<ActiveFoodPlanVM>
                                                replecedItem =
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
                                                  replecedItemsList:
                                                      replecedItem,
                                                  homeInnerTodayController:
                                                      controller,
                                                  planId: suggessionFoodsList[0]
                                                      .planId!,
                                                  replecedItemId:
                                                      suggessionFoodsList[0]
                                                          .foodId!,
                                                  mealType: "BreakFast",
                                                );
                                              },
                                            );
                                          } catch (e) {
                                            customSnackbar(
                                                title: AppTexts.error,
                                                message: e.toString());
                                          }
                                        },
                                )),
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
                                                  suggessionFoodsList[1],
                                            ),
                                          ),
                                        );
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
                                            mealType: "breakfast");
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
                                                mealType: "BreakFast",
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
                        child: widget.getTodayDietBreakfastList.length < 2
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
                                                          .getTodayDietBreakfastList[1],
                                                    )));
                                      },
                                calories: widget
                                    .getTodayDietBreakfastList[1].calories
                                    .toString(),
                                foodName:
                                    "${widget.getTodayDietBreakfastList[1].name}",
                                custom: widget
                                        .getTodayDietBreakfastList[1].custom ??
                                    "food",
                                imageUrl: widget
                                    .getTodayDietBreakfastList[1].foodImage,
                                istaken: widget
                                    .getTodayDietBreakfastList[1].isTaken!,
                                add: isAnyFoodTaken()
                                    ? () {}
                                    : () {
                                        controller.saveUserTodayDiet(context,
                                            todayDietModel: widget
                                                .getTodayDietBreakfastList[1],
                                            mealType: "breakfast");
                                      },
                                replace: isAnyFoodTaken()
                                    ? () {}
                                    : () async {
                                        try {
                                          List<ActiveFoodPlanVM> replecedItem =
                                              await controller.replaceDiet(
                                            context,
                                            phaseId: widget
                                                .getTodayDietBreakfastList[1]
                                                .phase!,
                                            mealType: widget
                                                .getTodayDietBreakfastList[1]
                                                .mealType!,
                                          );
                                          await showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return ReplaceDialogWidget(
                                                replecedItemsList: replecedItem,
                                                homeInnerTodayController:
                                                    controller,
                                                planId: widget
                                                    .getTodayDietBreakfastList[
                                                        1]
                                                    .planId!,
                                                replecedItemId: widget
                                                    .getTodayDietBreakfastList[
                                                        1]
                                                    .foodId!,
                                                mealType: "BreakFast",
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
