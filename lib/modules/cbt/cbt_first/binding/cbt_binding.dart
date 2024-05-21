import 'package:get/get.dart';

import '../controller/cbt_controller.dart';

class CbtBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CbtController());
  }
}