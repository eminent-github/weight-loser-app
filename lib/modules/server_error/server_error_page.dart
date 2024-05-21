import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/splash/splash_page/splash_page.dart';
import 'package:weight_loss_app/modules/technical_support_chat/binding/technical_support_binding.dart';
import 'package:weight_loss_app/modules/technical_support_chat/view/technical_support_page.dart';

class ServerErrorPage extends StatelessWidget {
  const ServerErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.3,
              width: width,
              child: Image.asset(
                AppAssets.serverErrorUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: height * 0.12,
            ),
            const Text(
              "Server Error",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: AppTextStyles.fontFamily,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Get.off(() => SplashPage());
                },
                child: Container(
                  height: height * 0.042,
                  width: width * 0.3,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.borderColor,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      AppTexts.tryAgainText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.buttonColor,
                        fontSize: 14,
                        fontFamily: AppTextStyles.fontFamily,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.08,
            ),
            SizedBox(
              height: height * 0.07,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => const TechnicalSupportChatPage(),
                      binding: TechnicalSupportBinding(
                        isFromLogin: false,
                      ));
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(AppColors.buttonColor)),
                child: const Text(
                  'Contact with Technical Support',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: AppTextStyles.fontFamily,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
