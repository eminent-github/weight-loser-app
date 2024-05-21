import 'package:get/get.dart';

import '../controller/analyzing_controller.dart';

class AnalyzingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AnalyzingController());
  }
}