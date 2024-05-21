import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:weight_loss_app/modules/authentication/widgets/passsword_textfield.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/app_logo.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';
import '../../../../common/app_assets.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';
import '../../../../widgets/custom_large_button.dart';
import '../../widgets/custom_textformfield.dart';
import '../../forget/binding/forget_binding.dart';
import '../../forget/view/forget_page.dart';
import '../../signup/binding/signup_binding.dart';
import '../../signup/view/signup_page.dart';
import '../../widgets/social_button.dart';
import '../controller/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    double height = size.height;
    double width = size.width;

    return Scaffold(
      body: InternetCheckWidget<ConnectivityService>(
        child: Obx(
          () => Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.03,
                          ),
                          const AppLogo(),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          const Text(
                            AppTexts.signUpPText,
                            style: TextStyle(
                              fontFamily: AppTextStyles.fontFamily,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.07,
                          ),
                          CustomTextFormField(
                            prefixIcon: Icons.email,
                            focusNode: controller.emailFocusNode,
                            controller:
                                controller.emailTextEditingController.value,
                            labelText: AppTexts.textFieldEmailAddress,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(
                            height: height * 0.025,
                          ),
                          CustomPasswordTextField(
                            obscuringCharacter: '*',
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            obscureText: controller.passwordVisible.value,
                            focusNode: controller.passwordFocusNode,
                            controller:
                                controller.passwordTextEditingController.value,
                            labelText: AppTexts.textFieldPassword,
                            prefixIcon: Icons.lock_outlined,
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                controller.passwordVisible.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColors.iconColor,
                                size: height * 0.035,
                              ),
                              onPressed: () {
                                if (controller.passwordVisible.value == false) {
                                  controller.passwordVisible.value = true;
                                } else {
                                  controller.passwordVisible.value = false;
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                Get.to(
                                  () => const ForgetPage(true),
                                  binding: ForgetBinding(),
                                );
                              },
                              child: const Text(
                                AppTexts.forgetPasswordTextForget,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: AppTextStyles.fontFamily,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.028,
                          ),
                          CustomLargeButton(
                            height: height,
                            width: width * 0.7,
                            text: AppTexts.loginButtonText,
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              controller.validateAndCallLoginApi(context);
                            },
                          ),
                          SizedBox(
                            height: height * 0.025,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppTexts.loginDotHaveAnAccountText,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: AppTextStyles.fontFamily,
                                  color: AppColors.iconColor,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.off(
                                    () => const SignUpPage(),
                                    binding: SignUpBinding(),
                                  );
                                },
                                child: Text(
                                  AppTexts.loginSignUpText,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: AppTextStyles.fontFamily,
                                    // decoration: TextDecoration.underline,
                                    textBaseline: TextBaseline.alphabetic,
                                    color: AppColors.buttonColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.06,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  height: 1,
                                  color: AppColors.greyDim,
                                ),
                              ),
                              const Expanded(
                                flex: 4,
                                child: Text(
                                  AppTexts.loginOrLoginWithText,
                                  style: TextStyle(
                                    fontFamily: AppTextStyles.fontFamily,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  height: 1,
                                  color: AppColors.greyDim,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SocialButton(
                                height: height,
                                width: width,
                                iconPath: AppAssets.googleIcon,
                                callback: () {
                                  controller.googleSign(context);
                                },
                              ),
                              Platform.isIOS
                                  ? SocialButton(
                                      height: height,
                                      width: width,
                                      iconPath: AppAssets.appleIcon,
                                      callback: () {
                                        controller.appleSignIn(context);
                                      },
                                    )
                                  : const SizedBox.shrink(),
                              SocialButton(
                                height: height,
                                width: width,
                                iconPath: AppAssets.facebookIcon,
                                // iconColor: AppColors.blueAccentColor,
                                callback: () {
                                  controller.facebookSignIn(context);
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              controller.isLoading.value
                  ? const OverlayWidget()
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
