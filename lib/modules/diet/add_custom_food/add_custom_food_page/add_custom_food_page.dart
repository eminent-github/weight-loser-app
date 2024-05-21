import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/diet/add_custom_food/controller/add_custom_food_controller.dart';
import 'package:weight_loss_app/modules/diet/add_custom_food/widgets/custom_food_text_field.dart';
import 'package:weight_loss_app/modules/diet/add_your_food/model/rep_food_route_model.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_large_button.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

class AddCustomFoodPage extends GetView<AddCustomFoodController> {
  const AddCustomFoodPage({
    super.key,
    required this.mealType,
    required this.replaceFoodRouteModel,
  });
  final String mealType;
  final ReplaceFoodRouteModel replaceFoodRouteModel;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height-kToolbarHeight;
    double width = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        title: Text(
          "Add Your Food",
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
                        height: height * 0.015,
                      ),
                      InkWell(
                        onTap: () async {
                          await controller.pickImage(context);
                        },
                        borderRadius: BorderRadius.circular(100),
                        child: controller.updatedImage.value.isNotEmpty
                            ? Container(
                                height: height * 0.18,
                                width: width * 0.35,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: const Color(0xffAFD3E2),
                                  ),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: FileImage(
                                          File(controller.updatedImage.value)),
                                      fit: BoxFit.cover),
                                ),
                              )
                            : Container(
                                height: height * 0.18,
                                width: width * 0.35,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: const Color(0xffAFD3E2),
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Container(
                                    height: height * 0.13,
                                    width: width * 0.25,
                                    decoration: const BoxDecoration(
                                      color: Color(0xffAFD3E2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.add_a_photo_rounded,
                                        size: 35,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Food Name',
                              style: AppTextStyles.formalTextStyle(
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .titleMedium!
                                    .color!,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            CustomFoodTextField(
                              controller: controller.foodNameController,
                              labelText: "Name",
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^[a-zA-Z ]+$'),
                                ),

                                FilteringTextInputFormatter.deny(
                                    RegExp(r'^\s')), // Deny leading space
                              ],
                            ),
                            SizedBox(
                              height: height * 0.035,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: height * 0.07,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: AppColors.editProfileFieldColor,
                                    ),
                                    padding: EdgeInsets.only(
                                      left: width * 0.05,
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      mealType,
                                      style: AppTextStyles.formalTextStyle(),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.03,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: CustomFoodTextField(
                                    controller: controller.foodFatController,
                                    labelText: "Fats",
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    // suffixText: "Fat",
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.035,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Food Calories',
                                        style: AppTextStyles.formalTextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .titleMedium!
                                              .color!,
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      CustomFoodTextField(
                                        controller:
                                            controller.foodCaloriesController,
                                        labelText: "Calories",
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        keyboardType: TextInputType.number,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.03,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Serving Size',
                                        style: AppTextStyles.formalTextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .titleMedium!
                                              .color!,
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      CustomFoodTextField(
                                        controller: controller
                                            .foodServingSizeController,
                                        labelText: "Size",
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        keyboardType: TextInputType.number,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.035,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Food Protien',
                                        style: AppTextStyles.formalTextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .titleMedium!
                                              .color!,
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      CustomFoodTextField(
                                        controller:
                                            controller.foodProtienController,
                                        labelText: "Protien",
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        keyboardType: TextInputType.number,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.03,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Food Carbs',
                                        style: AppTextStyles.formalTextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .titleMedium!
                                              .color!,
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      CustomFoodTextField(
                                        controller:
                                            controller.foodCarbsController,
                                        labelText: "Carbs",
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        keyboardType: TextInputType.number,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      CustomLargeButton(
                        height: height,
                        width: width * 0.6,
                        borderRadius: BorderRadius.circular(15),
                        text: "Save",
                        onPressed: () {
                          var currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          controller.validateAndPost(
                            mealType,
                            replaceFoodRouteModel: replaceFoodRouteModel,
                          );
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
