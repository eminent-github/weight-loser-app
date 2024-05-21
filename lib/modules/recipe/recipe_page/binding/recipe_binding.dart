import 'package:get/get.dart';

import '../controller/recipe_controller.dart';

class RecipeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecipeController());
  }
}