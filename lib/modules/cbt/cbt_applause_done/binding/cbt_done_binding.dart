import 'package:get/get.dart';

import '../controller/cbt_done_controller.dart';

class CbtDoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CbtDoneController());
  }
}