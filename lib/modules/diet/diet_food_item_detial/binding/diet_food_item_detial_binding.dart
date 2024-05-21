import 'package:get/get.dart';
import 'package:weight_loss_app/modules/diet/diet_food_item_detial/controller/diet_food_item_detial_controller.dart';
import 'package:weight_loss_app/modules/diet/diet_plan_detail/models/diet_plan_detail_model.dart';

class DietFoodItemDetialBinding implements Bindings {
  final DietPlanDetialModel dietPlanDetialModel;
  final int totalDays;
  DietFoodItemDetialBinding({
    required this.dietPlanDetialModel,
    required this.totalDays,
  });
  @override
  void dependencies() {
    Get.lazyPut<DietFoodItemDetialController>(() =>
        DietFoodItemDetialController()
          ..getdietplanDetialModel(dietPlanDetialModel, totalDays));
  }
}
