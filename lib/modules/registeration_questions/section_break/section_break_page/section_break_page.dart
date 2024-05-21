import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_large_button.dart';

import '../../../../common/app_assets.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';
import '../controller/section_break_controller.dart';

class SectionBreakPage extends GetView<SectionBreakController> {
  const SectionBreakPage({super.key});
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double height = screenSize.height;
    double width = screenSize.width;
    return Scaffold(
      body: InternetCheckWidget<ConnectivityService>(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: height * 0.45,
                width: width,
                color: AppColors.understandWidgetColor,
                padding: EdgeInsets.all(height * 0.07),
                child: SvgPicture.asset(
                  AppAssets.eatingHealthyIconUrl,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Text(
                  AppTexts.dietFoundation,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppTextStyles.fontFamily,
                    fontSize: height * 0.027,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blue,
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                child: const Text(
                  AppTexts.goalSupport,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppTextStyles.fontFamily,
                    fontSize: 16,
                    color: AppColors.darkGray,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              CustomLargeButton(
                height: height,
                width: width * 0.65,
                onPressed: () {},
                text: AppTexts.started,
              ),
              SizedBox(
                height: height * 0.08,
              ),
              Text(
                AppTexts.sectionBreakTrialText,
                style: AppTextStyles.formalTextStyle(
                  color: AppColors.darkGray,
                  fontSize: 13,
                ),
              ),
              SizedBox(
                height: height * 0.005,
              ),
              Text(
                AppTexts.sectionBreakDiveText,
                style: AppTextStyles.formalTextStyle(
                  color: AppColors.darkGray,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
