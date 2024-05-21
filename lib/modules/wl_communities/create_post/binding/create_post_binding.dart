import 'package:get/get.dart';
import 'package:weight_loss_app/modules/wl_communities/create_post/controller/create_post_controller.dart';

class CreatePostBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatePostController>(() => CreatePostController());
  }
}
