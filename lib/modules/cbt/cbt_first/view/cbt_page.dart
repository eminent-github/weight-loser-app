import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_button_widget.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

import '../../../../common/app_assets.dart';
import '../../../../common/app_texts.dart';
import '../controller/cbt_controller.dart';

class CbtPage extends GetView<CbtController> {
  const CbtPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        toolbarHeight: height * 0.1,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        title: AutoSizeText(
          AppTexts.cognitiveBehavioralText,
          maxLines: 1,
          minFontSize: 15,
          style: TextStyle(
            color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
            fontSize: 21,
            fontFamily: AppTextStyles.fontFamily,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: InternetCheckWidget<ConnectivityService>(
        child: Obx(
          () => Stack(
            children: [
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.07,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.25,
                        child: SvgPicture.asset(
                          AppAssets.cbtImageSvg,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            "Change your thoughts and you change your world.",
                            minFontSize: 10,
                            maxLines: 2,
                            style: TextStyle(
                              color: AppColors.buttonColor,
                              fontSize: 19,
                              fontFamily: AppTextStyles.fontFamily,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          SizedBox(
                            height: height * 0.31,
                            child: SingleChildScrollView(
                              child: Text(
                                "Weight Loser introduces you to Cognitive Behavioral techniques, a powerful approach to transform negative thoughts into positive actions. Cultivate mindfulness, conquer self-limiting beliefs, and embark on a journey to a stronger, healthier, and more resilient version of yourself through the transformative power of Behavioral Techniques.",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .titleMedium!
                                      .color!,
                                  fontSize: 16,
                                  fontFamily: AppTextStyles.fontFamily,
                                  fontWeight: FontWeight.w400,
                                  height: 1.89,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      CustomButtonWidget(
                        height: height * 0.055,
                        width: width * 0.4,
                        text: AppTexts.cbtStart,
                        onPressed: () {
                          controller.cbtQusApi();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              controller.isLoading.value
                  ? const OverlayWidget()
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
