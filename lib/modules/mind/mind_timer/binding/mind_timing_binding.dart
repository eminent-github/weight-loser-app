import 'package:get/get.dart';
import 'package:weight_loss_app/modules/mind/mind_plan_detail/models/mind_item_detail_model.dart';
import 'package:weight_loss_app/modules/mind/mind_timer/controller/mind_timer_controller.dart';

class MindTimerBinding implements Bindings {
  MindTimerBinding({required this.mindItemDetailModel});
  final MindItemDetailModel mindItemDetailModel;
  @override
  void dependencies() {
    Get.lazyPut<MindTimerController>(
        () => MindTimerController()..getModel(mindItemDetailModel));
  }
}
