import 'package:get/get.dart';
import 'package:weight_loss_app/modules/setting/delete_reason/controller/delete_reason_controller.dart';

class DeleteReasonBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeleteReasonController>(() => DeleteReasonController());
  }
}
