import 'package:get/get.dart';

import '../controller/wl_community_controller.dart';

class WlCommunityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WlCommunityController());
  }
}