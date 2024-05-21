import 'package:get/get.dart';
import 'package:weight_loss_app/modules/authentication/forget_otp/controller/forget_otp_controller.dart';

class ForgetOtpBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgetOtpController>(() => ForgetOtpController());
  }
}
