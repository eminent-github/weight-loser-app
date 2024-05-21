import 'package:get/get.dart';
import 'package:weight_loss_app/modules/terms_conditions/controller/terms_condition_controller.dart';

class TermsConditionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TermsConditionController>(() => TermsConditionController());
  }
}
