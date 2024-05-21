import 'package:get/get.dart';

import '../controller/cbt_ques_controller.dart';

class CbtQuestionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CbtQuestionController());
  }
}