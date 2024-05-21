import 'package:get/get.dart';
import '../controller/setting_controller.dart';

class SettingBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    void dependencies() {
  Get.lazyPut<SettingController>(() => SettingController(
     ));
  }
  }
  
}