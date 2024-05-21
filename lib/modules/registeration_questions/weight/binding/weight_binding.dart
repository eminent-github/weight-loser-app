import 'package:get/get.dart';

import '../controller/weight_controller.dart';

class WeightBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeightController>(() => WeightController());
  }
}
