import 'package:get/get.dart';

import '../controller/food_opinion_controller.dart';

class FoodOpinionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FoodOpinionController>(() => FoodOpinionController());
  }
}
