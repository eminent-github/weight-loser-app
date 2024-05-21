import 'package:get/get.dart';

import '../controller/mind_paln_detail_controller.dart';

class MindPalnDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MindPalnDetailController>(() => MindPalnDetailController());
  }
}
