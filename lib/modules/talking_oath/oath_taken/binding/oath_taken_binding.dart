import 'package:get/get.dart';

import '../controller/oath_taken_controller.dart';

class OathTakenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OathTakenController());
  }
}