import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

import '../../../../common/app_assets.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../widgets/app_logo.dart';
import '../../../../widgets/custom_large_button.dart';
import '../../login/binding/login_binding.dart';
import '../../login/view/login_page.dart';
import '../../widgets/custom_textformfield.dart';
import '../../widgets/passsword_textfield.dart';
import '../../widgets/social_button.dart';
import '../controller/signup_controller.dart';

class SignUpPage extends GetView<SignUpController> {
  const SignUpPage({super.key});

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
                          height: height * 0.02,
                        ),
                        const AppLogo(),
                        SizedBox(
                          height: height * 0.04,
                        ),
                        Text(
                          AppTexts.signUpGText,
                          style: TextStyle(
                              fontFamily: AppTextStyles.fontFamily,
                              color: AppColors.buttonColor,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
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
                          prefixIcon: Icons.person,
                          focusNode: controller.nameFocusNode,
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.text,
                          controller:
                              controller.nameTextEditingController.value,
                          labelText: AppTexts.textFieldYourName,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: height * 0.025,
                        ),
                        CustomTextFormField(
                          prefixIcon: Icons.email,
                          focusNode: controller.emailFocusNode,
                          controller:
                              controller.emailTextEditingController.value,
                          labelText: AppTexts.textFieldEmailAddress,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: height * 0.025,
                        ),
                        Form(
                          key: controller.formkey,
                          child: CustomPasswordTextField(
                            obscuringCharacter: '*',
                            obscureText: controller.passwordVisible.value,
                            focusNode: controller.passwordFocusNode,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^[a-zA-Z0-9!@#$*]+$'),
                              ),
                            ],
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return AppTexts.emptyPassword;
                              } else if (p0.length < 6) {
                                return "Weak password";
                              } else if (!controller.isPasswordValid(p0)) {
                                return "Password needs one special character,one uppercase letter, numbers and alphabets only.";
                              } else {
                                return null;
                              }
                            },
                            controller:
                                controller.passwordTextEditingController.value,
                            labelText: AppTexts.textFieldPassword,
                            keyboardType: TextInputType.visiblePassword,
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
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        CustomLargeButton(
                          height: height,
                          width: width * 0.7,
                          text: AppTexts.signUpButtonText,
                          onPressed: () {
                            var currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            if (controller.formkey.currentState!.validate()) {
                              controller.validateAndCallSignUpApi();
                            }
                          },
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        SizedBox(
                          height: height * 0.05,
                          width: width * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppTexts.signUpAlreadyAccountText,
                                style: TextStyle(
                                  fontFamily: AppTextStyles.fontFamily,
                                  fontSize: 12,
                                  color: AppColors.iconColor,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.off(() => const LoginPage(),
                                      binding: LoginBinding());
                                },
                                child: Text(
                                  AppTexts.signUpLoginText,
                                  style: TextStyle(
                                    fontFamily: AppTextStyles.fontFamily,
                                    fontSize: 15,
                                    textBaseline: TextBaseline.alphabetic,
                                    color: AppColors.buttonColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
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
                                AppTexts.signUpOrSignUpText,
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
                          height: height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SocialButton(
                              height: height,
                              width: width,
                              iconPath: AppAssets.googleIcon,
                              callback: () {
                                controller.googleSign();
                              },
                            ),
                            Platform.isIOS
                                ? SocialButton(
                                    height: height,
                                    width: width,
                                    iconPath: AppAssets.appleIcon,
                                    callback: () async {
                                      controller.appleSignUp(context);
                                    },
                                  )
                                : const SizedBox.shrink(),
                            SocialButton(
                              height: height,
                              width: width,
                              iconPath: AppAssets.facebookIcon,
                              callback: () {
                                controller.facebookSignIn();
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )),
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
