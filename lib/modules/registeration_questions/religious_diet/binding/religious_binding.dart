import 'package:get/get.dart';

import '../controller/religious_controller.dart';


class ReligiousDietBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReligiousDietController());
  }
}