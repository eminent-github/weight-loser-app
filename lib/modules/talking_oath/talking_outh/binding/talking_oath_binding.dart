import 'package:get/get.dart';

import '../controller/talking_oath_controller.dart';

class TalkingOathBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TalkingOathController());
  }
}