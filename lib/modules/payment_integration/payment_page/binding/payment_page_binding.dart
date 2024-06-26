import 'package:get/get.dart';

import '../controller/payment_page_controller.dart';

class PaymentPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentPageController());
  }
}