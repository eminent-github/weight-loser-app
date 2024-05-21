import 'package:get/get.dart';

import '../controller/add_card_controller.dart';

class AddCardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCardController>(() => AddCardController());
  }
}
