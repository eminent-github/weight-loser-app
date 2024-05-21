import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/modules/recipe/discover_recipe/binding/discover_binding.dart';
import 'package:weight_loss_app/modules/recipe/discover_recipe/view/discover_page.dart';
import 'package:weight_loss_app/modules/recipe/new_recipe/binding/newrecipe_binding.dart';
import 'package:weight_loss_app/modules/recipe/new_recipe/new_recipe_page/new_recipe_page.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';
import '../widgets/recipe_container.dart';
import '../controller/recipe_controller.dart';

class RecipePage extends GetView<RecipeController> {
  const RecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppTexts.recipeText,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: InternetCheckWidget<ConnectivityService>(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.027,
                ),
                Container(
                  height: height * 0.07,
                  width: width * 0.81,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 1),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: width * 0.15,
                        child: Icon(
                          Icons.search,
                          color: AppColors.buttonColor,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            controller.filterFoods(value);
                          },
                          decoration: const InputDecoration(
                              hintText: AppTexts.recipeHintSearch,
                              hintStyle: TextStyle(color: Color(0xffB5B5B5)),
                              border: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                SizedBox(
                  height: height * 0.15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            await Get.to(() => const NewRecipePage(),
                                binding: NewRecipeBinding());
                            controller.getUserRecipe();
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                              height: height * 0.15,
                              width: width * 0.31,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.black12,
                                      width: width * 0.002)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/recipecreate.svg',
                                    color: AppColors.buttonColor,
                                  ),
                                  const Text(
                                    'Create Recipe',
                                    style: TextStyle(
                                        fontFamily: AppTextStyles.fontFamily,
                                        fontSize: 10),
                                  )
                                ],
                              )),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Get.to(() => const DiscoverRecipePage(),
                                binding: DiscoverBinding());
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                              height: height * 0.15,
                              width: width * 0.31,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black12,
                                    width: width * 0.002),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/recipediscover.svg',
                                    color: AppColors.buttonColor,
                                  ),
                                  const Text(
                                    'Discover Recipe',
                                    style: TextStyle(
                                        fontFamily: AppTextStyles.fontFamily,
                                        fontSize: 10),
                                  )
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 33),
                    child: Text("My Recipes",
                        style: TextStyle(
                          fontFamily: AppTextStyles.fontFamily,
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ),
                SizedBox(
                  height: height * 0.53,
                  child: Obx(
                    () => controller.isLoading.value
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.buttonColor,
                            ),
                          )
                        : GetBuilder(
                            init: controller,
                            builder: (_) {
                              return RecipeContainer(
                                userFoodRecipeList:
                                    controller.filterUserRecipeData,
                                planId: controller
                                            .userRecipeData.value.planId ==
                                        null
                                    ? 0
                                    : controller.userRecipeData.value.planId!,
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
