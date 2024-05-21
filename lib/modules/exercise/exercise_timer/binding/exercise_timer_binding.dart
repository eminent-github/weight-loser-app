import 'package:get/get.dart';
import 'package:weight_loss_app/modules/exercise/exercise_plan_detail/models/exercise_item_detial_model.dart';

import '../controller/exercise_timer_controller.dart';

class ExerciseTimerBinding implements Bindings {
  const ExerciseTimerBinding({required this.exerciseItemDetailModel});
  final ExerciseItemDetailModel exerciseItemDetailModel;
  @override
  void dependencies() {
    Get.lazyPut<ExerciseTimerController>(
        () => ExerciseTimerController()..getModelDat(exerciseItemDetailModel));
  }
}
