import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/splash/splash_page/splash_page.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

import '../../common/app_assets.dart';
import '../../common/app_colors.dart';
import '../../common/app_texts.dart';

class NotFoundWifiPage extends StatelessWidget {
  const NotFoundWifiPage({super.key, required this.isFromSplash});
  final bool isFromSplash;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.3,
              width: width,
              child: SvgPicture.asset(
                AppAssets.notFoundWifi,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: height * 0.12,
            ),
            Text(
              AppTexts.noConnectionText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
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
                  if (isFromSplash) {
                    Get.off(() => const SplashPage());
                  } else {
                    customSnackbar(
                        title: AppTexts.error,
                        message: "No Internet Connection");
                  }
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
                        color: Theme.of(context)
                            .appBarTheme
                            .titleTextStyle!
                            .color!,
                        fontSize: 14,
                        fontFamily: AppTextStyles.fontFamily,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: height * 0.04,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Icon(
            //       Icons.mail_outline,
            //       color: AppColors.buttonColor,
            //     ),
            //     Padding(
            //       padding: EdgeInsets.only(left: width * 0.01),
            //       child: const Text(
            //         AppTexts.emailWifiPageText,
            //         textAlign: TextAlign.center,
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontSize: 14,
            //           decoration: TextDecoration.underline,
            //           fontFamily: AppTextStyles.fontFamily,
            //           fontWeight: FontWeight.w400,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
