import 'package:get/get.dart';
import 'package:weight_loss_app/modules/diet/add_your_food/controller/add_your_food_controller.dart';

class AddYourFoodBinding implements Bindings {
  final int phaseId;
  final String mealType;

  AddYourFoodBinding({required this.phaseId, required this.mealType});
  @override
  void dependencies() {
    Get.lazyPut<AddYourFoodController>(() => AddYourFoodController()
      ..getPhaseIdAndMealType(phaseId, mealType));
  }
}
