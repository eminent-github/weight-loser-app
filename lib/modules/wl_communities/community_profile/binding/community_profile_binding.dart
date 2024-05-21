import 'package:get/get.dart';
import 'package:weight_loss_app/modules/wl_communities/community_profile/controller/community_profile_controller.dart';

class CommunityProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommunityProfileController>(() => CommunityProfileController());
  }
}
