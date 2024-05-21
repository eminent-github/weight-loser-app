import 'package:get/get.dart';
import 'package:weight_loss_app/modules/registeration_questions/uncomfortable_exercise/controller/uncomfortable_exercise_controller.dart';

class UnComfortableExerciseBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UnComfortableExerciseController>(
        () => UnComfortableExerciseController());
  }
}
