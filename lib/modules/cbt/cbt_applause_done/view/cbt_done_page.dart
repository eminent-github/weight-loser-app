import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_button_widget.dart';

import '../../../../common/app_assets.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_texts.dart';
import '../controller/cbt_done_controller.dart';

class CbtDonePage extends GetView<CbtDoneController> {
  const CbtDonePage({
    super.key,
    required this.totalOptions,
  });
  final int totalOptions;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    double height = size.height;
    double width = size.width;
    return Scaffold(
      body: InternetCheckWidget<ConnectivityService>(
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: height * 0.1,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Text(
                      AppTexts.greatWorkText,
                      style: TextStyle(
                        color: AppColors.buttonColor,
                        fontSize: 32,
                        fontFamily: AppTextStyles.fontFamily,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(
                      "You got $totalOptions out of $totalOptions",
                      style: TextStyle(
                        color: Theme.of(context)
                            .primaryTextTheme
                            .titleMedium!
                            .color!,
                        fontSize: 18,
                        fontFamily: AppTextStyles.fontFamily,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.08,
                    ),
                    CustomButtonWidget(
                      height: height * 0.06,
                      width: width * 0.5,
                      text: AppTexts.doneText,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SvgPicture.asset(
                  AppAssets.cbtDoneSvgUrl,
                  width: width,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
