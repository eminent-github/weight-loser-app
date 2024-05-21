import 'package:get/get.dart';
import '../controller/exercise_coach_controller.dart';

class ExerciseCoachBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExerciseCoachController());
  }
}