import 'package:get/get.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_detail/controller/payment_detail_controller.dart';

class PaymentDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentDetailController>(() => PaymentDetailController());
  }
}
