import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/recipe/add_recipe_discover/binding/add_recipe_discover_binding.dart';
import 'package:weight_loss_app/modules/recipe/add_recipe_discover/model/recipe_detial_model.dart';
import 'package:weight_loss_app/modules/recipe/add_recipe_discover/view/add_recipe_discover_page.dart';
import 'package:weight_loss_app/modules/recipe/discover_recipe/model/discover_recipe_model.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';

class DiscoverListWidget extends StatelessWidget {
  final RxList<DiscoverRecipeModel> recipeDataList;

  const DiscoverListWidget({
    super.key,
    required this.recipeDataList,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double width = size.width;

    return Obx(
      () => recipeDataList.isEmpty
          ? Center(
              child: Text(
                "No Recipe Found",
                style: AppTextStyles.formalTextStyle(
                  color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
                ),
              ),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.06),
              child: GridView.builder(
                itemCount: recipeDataList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: width * 0.06,
                  crossAxisCount: 2,
                ),
                padding: const EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  DiscoverRecipeModel discoverRecipeModel =
                      recipeDataList[index];
                  return GestureDetector(
                    onTap: () async {
                      await Get.to(
                        () => AddRecipeDiscoverPage(
                          recipeDetialData: RecipeDetialModel(
                            foodId: discoverRecipeModel.foodId!,
                            planId: discoverRecipeModel.planId!,
                            isFavourite: discoverRecipeModel.isFavourite!,
                            name: discoverRecipeModel.name!,
                            fileName: discoverRecipeModel.fileName,
                            servingSize: discoverRecipeModel.servingSize!,
                            fat: discoverRecipeModel.fat!,
                            protein: discoverRecipeModel.protein!,
                            carbs: discoverRecipeModel.carbs!,
                            calories: discoverRecipeModel.calories!,
                          ),
                          mealType: discoverRecipeModel.mealType!,
                        ),
                        binding: AddRecipeDiscoverBinding(),
                      );
                    },
                    child: Column(
                      children: [
                        Expanded(
                          flex: 7,
                          child: SizedBox(
                            width: width,
                            child: discoverRecipeModel.fileName == null
                                ? Image.asset(
                                    AppAssets.dietRecipeImgUrl,
                                    fit: BoxFit.cover,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: S3LoadingImage(
                                      imageUrl:
                                          "${ApiUrls.s3ImageBaseUrl}Diet/${discoverRecipeModel.fileName}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 9,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(right: width * 0.01),
                                    child: AutoSizeText(
                                      discoverRecipeModel.name!,
                                      minFontSize: 10,
                                      maxLines: 2,
                                      style: AppTextStyles.formalTextStyle(
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .titleMedium!
                                            .color!,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: AutoSizeText(
                                    "${discoverRecipeModel.calories} kcal",
                                    minFontSize: 5,
                                    maxLines: 2,
                                    style: AppTextStyles.formalTextStyle(
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .titleMedium!
                                          .color!,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
