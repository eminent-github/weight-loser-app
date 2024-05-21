import 'package:get/get.dart';

import '../controller/user_goal_category_controller.dart';

class UserGoalCategoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserGoalCategoryController>(() => UserGoalCategoryController());
  }
}
