import 'package:get/get.dart';
import 'package:weight_loss_app/modules/setting/notifications/screen/notification_detial/controller/notification_detial_controller.dart';

class NotificationDetialBinding implements Bindings {
  NotificationDetialBinding({required this.time});
  final String time;
  @override
  void dependencies() {
    Get.lazyPut<NotificationDetialController>(
        () => NotificationDetialController()..getInitaialTime(time));
  }
}
