import 'package:get/get.dart';

import '../controller/workout_controller.dart';
import '../screens/interval_counter/controller/interval_counter_controller.dart';
// import '../screens/intervel_timer/controller/interval_timer_controlle.dart';

class WorkoutBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WorkoutController>(() => WorkoutController());
    // Get.lazyPut<IntervalTimerController>(() => IntervalTimerController());
    Get.lazyPut<IntervalCounterController>(() => IntervalCounterController());
  }
}
