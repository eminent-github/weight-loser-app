import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';

import '../../../../common/app_assets.dart';
import '../../../../common/app_colors.dart';
import '../../../widgets/custom_large_button.dart';

class WorkoutCompletePage extends StatelessWidget {
  const WorkoutCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: InternetCheckWidget<ConnectivityService>(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.2,
              ),
              SizedBox(
                height: height * 0.3,
                child: Lottie.asset(
                  AppAssets.cbtSuccessUrl,
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "You've put in ",
                      style: AppTextStyles.formalTextStyle(
                        fontSize: 26,
                      ),
                    ),
                    TextSpan(
                      text: 'great effort!',
                      style: TextStyle(
                        color: AppColors.buttonColor,
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.15,
              ),
              CustomLargeButton(
                height: height,
                width: width * 0.65,
                text: "Finish",
                borderRadius: BorderRadius.circular(15),
                onPressed: () {
                  Get.until((route) => Get.currentRoute == "/DashboaredPage");
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
