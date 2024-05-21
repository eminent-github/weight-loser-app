import 'package:get/get.dart';

import '../controller/activate_exercise_plan_controller.dart';

class ActivateExercisePlanBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivateExercisePlanController>(
        () => ActivateExercisePlanController());
  }
}
