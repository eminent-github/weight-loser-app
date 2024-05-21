import 'package:get/get.dart';
import 'package:weight_loss_app/modules/favourite/controller/favourite_controller.dart';
import 'package:weight_loss_app/modules/favourite/screens/diet_favourite/controller/diet_favourite_controller.dart';
import 'package:weight_loss_app/modules/favourite/screens/diet_favourite/screens/diet_food_favourite/controller/diet_food_favourite_controller.dart';
import 'package:weight_loss_app/modules/favourite/screens/diet_favourite/screens/diet_plan_favourite/controller/diet_plan_favourite_controller.dart';
import 'package:weight_loss_app/modules/favourite/screens/diet_favourite/screens/diet_recipe_favourite/controller/diet_recipe_favourite_controller.dart';
import 'package:weight_loss_app/modules/favourite/screens/exercise_favourite/controller/exercise_favourite_controller.dart';
import 'package:weight_loss_app/modules/favourite/screens/mind_favourite/controller/mind_favourite_controller.dart';

class FavouriteBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavouriteController>(() => FavouriteController());
    Get.lazyPut<MindFavouriteController>(() => MindFavouriteController());
    Get.lazyPut<DietFavouriteController>(() => DietFavouriteController());
    Get.lazyPut<ExerciseFavouriteController>(
        () => ExerciseFavouriteController());

    Get.lazyPut<DietPlanFavouriteController>(
        () => DietPlanFavouriteController());
    Get.lazyPut<DietFoodFavouriteController>(
        () => DietFoodFavouriteController());
    Get.lazyPut<DietRecipeFavouriteController>(
        () => DietRecipeFavouriteController());
  }
}
