import 'package:get/get.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_confirmation/controller/payment_confirmation_controller.dart';

class PaymentConfirmationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentConfirmationController>(
        () => PaymentConfirmationController());
  }
}
