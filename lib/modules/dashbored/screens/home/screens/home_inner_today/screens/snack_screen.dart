import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

class SnackScreen extends StatefulWidget {
  const SnackScreen({super.key, required this.getTodayDietSnackList});
  final List<ActiveFoodPlanVM> getTodayDietSnackList;

  @override
  State<SnackScreen> createState() => _SnackScreenState();
}

class _SnackScreenState extends State<SnackScreen> {
  final controller = Get.find<HomeInnerTodayController>();
  List<ActiveFoodPlanVM> suggessionFoodsList = [];
  @override
  void initState() {
    getSuggessionApiData();
    super.initState();
  }

  void getSuggessionApiData() async {
    suggessionFoodsList =
        await controller.dietFoodSuggession(mealType: "Snacks");
    if (mounted) {
      setState(() {});
    }
  }

  bool isAnyFoodTaken() {
    var mergedlist = <ActiveFoodPlanVM>[];
    mergedlist.addAll(widget.getTodayDietSnackList);
    mergedlist.addAll(suggessionFoodsList);
    var jksdk = mergedlist.where((element) => element.isTaken == true).toList();
    return jksdk.length < 2 ? false : true;
  }

  bool isAllItemTaken = false;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var height = screenSize.height;
    var width = screenSize.width;

    return widget.getTodayDietSnackList.isEmpty
        ? Center(
            child: Text(
            "No Snack Food Avialable",
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                    .getTodayDietSnackList[0],
                                              )));
                                },
                          calories: widget.getTodayDietSnackList[0].calories
                              .toString(),
                          foodName: "${widget.getTodayDietSnackList[0].name}",
                          custom:
                              widget.getTodayDietSnackList[0].custom ?? "food",
                          imageUrl: widget.getTodayDietSnackList[0].foodImage,
                          istaken: widget.getTodayDietSnackList[0].isTaken!,
                          add: isAnyFoodTaken()
                              ? () {}
                              : () {
                                  controller.saveUserTodayDiet(context,
                                      todayDietModel:
                                          widget.getTodayDietSnackList[0],
                                      mealType: "snack");
                                },
                          replace: isAnyFoodTaken()
                              ? () {}
                              : () async {
                                  try {
                                    List<ActiveFoodPlanVM> replecedItemsList =
                                        await controller.replaceDiet(
                                      context,
                                      phaseId: widget
                                          .getTodayDietSnackList[0].phase!,
                                      mealType: widget
                                          .getTodayDietSnackList[0].mealType!,
                                    );
                                    await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ReplaceDialogWidget(
                                          replecedItemsList: replecedItemsList,
                                          homeInnerTodayController: controller,
                                          planId: widget
                                              .getTodayDietSnackList[0].planId!,
                                          replecedItemId: widget
                                              .getTodayDietSnackList[0].foodId!,
                                          mealType: "Snack",
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
                        child: widget.getTodayDietSnackList.length < 2
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
                                                      activeFoodPlanVM: widget
                                                          .getTodayDietSnackList[1],
                                                    )));
                                      },
                                calories: widget
                                    .getTodayDietSnackList[1].calories
                                    .toString(),
                                foodName:
                                    "${widget.getTodayDietSnackList[1].name}",
                                custom:
                                    widget.getTodayDietSnackList[1].custom ??
                                        "food",
                                imageUrl:
                                    widget.getTodayDietSnackList[1].foodImage,
                                istaken:
                                    widget.getTodayDietSnackList[1].isTaken!,
                                add: isAnyFoodTaken()
                                    ? () {}
                                    : () {
                                        controller.saveUserTodayDiet(context,
                                            todayDietModel:
                                                widget.getTodayDietSnackList[1],
                                            mealType: "snack");
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
                                                .getTodayDietSnackList[1]
                                                .phase!,
                                            mealType: widget
                                                .getTodayDietSnackList[1]
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
                                                    .getTodayDietSnackList[1]
                                                    .planId!,
                                                replecedItemId: widget
                                                    .getTodayDietSnackList[1]
                                                    .foodId!,
                                                mealType: "Snack",
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
                        child: suggessionFoodsList.isEmpty
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
                                            mealType: "snack");
                                      },
                                replace: isAnyFoodTaken()
                                    ? () {}
                                    : () async {
                                        try {
                                          List<ActiveFoodPlanVM>
                                              replecedItemsList =
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
                                                    replecedItemsList,
                                                homeInnerTodayController:
                                                    controller,
                                                planId: suggessionFoodsList[0]
                                                    .planId!,
                                                replecedItemId:
                                                    suggessionFoodsList[0]
                                                        .foodId!,
                                                mealType: "Snack",
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
                        child: suggessionFoodsList.isEmpty ||
                                suggessionFoodsList.length < 2
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
                                            mealType: "snack");
                                      },
                                replace: isAnyFoodTaken()
                                    ? () {}
                                    : () async {
                                        try {
                                          List<ActiveFoodPlanVM>
                                              replecedItemsList =
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
                                                replecedItemsList:
                                                    replecedItemsList,
                                                homeInnerTodayController:
                                                    controller,
                                                planId: suggessionFoodsList[1]
                                                    .planId!,
                                                replecedItemId:
                                                    suggessionFoodsList[1]
                                                        .foodId!,
                                                mealType: "Snack",
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
