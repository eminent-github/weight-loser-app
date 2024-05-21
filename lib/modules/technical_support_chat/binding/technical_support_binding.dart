import 'package:get/get.dart';

import '../controller/technical_support_controller.dart';

class TechnicalSupportBinding extends Bindings {
  TechnicalSupportBinding({
    required this.isFromLogin,
    this.token,
  });
  final String? token;
  final bool isFromLogin;
  @override
  void dependencies() {
    Get.lazyPut(() =>
        TechnicalSupportController()..getBindData(i: isFromLogin, t: token));
  }
}
