import 'package:get/get.dart';
import 'package:weight_loss_app/modules/dashbored/screens/drawer/controler/drawer_controler.dart';
// import 'package:weight_loss_app/modules/dashbored/screens/scanner/controller/scanner_controller.dart';
import 'package:weight_loss_app/modules/diary/controller/diary_controller.dart';
import 'package:weight_loss_app/modules/progress_user/controller/progress_user_controller.dart';

import '../controller/dashboared_controller.dart';
// import '../screens/grocery/controller/grocery_controller.dart';
import '../screens/home/controller/home_controller.dart';
import '../screens/home/screens/home_inner_diet/controller/home_inner_diet_controller.dart';
import '../screens/home/screens/home_inner_exercise/controller/home_inner_exercise_controller.dart';
import '../screens/home/screens/home_inner_mind/controller/home_inner_mind_controller.dart';
import '../screens/home/screens/home_inner_today/controller/home_inner_today_controller.dart';

class DashboaredBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboaredController>(() => DashboaredController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<HomeInnerTodayController>(() => HomeInnerTodayController(),
        fenix: true);
    Get.lazyPut<DiaryController>(() => DiaryController(), fenix: true);
    // Get.lazyPut<ScannerController>(() => ScannerController());
    // Get.lazyPut<GroceryController>(() => GroceryController());
    Get.lazyPut<HomeInnerDietController>(() => HomeInnerDietController());
    Get.lazyPut<HomeInnerExerciseController>(
        () => HomeInnerExerciseController());
    Get.lazyPut<HomeInnerMindController>(() => HomeInnerMindController());
    Get.lazyPut<MyDrawerController>(() => MyDrawerController());
    Get.lazyPut<ProgressUserController>(() => ProgressUserController(),
        fenix: true);
  }
}
