import 'package:get/get.dart';

import '../controller/change_password_controller.dart';

class ChangePasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController());
  }
}
