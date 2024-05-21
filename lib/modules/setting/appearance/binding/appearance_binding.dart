import 'package:get/get.dart';

import '../controller/appearance_controller.dart';


class AppearanceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppearanceController>(() => AppearanceController());
  }
}
