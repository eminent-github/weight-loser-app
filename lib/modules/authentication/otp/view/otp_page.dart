import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/authentication/otp/controller/otp_controller.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

import '../../../../common/app_assets.dart';
import '../../../../common/app_colors.dart';
import '../../../../widgets/custom_large_button.dart';

class OtpPage extends GetView<OtpController> {
  const OtpPage({
    super.key,
    required this.email,
    required this.isSignup,
  });
  final String email;
  final bool isSignup;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    double height = size.height;
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
      body: InternetCheckWidget<ConnectivityService>(
        child: Obx(
          () => Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.14,
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
                                    'Please enter the 4 digit code sent to : ',
                                style: AppTextStyles.formalTextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              TextSpan(
                                text: email,
                                style: AppTextStyles.formalTextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.justify,
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
                          controller.focusNode.unfocus();
                          controller.validateAndCallOtpApi(isSignup);
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
                        height: height * 0.005,
                      ),
                      TextButton(
                        onPressed: controller.otpCounter >= 3
                            ? () {}
                            : () {
                                controller.resendOtpApi();
                              },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                          ),
                        ),
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
                    ],
                  ),
                ),
              ),
              controller.isLoading.value
                  ? OverlayWidget(
                      height: height,
                      width: width,
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
