import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/recipe/search_ingredient/model/search_ingredients_model.dart';

class SearchIngredientsItem extends StatelessWidget {
  const SearchIngredientsItem({super.key, required this.ingredientsList});
  final List<SearchIngredientsModel> ingredientsList;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return ingredientsList.isEmpty
        ? Center(
            child: Text(
              "No ingredients found",
              style: AppTextStyles.formalTextStyle(),
            ),
          )
        : ListView.builder(
            itemCount: ingredientsList.length,
            padding: EdgeInsets.symmetric(horizontal: width * 0.08),
            itemBuilder: (context, index) {
              SearchIngredientsModel ingredient = ingredientsList[index];
              return Padding(
                padding: EdgeInsets.only(top: height * 0.03),
                child: Material(
                  color: AppColors.white,
                  elevation: 3,
                  shadowColor: const Color(0x3F000000),
                  shape: RoundedRectangleBorder(
                    side:
                        const BorderSide(width: 0.80, color: Color(0xFF5C89C7)),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: InkWell(
                    onTap: () {
                      Get.back(result: ingredient);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                      width: width * 0.83,
                      height: height * 0.07,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ingredient.name!,
                            style: const TextStyle(
                                fontFamily: AppTextStyles.fontFamily,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '${ingredient.calories} cal،${ingredient.servingSize} Serving',
                            style: const TextStyle(
                                fontFamily: AppTextStyles.fontFamily,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: AppColors.subtitleColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }
}
