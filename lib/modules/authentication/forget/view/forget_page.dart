import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/app_logo.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';
import '../../../../widgets/custom_large_button.dart';
import '../../widgets/custom_textformfield.dart';
import '../controller/forget_controller.dart';

class ForgetPage extends GetView<ForgetController> {
  const ForgetPage(this.isLogin, {super.key});
  final bool isLogin;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    double height = size.height-kToolbarHeight;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(),
      body: InternetCheckWidget<ConnectivityService>(
        child: Obx(
          () => Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                    child: Column(
                      children: [
                        const AppLogo(),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        AutoSizeText(
                          AppTexts.signUpPText,
                          maxLines: 1,
                          minFontSize: 10,
                          style: AppTextStyles.formalTextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .titleMedium!
                                .color!,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.12,
                        ),
                        const Text(
                          AppTexts.forgetPasswordTextForget,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppTextStyles.fontFamily,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        CustomTextFormField(
                          prefixIcon: Icons.email,
                          controller:
                              controller.emailTextEditingController.value,
                          labelText: AppTexts.textFieldEmailAddress,
                          focusNode: controller.emailFocusNode,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        CustomLargeButton(
                          height: height,
                          width: width * 0.7,
                          text: "Send",
                          onPressed: () {
                            controller.validateAndCallOtpApi(
                              isLogin,
                            );
                          },
                        )
                      ],
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
