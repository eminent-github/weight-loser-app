import 'package:get/get.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_method/controller/payment_method_controller.dart';

class PaymentMethodBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentMethodController>(() => PaymentMethodController());
  }
}
