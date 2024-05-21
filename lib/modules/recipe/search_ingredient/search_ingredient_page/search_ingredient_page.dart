import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/modules/recipe/search_ingredient/controller/search_ingredent_controller.dart';
import 'package:weight_loss_app/modules/recipe/search_ingredient/widgets/search_ingredients_item.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import '../../../../../common/app_colors.dart';
import '../../../../../common/app_text_styles.dart';
import '../../../../../common/app_texts.dart';

class SearchIngredientsPage extends GetView<SearchIngredientsController> {
  const SearchIngredientsPage({super.key});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppTexts.searchingredients,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: InternetCheckWidget<ConnectivityService>(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                width: width * 0.84,
                // height: height * 0.07,
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
                    onChanged: (value) async {
                      controller.debouncer.call(() {
                        if (value.isNotEmpty) {
                          controller.fetchIngredients(value.trim());
                        } else {
                          controller.ingredientsList.value = [];
                        }
                      });
                    },
                    scrollPadding: EdgeInsets.zero,
                    style: const TextStyle(
                        color: AppColors.black,
                        fontFamily: AppTextStyles.fontFamily,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: height * 0.025),
                      focusedBorder: InputBorder.none,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.bottomNavColor,
                        size: 28,
                      ),
                      hintText: "French Fries",
                      hintStyle: const TextStyle(
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
              Expanded(
                child: Obx(
                  () => controller.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.buttonColor,
                          ),
                        )
                      : Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: height * 0.02),
                          child: SearchIngredientsItem(
                            ingredientsList: controller.ingredientsList,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
