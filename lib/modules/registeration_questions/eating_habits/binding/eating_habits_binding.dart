import 'package:get/get.dart';

import '../controller/eating_habits_controller.dart';

class EatingHabitsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EatingHabitsController>(() => EatingHabitsController());
  }
}
