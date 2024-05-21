import 'package:get/get.dart';

import '../controller/exercise_my_plans_controller.dart';

class ExerciseMyPlansBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExerciseMyPlansController>(() => ExerciseMyPlansController());
  }
}
