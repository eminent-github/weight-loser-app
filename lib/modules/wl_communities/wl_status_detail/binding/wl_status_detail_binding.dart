import 'package:get/get.dart';

import '../controller/wl_status_detail_controller.dart';

class WlStatusDetailBinding extends Bindings {
  WlStatusDetailBinding({required this.saveChatId});
  final int saveChatId;
  @override
  void dependencies() {
    Get.lazyPut(() => WlStatusDetailController()..getsaveChatId(saveChatId));
  }
}
