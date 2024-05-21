// ignore_for_file: unused_local_variable, must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/modules/setting/notifications/model/notification_model.dart';
import 'package:weight_loss_app/modules/setting/notifications/screen/notification_detial/binding/notification_detial_binding.dart';
import 'package:weight_loss_app/modules/setting/notifications/screen/notification_detial/notification_detial_page/notification_detial_page.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';
import '../controller/notification_controller.dart';

class NotificationsPage extends GetView<NotificationController> {
  const NotificationsPage({super.key});

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
          AppTexts.notification,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.07,
              ),
              Expanded(
                child: GetBuilder<NotificationController>(
                    init: controller,
                    builder: (context) {
                      return controller.notificationsList.isEmpty
                          ? Center(
                              child: Text(
                                "NO Notification Found",
                                style: AppTextStyles.formalTextStyle(),
                              ),
                            )
                          : ListView.builder(
                              itemCount: controller.notificationsList.length,
                              itemBuilder: (context, index) {
                                ReminderNotifyModel reminderNotifyModel =
                                    controller.notificationsList[index];
                                return ListTile(
                                  leading: SvgPicture.asset(
                                    reminderNotifyModel.remImgUrl,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  title: Text(
                                    reminderNotifyModel.name,
                                    style: const TextStyle(
                                        fontFamily: AppTextStyles.fontFamily,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.gray1),
                                  ),
                                  subtitle: Text(
                                    reminderNotifyModel.time,
                                    style: AppTextStyles.formalTextStyle(
                                      color: const Color(0xFF7B6F72),
                                      fontSize: 8,
                                    ),
                                  ),
                                  trailing: CupertinoSwitch(
                                    value: reminderNotifyModel.isOn == 1
                                        ? true
                                        : false,
                                    onChanged: ((value) async {
                                      bool isUpdated = await controller
                                          .remNotifyDBProvider
                                          .updateReminder(
                                        ReminderNotifyModel(
                                          name: reminderNotifyModel.name,
                                          isOn: value ? 1 : 0,
                                          remImgUrl:
                                              reminderNotifyModel.remImgUrl,
                                          time: reminderNotifyModel.time,
                                        ),
                                      );
                                      if (isUpdated) {
                                        controller.getNotification();
                                      }
                                    }),
                                    thumbColor: AppColors.white,
                                    trackColor: AppColors.lightBlue,
                                    activeColor: AppColors.blue,
                                  ),
                                  onTap: () async {
                                    await Get.to(
                                      () => NotificationDetialPage(
                                        reminderNotifyModel:
                                            reminderNotifyModel,
                                        remNotifyDBProvider:
                                            controller.remNotifyDBProvider,
                                      ),
                                      binding: NotificationDetialBinding(
                                          time: reminderNotifyModel.time),
                                    );
                                    controller.getNotification();
                                  },
                                );
                              },
                            );
                    }),
              ),
              // ListTile(
              //   leading: SvgPicture.asset(
              //     AppAssets.lunch,
              //     fit: BoxFit.scaleDown,
              //   ),
              //   title: const Text(
              //     AppTexts.lunch,
              //     style: TextStyle(
              //         fontFamily: AppTextStyles.fontFamily,
              //         fontSize: 16,
              //         fontWeight: FontWeight.w400,
              //         color: AppColors.gray1),
              //   ),
              //   subtitle: Text(
              //     '12:00 AM',
              //     style: AppTextStyles.formalTextStyle(
              //       color: const Color(0xFF7B6F72),
              //       fontSize: 8,
              //     ),
              //   ),
              //   trailing: Obx(() => CupertinoSwitch(
              //         value: controller.lunch.value,
              //         onChanged: ((value) {
              //           controller.lunchSwitch(value);
              //         }),
              //         thumbColor: AppColors.white,
              //         trackColor: AppColors.lightBlue,
              //         activeColor: AppColors.blue,
              //       )),
              //   onTap: () {
              //     Get.to(
              //         () => const NotificationDetialPage(title: AppTexts.lunch),
              //         binding: NotificationDetialBinding());
              //   },
              // ),
              // ListTile(
              //   leading: SvgPicture.asset(
              //     AppAssets.lunch,
              //     fit: BoxFit.scaleDown,
              //   ),
              //   title: const Text(
              //     "Snack",
              //     style: TextStyle(
              //         fontFamily: AppTextStyles.fontFamily,
              //         fontSize: 16,
              //         fontWeight: FontWeight.w400,
              //         color: AppColors.gray1),
              //   ),
              //   subtitle: Text(
              //     '12:00 AM',
              //     style: AppTextStyles.formalTextStyle(
              //       color: const Color(0xFF7B6F72),
              //       fontSize: 8,
              //     ),
              //   ),
              //   trailing: Obx(() => CupertinoSwitch(
              //         value: controller.snack.value,
              //         onChanged: ((value) {
              //           controller.snackSwitch(value);
              //         }),
              //         thumbColor: AppColors.white,
              //         trackColor: AppColors.lightBlue,
              //         activeColor: AppColors.blue,
              //       )),
              //   onTap: () {
              //     Get.to(() => const NotificationDetialPage(title: "Snack"),
              //         binding: NotificationDetialBinding());
              //   },
              // ),
              // ListTile(
              //   leading: SizedBox(
              //       height: height * 0.06,
              //       width: width * 0.08,
              //       child: SvgPicture.asset(
              //         AppAssets.dinner,
              //         fit: BoxFit.scaleDown,
              //       )),
              //   title: const Text(
              //     AppTexts.dinner,
              //     style: TextStyle(
              //         fontFamily: AppTextStyles.fontFamily,
              //         fontSize: 16,
              //         fontWeight: FontWeight.w400,
              //         color: AppColors.gray1),
              //   ),
              //   subtitle: Text(
              //     '12:00 AM',
              //     style: AppTextStyles.formalTextStyle(
              //       color: const Color(0xFF7B6F72),
              //       fontSize: 8,
              //     ),
              //   ),
              //   trailing: Obx(() => CupertinoSwitch(
              //         value: controller.dinner.value,
              //         onChanged: ((value) {
              //           controller.dinnerSwitch(value);
              //         }),
              //         thumbColor: AppColors.white,
              //         trackColor: AppColors.lightBlue,
              //         activeColor: AppColors.blue,
              //       )),
              //   onTap: () {
              //     Get.to(
              //         () =>
              //             const NotificationDetialPage(title: AppTexts.dinner),
              //         binding: NotificationDetialBinding());
              //   },
              // ),
              // ListTile(
              //   leading: SizedBox(
              //       height: height * 0.06,
              //       width: width * 0.08,
              //       child: SvgPicture.asset(
              //         AppAssets.workout,
              //         fit: BoxFit.scaleDown,
              //       )),
              //   title: Text(
              //     AppTexts.workOut,
              //     style: AppTextStyles.formalTextStyle(
              //         fontSize: 16, color: AppColors.gray1),
              //   ),
              //   subtitle: Text(
              //     '12:00 AM',
              //     style: AppTextStyles.formalTextStyle(
              //       color: const Color(0xFF7B6F72),
              //       fontSize: 8,
              //     ),
              //   ),
              //   trailing: Obx(() => CupertinoSwitch(
              //         value: controller.workout.value,
              //         onChanged: ((value) {
              //           controller.workSwitch(value);
              //         }),
              //         thumbColor: AppColors.white,
              //         trackColor: AppColors.lightBlue,
              //         activeColor: AppColors.blue,
              //       )),
              //   onTap: () {
              //     Get.to(
              //         () =>
              //             const NotificationDetialPage(title: AppTexts.workOut),
              //         binding: NotificationDetialBinding());
              //   },
              // ),
              // ListTile(
              //   leading: SvgPicture.asset(
              //     AppAssets.sleepNotification,
              //     fit: BoxFit.scaleDown,
              //   ),
              //   title: const Text(
              //     AppTexts.sleep,
              //     style: TextStyle(
              //         fontFamily: AppTextStyles.fontFamily,
              //         fontSize: 16,
              //         fontWeight: FontWeight.w400,
              //         color: AppColors.gray1),
              //   ),
              //   subtitle: Text(
              //     '12:00 AM',
              //     style: AppTextStyles.formalTextStyle(
              //       color: const Color(0xFF7B6F72),
              //       fontSize: 8,
              //     ),
              //   ),
              //   trailing: Obx(() => CupertinoSwitch(
              //         value: controller.sleep.value,
              //         onChanged: ((value) {
              //           controller.sleepSwitch(value);
              //         }),
              //         thumbColor: AppColors.white,
              //         trackColor: AppColors.lightBlue,
              //         activeColor: AppColors.blue,
              //       )),
              //   onTap: () {
              //     Get.to(
              //         () => const NotificationDetialPage(title: AppTexts.sleep),
              //         binding: NotificationDetialBinding());
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
