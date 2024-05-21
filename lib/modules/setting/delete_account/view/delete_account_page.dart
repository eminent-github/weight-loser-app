import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/authentication/forget/binding/forget_binding.dart';
import 'package:weight_loss_app/modules/authentication/forget/view/forget_page.dart';
import 'package:weight_loss_app/modules/setting/delete_account/controller/delete_account_controller.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_texts.dart';

class DeleteAccountPage extends GetView<DeleteAccountController> {
  const DeleteAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        title: Text(
          'Delete Account',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: InternetCheckWidget<ConnectivityService>(
        child: Obx(
          () => Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.03,
                        ),
                        SizedBox(
                          width: width * 0.75,
                          height: height * 0.48,
                          child: AutoSizeText.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text:
                                      "We're genuinely sorry to see you go. Your presence has held significant value for us. It's crucial to note that this choice marks a final and irreversible step. Regrettably, we won't be able to recover your account and its associated data in the case of any change of mind. If you are sure of your decision, please enter your password below and click ",
                                ),
                                TextSpan(
                                  text: "'Delete My Account'",
                                  style: AppTextStyles.formalTextStyle(
                                    color: const Color(0xFFD80F0F),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const TextSpan(
                                  text:
                                      " to make an account deletion request. To confirm, kindly check your provided email. If youve forgotten your password, please click 'Forgot Password' for further assistance. We're committed to enhancing our services and will try to meet your needs. Thank you for being a valuable part of WeightLoser.",
                                ),
                              ],
                            ),
                            style: AppTextStyles.formalTextStyle(
                              fontSize: 13,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium!
                                  .color!,
                            ),
                            maxFontSize: 13,
                            minFontSize: 9,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: width * 0.08),
                            child: Text(
                              AppTexts.enterYourPasswordDeleteAccountText,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .titleMedium!
                                    .color!,
                                fontSize: 12,
                                fontFamily: AppTextStyles.fontFamily,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Container(
                          height: height * 0.07,
                          width: width * 0.85,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: AppColors.deleteAccountTextFieldColor,
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: width * 0.05),
                                    child: TextFormField(
                                      obscuringCharacter: '*',
                                      obscureText: controller
                                          .confirmPasswordVisible.value,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                          RegExp(r'^[a-zA-Z0-9!@#$*]+$'),
                                        ),
                                      ],
                                      textInputAction: TextInputAction.done,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      controller: controller.passwordController,
                                      style: const TextStyle(
                                        color: Color(0xFF0F1121),
                                        fontSize: 12,
                                        fontFamily: AppTextStyles.fontFamily,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle: TextStyle(
                                          color: Color(0xFF0F1121),
                                          fontSize: 12,
                                          fontFamily: AppTextStyles.fontFamily,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: width * 0.02),
                                  child: IconButton(
                                    icon: Icon(
                                      controller.confirmPasswordVisible.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: AppColors.iconColor,
                                    ),
                                    onPressed: () {
                                      controller.confirmPasswordVisible.value =
                                          !controller
                                              .confirmPasswordVisible.value;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(
                              () => const ForgetPage(false),
                              binding: ForgetBinding(),
                            );
                          },
                          child: Text(
                            "If you've forgotten password?",
                            style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium!
                                  .color!,
                              fontSize: 11,
                              fontFamily: AppTextStyles.fontFamily,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Material(
                          color: AppColors.connectedDeviceButtonColor,
                          borderRadius: BorderRadius.circular(8),
                          child: InkWell(
                            onTap: () {
                              controller.validateAndDelete();
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: SizedBox(
                              height: height * 0.07,
                              width: width * 0.7,
                              child: const Center(
                                child: Text(
                                  AppTexts.deleteYourAccountText,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily: AppTextStyles.fontFamily,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.07,
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
              controller.isLoading.value
                  ? const OverlayWidget()
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
