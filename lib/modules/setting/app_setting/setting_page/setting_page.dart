import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_detail/binding/payment_detail_binding.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_detail/payment_detail_page/payment_detail_page.dart';
import 'package:weight_loss_app/modules/refund/binding/refund_binding.dart';
import 'package:weight_loss_app/modules/refund/refund_page/refund_page.dart';
import 'package:weight_loss_app/modules/setting/account/account_page/account_page.dart';
import 'package:weight_loss_app/modules/setting/account/binding/account_binding.dart';
import 'package:weight_loss_app/modules/setting/appearance/binding/appearance_binding.dart';
import 'package:weight_loss_app/modules/setting/change_password/binding/change_password_binding.dart';
import 'package:weight_loss_app/modules/setting/change_password/view/change_password_page.dart';
import 'package:weight_loss_app/modules/setting/notifications/binding/notification_binding.dart';
import 'package:weight_loss_app/modules/setting/notifications/notifications_page/notifications_page.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';
import '../../appearance/view/appearance_page.dart';

class SettingPage extends GetView {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        title: Text(
          AppTexts.settings,
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
                height: height * 0.055,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => const AccountPage(), binding: AccountBinding());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  height: height * 0.087,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    border: Border.all(
                        color: Theme.of(context)
                            .cardTheme
                            .color!
                            .withOpacity(0.2)),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppTexts.account,
                        style: TextStyle(
                          fontFamily: AppTextStyles.fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .titleMedium!
                              .color,
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_right,
                        color: AppColors.blue,
                        size: 28,
                      ),
                    ],
                  ),
                ),
              ),
              Platform.isAndroid
                  ? SizedBox(
                      height: height * 0.025,
                    )
                  : const SizedBox.shrink(),
              Platform.isAndroid
                  ? GestureDetector(
                      onTap: () {
                        Get.to(() => const NotificationsPage(),
                            binding: NotificationBinding());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                        height: height * 0.087,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context)
                                  .cardTheme
                                  .color!
                                  .withOpacity(0.2)),
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppTexts.notification,
                              style: TextStyle(
                                fontFamily: AppTextStyles.fontFamily,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .titleMedium!
                                    .color,
                              ),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_right,
                              color: AppColors.blue,
                              size: 28,
                            )
                          ],
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              SizedBox(
                height: height * 0.025,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => const AppearancePage(),
                      binding: AppearanceBinding());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  height: height * 0.087,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context)
                            .cardTheme
                            .color!
                            .withOpacity(0.2)),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppTexts.appearance,
                        style: TextStyle(
                          fontFamily: AppTextStyles.fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .titleMedium!
                              .color,
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_right,
                        color: AppColors.blue,
                        size: 28,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.025,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => const ChangePasswordPage(),
                      binding: ChangePasswordBinding());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  height: height * 0.087,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context)
                            .cardTheme
                            .color!
                            .withOpacity(0.2)),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppTexts.password,
                        style: TextStyle(
                          fontFamily: AppTextStyles.fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .titleMedium!
                              .color,
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_right,
                        color: AppColors.blue,
                        size: 28,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.025,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => const PaymentDetailPage(),
                      binding: PaymentDetailBinding());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  height: height * 0.087,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context)
                            .cardTheme
                            .color!
                            .withOpacity(0.2)),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment detail",
                        style: TextStyle(
                          fontFamily: AppTextStyles.fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .titleMedium!
                              .color,
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_right,
                        color: AppColors.blue,
                        size: 28,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.025,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => const RefundPage(), binding: RefundBinding());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  height: height * 0.087,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context)
                            .cardTheme
                            .color!
                            .withOpacity(0.2)),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Request a refund",
                        style: TextStyle(
                          fontFamily: AppTextStyles.fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .titleMedium!
                              .color,
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_right,
                        color: AppColors.blue,
                        size: 28,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
