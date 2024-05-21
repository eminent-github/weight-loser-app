import 'dart:developer';

import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/local_db/notification_db.dart';
import 'package:weight_loss_app/modules/setting/notifications/model/notification_model.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class NotificationController extends GetxController {
  late RemNotifyDBProvider remNotifyDBProvider;
  @override
  void onInit() {
    remNotifyDBProvider = RemNotifyDBProvider();
    getNotification();
    super.onInit();
  }

  var notificationsList = <ReminderNotifyModel>[].obs;
  void getNotification() async {
    try {
      notificationsList.value = await remNotifyDBProvider.fetchReminderList();
      update();
      // log(notificationsList.length.toString());
    } catch (e) {
      log(e.toString());
      customSnackbar(title: AppTexts.error, message: e.toString());
    }
  }
}
