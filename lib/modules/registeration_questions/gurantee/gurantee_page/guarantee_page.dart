import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/modules/payment_integration/regular_price/binding/regular_price_binding.dart';
import 'package:weight_loss_app/modules/payment_integration/regular_price/regular_price_page/regular_price_page.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_large_button.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';
import '../../../../widgets/app_logo.dart';
import '../contoller/guarantee_controller.dart';

class GuaranteePage extends GetView<GuaranteeController> {
  const GuaranteePage({super.key});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height - kToolbarHeight;
    double width = size.width;
    // double textSize = min(width, height);
    return Scaffold(
      appBar: AppBar(),
      body: InternetCheckWidget<ConnectivityService>(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Center(
                  child: AppLogo(),
                ),
                SizedBox(
                  height: height * 0.045,
                ),
                Container(
                  width: width * 0.84,
                  height: height * 0.065,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.understandWidgetBorderColor,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(2.0))),
                  child: const Center(
                    child: AutoSizeText(
                      AppTexts.weightGuarantee,
                      style: TextStyle(
                          color: AppColors.blue,
                          fontFamily: AppTextStyles.fontFamily,
                          fontSize: 23,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                const Center(
                  child: Text(
                    AppTexts.moneyGuarantee,
                    style: TextStyle(
                        fontFamily: AppTextStyles.fontFamily,
                        fontSize: 18,
                        color: AppColors.sectionGraphDateColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: RichText(
                    text: const TextSpan(children: [
                      TextSpan(
                          text: AppTexts.achiveGoal,
                          style: TextStyle(
                            color: AppColors.grayDark,
                            fontFamily: AppTextStyles.fontFamily,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          )),
                    ]),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  height: height * 0.23,
                  width: width * 0.9,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                          color: AppColors.greyDim.withOpacity(0.6),
                        ),
                        BoxShadow(
                          blurRadius: 1,
                          offset: const Offset(0, -1),
                          color: AppColors.greyDim.withOpacity(0.6),
                        )
                      ],
                      border: Border.all(
                        color: AppColors.white,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0))),
                  child: Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(children: [
                        TextSpan(
                          text: AppTexts.useApp,
                          style: TextStyle(
                            color: AppColors.sectionGraphDateColor,
                            fontFamily: AppTextStyles.fontFamily,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text:
                              "as long as you are minimally compliant with 60% of the plan.",
                          style: TextStyle(
                            color: AppColors.sectionGraphDateColor,
                            fontFamily: AppTextStyles.fontFamily,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                            text: AppTexts.refundMoney,
                            style: TextStyle(
                              color: AppColors.sectionGraphDateColor,
                              fontFamily: AppTextStyles.fontFamily,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            )),
                      ]),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                  child: const Text(
                    AppTexts.startJourney,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.sectionGraphDateColor,
                        fontFamily: AppTextStyles.fontFamily,
                        fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: height * 0.08,
                ),
                CustomLargeButton(
                  onPressed: () {
                    /* -------------------------------------------------------------------------- */
                    /*                                 for testing                                */
                    /* -------------------------------------------------------------------------- */
                    // Get.to(() => const TalkingOathPage(),
                    //     binding: TalkingOathBinding());

                    /* -------------------------------------------------------------------------- */
                    /*                                  real data                                 */
                    /* -------------------------------------------------------------------------- */
                    Get.to(() => const RegularPricePage(isLogin: true),
                        binding: RegularPriceBinding());
                  },
                  text: "Let's Start",
                  height: height,
                  width: width * 0.5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
