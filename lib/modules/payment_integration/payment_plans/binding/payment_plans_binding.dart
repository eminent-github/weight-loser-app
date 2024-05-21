import 'package:get/get.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_plans/controller/payment_plans_controller.dart';

class PaymentPlansBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentPlansController>(() => PaymentPlansController());
  }
}
