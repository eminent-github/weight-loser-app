import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/authentication/forget_otp/controller/forget_otp_controller.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_large_button.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

class ForgetOtpPage extends GetView<ForgetOtpController> {
  const ForgetOtpPage({
    super.key,
    required this.token,
    required this.email,
    required this.isLogin,
  });
  final String token;
  final String email;
  final bool isLogin;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    double height = size.height - kToolbarHeight;
    double width = size.width;
    var defaultPinTheme = PinTheme(
      height: height * 0.1,
      width: width * 0.15,
      textStyle: TextStyle(
        fontSize: height * 0.035,
        fontFamily: AppTextStyles.fontFamily,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: height * 0.004, color: AppColors.otpColor),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(),
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
                          height: height * 0.12,
                        ),
                        SizedBox(
                            height: height * 0.3,
                            child: SvgPicture.asset(AppAssets.otpSvg)),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        SizedBox(
                          width: width * 0.8,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      'To reset your password, please enter the 4 digit code sent to : ',
                                  style: AppTextStyles.formalTextStyle(
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .titleMedium!
                                        .color!,
                                    fontSize: 15,
                                  ),
                                ),
                                TextSpan(
                                  text: email,
                                  style: AppTextStyles.formalTextStyle(
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .titleMedium!
                                        .color!,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            // textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.1,
                          child: Pinput(
                            controller: controller.pinController,
                            focusNode: controller.focusNode,
                            defaultPinTheme: defaultPinTheme,
                            separatorBuilder: (index) =>
                                SizedBox(width: width * 0.07),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^[0-9]+$'),
                              ),
                            ],
                            focusedPinTheme: defaultPinTheme.copyBorderWith(
                              border: Border(
                                bottom: BorderSide(
                                    width: height * 0.004,
                                    color: AppColors.buttonColor),
                              ),
                            ),
                            closeKeyboardWhenCompleted: true,
                            obscureText: false,
                            autofocus: true,
                            onTap: () {
                              controller.focusNode.requestFocus();
                            },
                          ),
                        ),
                        SizedBox(
                          height: height * 0.06,
                        ),
                        CustomLargeButton(
                          height: height * 0.85,
                          width: width * 0.55,
                          text: 'Submit',
                          onPressed: () {
                            controller.validateAndCallOtpApi(isLogin);
                          },
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        const Text(
                          AppTexts.otpDidNotReceive,
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: AppTextStyles.fontFamily,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        SizedBox(
                          height: height * 0.04,
                          child: TextButton(
                            onPressed: controller.otpCounter >= 3
                                ? () {}
                                : () {
                                    controller.resendOtpApi(token);
                                  },
                            child: Text(
                              AppTexts.otpResendIt,
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: AppTextStyles.fontFamily,
                                color: controller.otpCounter >= 3
                                    ? AppColors.gray1
                                    : AppColors.buttonColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              controller.isLoading.value ? const OverlayWidget() : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
