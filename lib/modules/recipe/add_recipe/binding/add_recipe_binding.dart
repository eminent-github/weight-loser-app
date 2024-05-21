import 'package:get/get.dart';

import '../controller/add_recipe_controller.dart';

class AddRecipeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddRecipeController());
  }
}