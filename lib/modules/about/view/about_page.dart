import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/widgets/app_logo.dart';
import '../../../common/app_colors.dart';
import '../../../common/app_texts.dart';
import '../controller/about_controller.dart';

class AboutPage extends GetView<AboutController> {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double height = screenSize.height;
    double width = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: height * 0.1,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: width,
            ),
            const AppLogo(),
            SizedBox(
              height: height * 0.05,
            ),
            Text(
              AppTexts.versionText,
              style: TextStyle(
                color: AppColors.buttonColor,
                fontSize: 18,
                fontFamily: AppTextStyles.fontFamily,
                fontWeight: FontWeight.w700,
                height: 0.89,
              ),
            ),
            SizedBox(
              height: height * 0.025,
            ),
            Text(
              AppTexts.allRightReversedText,
              style: TextStyle(
                color: Theme.of(context).primaryTextTheme.titleMedium!.color,
                fontSize: 18,
                fontFamily: AppTextStyles.fontFamily,
                fontWeight: FontWeight.w400,
                height: 0.89,
              ),
            ),
            SizedBox(
              height: height * 0.25,
            )
          ],
        ),
      ),
    );
  }
}
