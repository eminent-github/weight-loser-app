import 'package:get/get.dart';
import 'package:weight_loss_app/modules/wl_communities/edit_post/controller/edit_post_controller.dart';

class EditPostBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditPostController>(() => EditPostController());
  }
}
