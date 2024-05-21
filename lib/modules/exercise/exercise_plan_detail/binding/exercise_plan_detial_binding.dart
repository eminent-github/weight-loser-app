import 'package:get/get.dart';

import '../controller/exercise_plan_detial_controller.dart';

class ExercisePlanDetialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExercisePlanDetialController>(
        () => ExercisePlanDetialController());
  }
}
