import 'package:get/get.dart';

import '../controller/notification_controller.dart';
class NotificationBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
     Get.lazyPut<NotificationController>(
      () => NotificationController(
        
      ),
    );
    
  }
  }
  
