import 'package:get/get.dart';

import '../controller/search_ingredent_controller.dart';

class SearchIngredientsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchIngredientsController>(() => SearchIngredientsController());
  }
}
