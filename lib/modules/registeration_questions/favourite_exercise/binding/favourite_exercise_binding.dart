import 'package:get/get.dart';
import 'package:weight_loss_app/modules/registeration_questions/favourite_exercise/controller/favourite_exercise_controller.dart';

class FavouriteExerciseBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavouriteExerciseController>(
        () => FavouriteExerciseController());
  }
}
