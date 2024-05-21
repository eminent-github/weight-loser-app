import 'package:get/get.dart';

import '../controller/add_recipe_discover_controller.dart';

class AddRecipeDiscoverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddRecipeDiscoverController());
  }
}