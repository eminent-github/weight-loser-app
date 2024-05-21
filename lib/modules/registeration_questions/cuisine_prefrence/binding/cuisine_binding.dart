import 'package:get/get.dart';

import '../controller/cuisine_controller.dart';

class CuisineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CuisineController());
  }
}