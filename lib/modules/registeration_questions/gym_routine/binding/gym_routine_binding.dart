import 'package:get/get.dart';

import '../controller/gym_routine_controller.dart';

class GymRoutineBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<GymRoutineController>(() => GymRoutineController(
     ));
  }
}