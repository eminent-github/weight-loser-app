import 'package:get/get.dart';

import '../controller/wl_saved_controller.dart';

class WlSavedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WlSavedController());
  }
}