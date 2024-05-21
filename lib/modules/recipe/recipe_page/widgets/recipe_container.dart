import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:get/get_core/get_core.dart';
// import 'package:get/get_navigation/get_navigation.dart';
// import 'package:weight_loss_app/modules/recipe/add_recipe_discover/binding/add_recipe_discover_binding.dart';
// import 'package:weight_loss_app/modules/recipe/add_recipe_discover/model/recipe_detial_model.dart';
// import 'package:weight_loss_app/modules/recipe/add_recipe_discover/view/add_recipe_discover_page.dart';
import 'package:weight_loss_app/modules/recipe/recipe_page/model/user_recipe_model.dart';
import '../../../../common/app_text_styles.dart';

class RecipeContainer extends StatelessWidget {
  const RecipeContainer({
    super.key,
    required this.userFoodRecipeList,
    required this.planId,
  });
  final List<UserCustomRecipeList> userFoodRecipeList;
  final int planId;
  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return userFoodRecipeList.isEmpty
        ? Center(
            child: Text(
              "No Recipe Found",
              style: AppTextStyles.formalTextStyle(),
            ),
          )
        : ListView.builder(
            itemCount: userFoodRecipeList.length,
            padding: EdgeInsets.symmetric(horizontal: width * 0.1),
            itemBuilder: (context, index) {
              UserCustomRecipeList userFoodRecipeData =
                  userFoodRecipeList[index];
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Material(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(3),
                  child: InkWell(
                    onTap: () {
                      // Get.to(
                      //     () => AddRecipeDiscoverPage(
                      //           recipeDetialData: RecipeDetialModel(
                      //             name: userFoodRecipeData.name!,
                      //             fileName: userFoodRecipeData.fileName,
                      //             servingSize: userFoodRecipeData.servingSize!,
                      //             fat: userFoodRecipeData.fat!,
                      //             protein: userFoodRecipeData.protein!,
                      //             carbs: userFoodRecipeData.carbs!,
                      //             calories: userFoodRecipeData.calories!,
                      //             ingredients: userFoodRecipeData.ingredients!,
                      //             planId: planId,
                      //             id: userFoodRecipeData.id!,
                      //           ),
                      //         ),
                      //     binding: AddRecipeDiscoverBinding());
                    },
                    borderRadius: BorderRadius.circular(3),
                    child: ListTile(
                      dense: true,
                      title: Text(
                        userFoodRecipeData.name!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: AppTextStyles.fontFamily,
                            fontSize: 12),
                      ),
                      subtitle: Text(
                        '${userFoodRecipeData.calories} cal،${userFoodRecipeData.servingSize} Serving',
                        style: const TextStyle(
                            fontFamily: AppTextStyles.fontFamily,
                            fontWeight: FontWeight.w300,
                            fontSize: 11),
                      ),
                      trailing: SvgPicture.asset('assets/icons/iconButton.svg'),
                    ),
                  ),
                ),
              );
            },
          );
  }
}
