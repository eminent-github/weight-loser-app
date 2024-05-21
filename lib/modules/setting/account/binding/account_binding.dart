import 'package:get/get.dart';
import 'package:weight_loss_app/modules/setting/account/controller/account_controller.dart';

class AccountBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountController>(() => AccountController());
  }
}
