import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/modules/setting/change_password/controller/change_password_controller.dart';
import 'package:weight_loss_app/modules/setting/change_password/widgets/custom_password_field.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';

class ChangePasswordPage extends GetView<ChangePasswordController> {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        title: Text(
          AppTexts.changePassword,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
      ),
      body: InternetCheckWidget<ConnectivityService>(
        child: Obx(
          () => Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.06,
                      ),
                      CustomChangePasswordTextField(
                        obscuringCharacter: '*',
                        focusNode: controller.currentPasswordFocusNode,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^[a-zA-Z0-9!@#$*]+$'),
                          ),
                        ],
                        textInputAction: TextInputAction.next,
                        controller: controller
                            .currentPasswordTextEditingController.value,
                        labelText: AppTexts.enterCurrentPasswordTextField,
                        prefixIcon: Icons.lock_outlined,
                        // suffixIcon: IconButton(
                        //   icon: Icon(
                        //     // Based on passwordVisible state choose the icon
                        //     controller.currentPasswordVisible.value
                        //         ? Icons.visibility_off
                        //         : Icons.visibility,
                        //     color: AppColors.iconColor,
                        //   ),
                        //   onPressed: () {
                        //     if (controller.currentPasswordVisible.value ==
                        //         false) {
                        //       controller.currentPasswordVisible.value = true;
                        //     } else {
                        //       controller.currentPasswordVisible.value = false;
                        //     }
                        //   },
                        // ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      CustomChangePasswordTextField(
                        obscuringCharacter: '*',
                        focusNode: controller.newPasswordFocusNode,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^[a-zA-Z0-9!@#$*]+$'),
                          ),
                        ],
                        textInputAction: TextInputAction.next,
                        controller: controller
                            .setNewPasswordTextEditingController.value,
                        labelText: AppTexts.setNewPasswordTextField,
                        prefixIcon: Icons.lock_outlined,
                        // suffixIcon: IconButton(
                        //   icon: Icon(
                        //     // Based on newPasswordVisible state choose the icon
                        //     controller.newPasswordVisible.value
                        //         ? Icons.visibility_off
                        //         : Icons.visibility,
                        //     color: AppColors.iconColor,
                        //   ),
                        //   onPressed: () {
                        //     if (controller.newPasswordVisible.value == false) {
                        //       controller.newPasswordVisible.value = true;
                        //     } else {
                        //       controller.newPasswordVisible.value = false;
                        //     }
                        //   },
                        // ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      CustomChangePasswordTextField(
                        obscuringCharacter: '*',
                        focusNode: controller.confirmPasswordFocusNode,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^[a-zA-Z0-9!@#$*]+$'),
                          ),
                        ],
                        textInputAction: TextInputAction.done,
                        controller: controller
                            .confirmPasswordTextEditingController.value,
                        labelText: AppTexts.confirmNewPasswordTextField,
                        prefixIcon: Icons.lock_outlined,
                        // suffixIcon: IconButton(
                        //   icon: Icon(
                        //     // Based on confirmPasswordVisible state choose the icon
                        //     controller.confirmPasswordVisible.value
                        //         ? Icons.visibility_off
                        //         : Icons.visibility,
                        //     color: AppColors.iconColor,
                        //   ),
                        //   onPressed: () {
                        //     if (controller.confirmPasswordVisible.value ==
                        //         false) {
                        //       controller.confirmPasswordVisible.value = true;
                        //     } else {
                        //       controller.confirmPasswordVisible.value = false;
                        //     }
                        //   },
                        // ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Container(
                        height: height * 0.002,
                        width: width * 0.8,
                        color: AppColors.passwordDividerColor,
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.power_settings_new,
                              size: 26,
                              color: AppColors.buttonColor,
                            ),
                            SizedBox(
                              width: width * 0.8,
                              child: Padding(
                                padding: EdgeInsets.only(left: width * 0.04),
                                child: Text(
                                  AppTexts.changePasswordParagraph,
                                  // textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: AppColors.buttonColor,
                                    fontSize: 14,
                                    fontFamily: AppTextStyles.fontFamily,
                                    fontWeight: FontWeight.w400,
                                    height: 1.71,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.1,
                      ),
                      Material(
                        color: AppColors.buttonColor,
                        borderRadius: BorderRadius.circular(30),
                        child: InkWell(
                          onTap: () {
                            controller.validateAndCallChangePasswordApi();
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: SizedBox(
                            height: height * 0.07,
                            width: width * 0.8,
                            child: const Center(
                              child: Text(
                                AppTexts.changePassword,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: AppTextStyles.fontFamily,
                                  fontWeight: FontWeight.w600,
                                  height: 1.62,
                                  letterSpacing: -0.16,
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
              controller.isLoading.value
                  ? OverlayWidget()
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
