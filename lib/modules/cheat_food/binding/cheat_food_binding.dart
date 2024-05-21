import 'package:get/get.dart';

import '../controller/cheat_food_controller.dart';

class CheatFoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CheatFoodController());
  }
}