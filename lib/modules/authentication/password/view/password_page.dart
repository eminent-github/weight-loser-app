import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/authentication/password/widgets/new_password_widget.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';
import '../../../../common/app_assets.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../widgets/custom_large_button.dart';
import '../controller/password_controller.dart';

class PasswordPage extends GetView<PasswordController> {
  const PasswordPage({
    super.key,
    required this.token,
    required this.isLogin,
  });
  final String token;
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height - kToolbarHeight;
    double width = screenSize.width;
    return InternetCheckWidget<ConnectivityService>(
      child: Scaffold(
        appBar: AppBar(),
        body: Obx(() {
          return Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.07,
                      ),
                      SizedBox(
                          height: height * 0.33,
                          child: Image.asset(AppAssets.password)),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Center(
                        child: SizedBox(
                          width: width * 0.8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Set up a new password of at least 6 characters long",
                                style: TextStyle(
                                    fontFamily: AppTextStyles.fontFamily,
                                    color: AppColors.buttonColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              SizedBox(
                                height: height * 0.04,
                              ),
                              const Text(AppTexts.newPasswordText,
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w400,
                                  )),
                              SizedBox(
                                height: height * 0.006,
                              ),
                              CustomShadowNewPasswordTextField(
                                obscuringCharacter: '*',
                                obscureText: controller.passwordVisible.value,
                                focusNode: controller.passwordFocusNode,
                                controller: controller
                                    .passwordTextEditingController.value,
                                labelText: AppTexts.textFieldPassword,
                                prefixIcon: Icons.password,
                                iconColor: AppColors.buttonColor,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^[a-zA-Z0-9@#$]+$'),
                                  ),
                                ],
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    controller.passwordVisible.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: AppColors.iconColor,
                                  ),
                                  onPressed: () {
                                    if (controller.passwordVisible.value ==
                                        false) {
                                      controller.passwordVisible.value = true;
                                    } else {
                                      controller.passwordVisible.value = false;
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              const Text(AppTexts.confirmPasswordText,
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w400,
                                  )),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              CustomShadowNewPasswordTextField(
                                obscuringCharacter: '*',
                                obscureText:
                                    controller.confirmPasswordVisible.value,
                                focusNode: controller.confirmPasswordFocusNode,
                                controller: controller
                                    .confirmPasswordTextEditingController.value,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^[a-zA-Z0-9@#$]+$'),
                                  ),
                                ],
                                labelText: AppTexts.confirmPasswordText,
                                prefixIcon: Icons.password,
                                iconColor: AppColors.buttonColor,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    // Based on confirmPasswordVisible state choose the icon
                                    controller.confirmPasswordVisible.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: AppColors.iconColor,
                                  ),
                                  onPressed: () {
                                    if (controller
                                            .confirmPasswordVisible.value ==
                                        false) {
                                      controller.confirmPasswordVisible.value =
                                          true;
                                    } else {
                                      controller.confirmPasswordVisible.value =
                                          false;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      CustomLargeButton(
                        height: height,
                        width: width * 0.55,
                        text: 'Save',
                        onPressed: () {
                          controller.validateAndCallNewPasswordApi(
                              token, isLogin);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              controller.isLoading.value
                  ? const OverlayWidget()
                  : const SizedBox(),
            ],
          );
        }),
      ),
    );
  }
}
