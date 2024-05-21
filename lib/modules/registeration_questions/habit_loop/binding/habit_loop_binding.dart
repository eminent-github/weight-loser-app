import 'package:get/get.dart';
import 'package:weight_loss_app/modules/registeration_questions/habit_loop/controller/habit_loop_controller.dart';

class HabitLoopBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HabitLoopController());
  }
}