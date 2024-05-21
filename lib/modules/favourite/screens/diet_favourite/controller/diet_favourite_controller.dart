import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/modules/favourite/screens/diet_favourite/screens/diet_food_favourite/diet_food_favourite_page/diet_food_favourite_page.dart';
import 'package:weight_loss_app/modules/favourite/screens/diet_favourite/screens/diet_plan_favourite/diet_plan_favourite_page/diet_plan_favourite_page.dart';
// import 'package:weight_loss_app/modules/favourite/screens/diet_favourite/screens/diet_recipe_favourite/diet_recipe_favourite_page/diet_recipe_favourite_page.dart';

class DietFavouriteController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.onInit();
  }

  var dietFavouriteTabsList = [
    const Tab(
      child: Text(
        'Plans',
      ),
    ),
    const Tab(
      child: Text(
        'Food',
      ),
    ),
    // const Tab(
    //   child: FittedBox(
    //     child: Text(
    //       'Recipe',
    //     ),
    //   ),
    // ),
  ];
  var dietFavouriteScreensList = [
    const DietPlanFvouritePage(),
    const DietFoodFavouritePage(),
    // const DietRecipeFavouritePage(),
  ];
}
