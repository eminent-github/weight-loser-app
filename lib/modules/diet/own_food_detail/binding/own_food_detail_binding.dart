import 'package:get/get.dart';
import 'package:weight_loss_app/modules/diet/own_food_detail/controller/own_food_detail_controller.dart';

class OwnFoodDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OwnFoodDetailController>(() => OwnFoodDetailController());
  }
}
