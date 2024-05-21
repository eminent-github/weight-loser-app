import 'package:get/get.dart';

import '../controller/goal_diet_controller.dart';

class GoalDietBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GoalDietController>(
      () => GoalDietController(
        
      ),
    );
  }
}
