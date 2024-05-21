// ignore_for_file: must_be_immutable
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_button_widget.dart';
import '../../../../../common/app_colors.dart';
import '../../../../../common/app_text_styles.dart';
import '../../../../../common/app_texts.dart';
import '../controller/newrecipe_controller.dart';

class NewRecipePage extends GetView<NewRecipeController> {
  const NewRecipePage({super.key});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppTexts.createRecipe,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
      ),
      body: InternetCheckWidget<ConnectivityService>(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.07),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.045,
                  ),
                  const Row(
                    children: [
                      Text(
                        AppTexts.recipeName,
                        style: TextStyle(
                            color: AppColors.black,
                            fontFamily: AppTextStyles.fontFamily,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    height: height * 0.075,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.backgroundColor,
                          blurRadius: 4,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: TextField(
                        controller: controller.recipeNameController.value,
                        style: const TextStyle(
                            color: AppColors.black,
                            fontFamily: AppTextStyles.fontFamily,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^[a-zA-Z ]+$'),
                          ),

                          FilteringTextInputFormatter.deny(
                              RegExp(r'^\s')), // Deny leading space
                        ],
                        maxLength: 20,
                        maxLines: 1,
                        buildCounter: (context,
                                {required currentLength,
                                required isFocused,
                                maxLength}) =>
                            const SizedBox(),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: AppTexts.frenchRecipe,
                          hintStyle: TextStyle(
                              fontFamily: AppTextStyles.fontFamily,
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  const Row(
                    children: [
                      Text(
                        AppTexts.seving,
                        style: TextStyle(
                            color: AppColors.black,
                            fontFamily: AppTextStyles.fontFamily,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    height: height * 0.075,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.backgroundColor,
                          blurRadius: 4,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: TextField(
                        controller: controller.servingSizeController.value,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                            color: AppColors.black,
                            fontFamily: AppTextStyles.fontFamily,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^[0-9]+$'),
                          ),
                        ],
                        textInputAction: TextInputAction.done,
                        maxLength: 2,
                        maxLines: 1,
                        buildCounter: (context,
                                {required currentLength,
                                required isFocused,
                                maxLength}) =>
                            const SizedBox(),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "1",
                          hintStyle: TextStyle(
                              fontFamily: AppTextStyles.fontFamily,
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  // Padding(
                  //   padding:
                  //       EdgeInsets.only(left: width * 0.08, right: width * 0.03),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       const Text(
                  //         AppTexts.addingredients,
                  //         style: TextStyle(
                  //           fontFamily: AppTextStyles.fontFamily,
                  //           fontSize: 15,
                  //           color: AppColors.black,
                  //           fontWeight: FontWeight.w400,
                  //         ),
                  //       ),
                  //       Obx(() => Transform.scale(
                  //             scale: height * 0.001,
                  //             child: Switch(
                  //               value: controller.isSwitched.value,
                  //               onChanged: ((value) {
                  //                 controller.toggleSwitch(value);
                  //               }),
                  //               activeTrackColor: AppColors.blue,
                  //               activeColor: AppColors.white,
                  //               inactiveTrackColor: AppColors.lightblue,
                  //               inactiveThumbColor: AppColors.blue,
                  //             ),
                  //           )),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: height * 0.03,
                  // ),
                  // Obx(
                  //   () => controller.isSwitched.value
                  //       ? Container(
                  //           height: height * 0.078,
                  //           width: width * 0.81,
                  //           decoration: BoxDecoration(
                  //             color: AppColors.recipeContainerColor,
                  //             borderRadius: const BorderRadius.all(
                  //               Radius.circular(8.0),
                  //             ),
                  //             border: Border.all(
                  //                 color: AppColors.primaryColor, width: 0.5),
                  //           ),
                  //           child: Padding(
                  //             padding:
                  //                 EdgeInsets.symmetric(horizontal: width * 0.02),
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Container(
                  //                   padding: EdgeInsets.symmetric(
                  //                       horizontal: width * 0.05),
                  //                   width: width * 0.62,
                  //                   height: height * 0.085,
                  //                   decoration: const BoxDecoration(
                  //                     color: AppColors.recipeContainerColor,
                  //                   ),
                  //                   child: const Center(
                  //                     child: TextField(
                  //                       decoration: InputDecoration(
                  //                         border: InputBorder.none,
                  //                         focusedBorder: InputBorder.none,
                  //                         hintText: AppTexts.addOneIngredient,
                  //                         hintStyle: TextStyle(
                  //                             color: AppColors.black,
                  //                             fontFamily:
                  //                                 AppTextStyles.fontFamily,
                  //                             fontWeight: FontWeight.w400,
                  //                             fontSize: 11),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 IconButton(
                  //                     onPressed: () {},
                  //                     icon: const Icon(
                  //                       Icons.add_circle,
                  //                       size: 35,
                  //                       color: AppColors.blue,
                  //                     ))
                  //               ],
                  //             ),
                  //           ),
                  //         )
                  //       : Container(),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Ingredients",
                        style: TextStyle(
                            color: AppColors.black,
                            fontFamily: AppTextStyles.fontFamily,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      Material(
                        color: AppColors.buttonColor,
                        borderRadius: BorderRadius.circular(10),
                        elevation: 4,
                        child: InkWell(
                          onTap: () => controller.addIngredientButton(),
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            height: height * 0.05,
                            width: width * 0.34,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                 Icon(
                                  Icons.add_circle_rounded,
                                  color: AppColors.white,
                                  size: min(width, height)*0.04,
                                ),
                                AutoSizeText(
                                  'Add Ingredient',
                                  minFontSize: 5,
                                  style: AppTextStyles.formalTextStyle(
                                    fontSize: 12,
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),

                  SizedBox(
                    height: height * 0.025,
                  ),
                  Obx(
                    () => SizedBox(
                      height: height * 0.37,
                      child: controller.ingredients.isEmpty
                          ? Center(
                              child: Text(
                                "No ingredients found",
                                style: AppTextStyles.formalTextStyle(),
                              ),
                            )
                          : ListView.builder(
                              itemCount: controller.ingredients.length,
                              itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.only(top: height * 0.02),
                                child: Container(
                                  // height: height * 0.07,
                                  decoration: ShapeDecoration(
                                    color: Colors.grey.shade200,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    shadows: const [
                                      BoxShadow(
                                        color: Color(0x3F000000),
                                        blurRadius: 4,
                                        offset: Offset(0, 1),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      controller.ingredients[index].name!,
                                      style: AppTextStyles.formalTextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '${controller.ingredients[index].calories} cal،${controller.ingredients[index].servingSize} Serving',
                                      style: const TextStyle(
                                          fontFamily: AppTextStyles.fontFamily,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.subtitleColor),
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {
                                        controller.removeIngredient(
                                            controller.ingredients[index]);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  CustomButtonWidget(
                    height: height * 0.06,
                    width: width * 0.5,
                    text: AppTexts.next,
                    onPressed: () => controller.nextButton(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
