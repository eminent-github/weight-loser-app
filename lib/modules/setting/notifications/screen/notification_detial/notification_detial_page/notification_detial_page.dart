import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/local_db/notification_db.dart';
import 'package:weight_loss_app/modules/setting/notifications/model/notification_model.dart';
import 'package:weight_loss_app/modules/setting/notifications/screen/notification_detial/controller/notification_detial_controller.dart';

class NotificationDetialPage extends GetView<NotificationDetialController> {
  const NotificationDetialPage({
    super.key,
    required this.reminderNotifyModel,
    required this.remNotifyDBProvider,
  });
  final ReminderNotifyModel reminderNotifyModel;
  final RemNotifyDBProvider remNotifyDBProvider;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        title: Text(
          "Edit Notification",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.04,
                ),
                Text(
                  "Remind me if i haven't logged",
                  style: AppTextStyles.formalTextStyle(
                    color: const Color(0xFF7B6F72),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                ListTile(
                  title: Text(
                    reminderNotifyModel.name,
                    style: AppTextStyles.formalTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  shape: const Border(
                    bottom: BorderSide(
                      color: Color(0xFFCACACA),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                ListTile(
                  title: Text(
                    "Time",
                    style: AppTextStyles.formalTextStyle(
                      color: const Color(0xFF7B6F72),
                      fontSize: 10,
                    ),
                  ),
                  subtitle: Text(
                    controller.selectTime.value,
                    style: AppTextStyles.formalTextStyle(
                      fontSize: 16,
                    ),
                  ),
                  shape: const Border(
                    bottom: BorderSide(
                      color: Color(0xFFCACACA),
                    ),
                  ),
                  onTap: () async {
                    await controller.time(context);
                  },
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  "You will receive a reminder if you have not logged any item for your selection group by the time indicated above.",
                  style: AppTextStyles.formalTextStyle(
                      color: const Color(0xFF7B6F72), fontSize: 11),
                ),
                SizedBox(
                  height: height * 0.3,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.025),
                  child: Material(
                    color: AppColors.buttonColor,
                    borderRadius: BorderRadius.circular(30),
                    child: InkWell(
                      onTap: () async {
                        bool isUpdated =
                            await remNotifyDBProvider.updateReminder(
                          ReminderNotifyModel(
                              name: reminderNotifyModel.name,
                              time: controller.selectTime.value,
                              isOn: reminderNotifyModel.isOn,
                              remImgUrl: reminderNotifyModel.remImgUrl),
                        );
                        if (isUpdated) {
                          Get.back();
                        }
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: SizedBox(
                        height: height * 0.07,
                        child: const Center(
                          child: Text(
                            "Save",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: AppTextStyles.fontFamily,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
