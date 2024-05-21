import 'package:get/get.dart';

import '../controller/exercise_controller.dart';

class ExerciseBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExerciseController>(() => ExerciseController());
  }
}
