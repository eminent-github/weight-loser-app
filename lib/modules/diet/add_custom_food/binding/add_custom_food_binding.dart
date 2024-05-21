import 'package:get/get.dart';
import 'package:weight_loss_app/modules/diet/add_custom_food/controller/add_custom_food_controller.dart';

class AddCustomFoodBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCustomFoodController>(() => AddCustomFoodController());
  }
}
