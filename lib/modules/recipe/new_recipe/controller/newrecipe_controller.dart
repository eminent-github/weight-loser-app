import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/recipe/add_recipe/binding/add_recipe_binding.dart';
import 'package:weight_loss_app/modules/recipe/add_recipe/view/add_recipe_page.dart';
import 'package:weight_loss_app/modules/recipe/search_ingredient/binding/search_ingredient_binding.dart';
import 'package:weight_loss_app/modules/recipe/search_ingredient/model/search_ingredients_model.dart';
import 'package:weight_loss_app/modules/recipe/search_ingredient/search_ingredient_page/search_ingredient_page.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class NewRecipeController extends GetxController {
  // RxBool isSwitched = false.obs;
  // void toggleSwitch(bool value) => isSwitched.value = value;

  var recipeNameController = TextEditingController().obs;
  var servingSizeController = TextEditingController().obs;

  var ingredients = <SearchIngredientsModel>[]
      .obs; // type can be something like Ingredient as <Ingredient>[];

  // Add method to update the list of ingredients
  ///the [var] ingredient as [Ingredient] ingredient
  void addIngredient(var ingredient) {
    ingredients.add(ingredient);
  }

  // Add method to remove an ingredient
  void removeIngredient(var ingredient) {
    ingredients.remove(ingredient);
  }

  addIngredientButton() async {
    final ingredient = await Get.to(() => const SearchIngredientsPage(),
        binding: SearchIngredientsBinding());
    if (ingredient != null) {
      addIngredient(ingredient);
    }
  }

  nextButton() {
    if (recipeNameController.value.text.isEmpty) {
      customSnackbar(title: AppTexts.error, message: "Recipe name required");
    } else if (servingSizeController.value.text.isEmpty) {
      customSnackbar(title: AppTexts.error, message: "Serving name required");
    } else if (ingredients.isEmpty) {
      customSnackbar(
          title: AppTexts.error, message: "At least one ingredient required");
    } else {
      log(servingSizeController.value.text);
      Get.to(
          () => AddRecipePage(
                ingredients: ingredients,
                recipeName: recipeNameController.value.text,
                servingSize: int.parse(servingSizeController.value.text),
              ),
          binding: AddRecipeBinding());
    }
  }
}
