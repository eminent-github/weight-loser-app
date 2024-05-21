import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/authentication/login/binding/login_binding.dart';
import 'package:weight_loss_app/modules/authentication/login/view/login_page.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_large_button.dart';

import '../controller/stopping_point_controller.dart';

class StoppingPointPage extends GetView<StoppingPointController> {
  const StoppingPointPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height - kToolbarHeight;
    double width = screenSize.width;
    return Scaffold(
      appBar: AppBar(),
      body: InternetCheckWidget<ConnectivityService>(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.stoppingPointImgUrl,
                  height: height * 0.42,
                  width: width * 0.92,
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.07),
                  child: Text(
                    AppTexts.stoppingPointTitleText,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.formalTextStyle(
                      color: AppColors.buttonColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.07),
                  child: Text(
                    "We strongly recommend consulting a physician for weight-related concerns.",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.formalTextStyle(
                      color: AppColors.buttonColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                CustomLargeButton(
                  height: height,
                  width: width * 0.5,
                  text: "Stay tuned!",
                  onPressed: () {
                    Get.offAll(const LoginPage(), binding: LoginBinding());
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
