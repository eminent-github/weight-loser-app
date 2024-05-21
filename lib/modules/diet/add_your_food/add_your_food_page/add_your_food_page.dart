import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/diet/add_custom_food/add_custom_food_page/add_custom_food_page.dart';
import 'package:weight_loss_app/modules/diet/add_custom_food/binding/add_custom_food_binding.dart';
import 'package:weight_loss_app/modules/diet/add_your_food/controller/add_your_food_controller.dart';
import 'package:weight_loss_app/modules/diet/add_your_food/model/own_food_deatil_model.dart';
import 'package:weight_loss_app/modules/diet/add_your_food/model/rep_food_route_model.dart';
import 'package:weight_loss_app/modules/diet/own_food_detail/binding/own_food_detail_binding.dart';
import 'package:weight_loss_app/modules/diet/own_food_detail/own_food_detail_page/own_food_detail_page.dart';
import 'package:weight_loss_app/modules/diet_scanner/binding/diet_scanner_binding.dart';
import 'package:weight_loss_app/modules/diet_scanner/diet_scanner_page/diet_scanner_page.dart';
import 'package:weight_loss_app/modules/recipe/search_ingredient/model/search_ingredients_model.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

class AddYourFoodPage extends GetView<AddYourFoodController> {
  const AddYourFoodPage({
    super.key,
    required this.replaceFoodRouteModel,
  });
  final ReplaceFoodRouteModel replaceFoodRouteModel;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    print(replaceFoodRouteModel.toMap());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Add your own",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: InternetCheckWidget<ConnectivityService>(
        child: Obx(
          () => Stack(
            children: [
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Container(
                              height: height * 0.074,
                              decoration: const BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.backgroundColor,
                                    blurRadius: 4,
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.14,
                                    child: const Icon(
                                      Icons.search,
                                      color: AppColors.bottomNavColor,
                                      size: 28,
                                    ),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      onChanged: (value) {
                                        controller.debouncer.call(() {
                                          if (value.isNotEmpty) {
                                            controller
                                                .fetchIngredients(value.trim());
                                          } else {
                                            controller.filteredFoodList.value =
                                                [];
                                          }
                                        });
                                      },
                                      style: const TextStyle(
                                          color: AppColors.black,
                                          fontFamily: AppTextStyles.fontFamily,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: "French Fries",
                                        hintStyle: TextStyle(
                                            fontFamily:
                                                AppTextStyles.fontFamily,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: IconButton(
                                onPressed: () {
                                  Get.to(
                                    () => DietScannerPage(
                                      mealType: controller.mealType.value,
                                      replaceFoodRouteModel:
                                          replaceFoodRouteModel,
                                    ),
                                    binding: DietScannerBinding(),
                                  );
                                },
                                icon: Icon(
                                  Icons.qr_code_scanner_rounded,
                                  color: AppColors.buttonColor,
                                  size: 45,
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Expanded(
                        child: controller.isLoading.value
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.buttonColor,
                                ),
                              )
                            : controller.filteredFoodList.isEmpty
                                ? Center(
                                    child: Text(
                                      "No food Available",
                                      style: AppTextStyles.formalTextStyle(),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount:
                                        controller.filteredFoodList.length,
                                    itemBuilder: (context, index) {
                                      SearchIngredientsModel
                                          searchIngredientsModel =
                                          controller.filteredFoodList[index];
                                      return Padding(
                                        padding:
                                            EdgeInsets.only(top: height * 0.03),
                                        child: Material(
                                          color: const Color(0xFFCFCCCC)
                                              .withOpacity(0.1),
                                          elevation: 3,
                                          shadowColor: const Color(0x3F000000),
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 0.80,
                                                color: const Color(0xFF5C89C7)
                                                    .withOpacity(0.5)),
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                          child: InkWell(
                                            onTap: () async {
                                              FocusScope.of(context).unfocus();
                                              Get.to(
                                                  () => OwnFoodDetailPage(
                                                        planFoodId:
                                                            replaceFoodRouteModel
                                                                .planFoodId!,
                                                        recipeDetialData:
                                                            OwnFoodDetailModel(
                                                          foodId:
                                                              searchIngredientsModel
                                                                  .foodId!,
                                                          name:
                                                              searchIngredientsModel
                                                                  .name!,
                                                          fileName:
                                                              searchIngredientsModel
                                                                  .fileName!,
                                                          servingSize:
                                                              searchIngredientsModel
                                                                  .servingSize
                                                                  .toString(),
                                                          fat:
                                                              searchIngredientsModel
                                                                  .fat!,
                                                          protein:
                                                              searchIngredientsModel
                                                                  .protein!,
                                                          carbs:
                                                              searchIngredientsModel
                                                                  .carbs!,
                                                          calories:
                                                              searchIngredientsModel
                                                                  .calories!,
                                                          day:
                                                              replaceFoodRouteModel
                                                                      .day ??
                                                                  0,
                                                          mealType: controller
                                                              .mealType.value,
                                                          phase:
                                                              replaceFoodRouteModel
                                                                      .planId ??
                                                                  0,
                                                        ),
                                                        planId:
                                                            replaceFoodRouteModel
                                                                .planId!,
                                                      ),
                                                  binding:
                                                      OwnFoodDetailBinding());
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width * 0.05),
                                              width: width * 0.83,
                                              height: height * 0.07,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    controller
                                                            .filteredFoodList[
                                                                index]
                                                            .name ??
                                                        'no name',
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            AppTextStyles
                                                                .fontFamily,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Text(
                                                    '${controller.filteredFoodList[index].calories} cal. ${controller.filteredFoodList[index].servingSize} serving ',
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            AppTextStyles
                                                                .fontFamily,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: AppColors
                                                            .subtitleColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                      ),
                    ],
                  ),
                ),
              ),
              controller.isAddMealLoading.value
                  ? const OverlayWidget()
                  : const SizedBox()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            () => AddCustomFoodPage(
              mealType: controller.mealType.value,
              replaceFoodRouteModel: replaceFoodRouteModel,
            ),
            binding: AddCustomFoodBinding(),
          );
        },
        backgroundColor: AppColors.buttonColor,
        child: const Icon(
          Icons.add,
          color: AppColors.white,
        ),
      ),
    );
  }
}
