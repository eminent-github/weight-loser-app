import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/cbt/model/cbt_questions_model.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_button_widget.dart';

class RandomQuestionPage extends StatelessWidget {
  const RandomQuestionPage({super.key, required this.randomOption});
  final CbtSummary randomOption;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    double height = size.height;
    double width = size.width;
    return Scaffold(
      body: InternetCheckWidget<ConnectivityService>(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.08),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Html(
                    data: randomOption.title!
                        .replaceAll("\n", "")
                        .replaceAll("\r", "")
                        .replaceAll("\\", "")
                        .replaceAll("Â", ""),
                    style: {
                      'body': Style(
                          textAlign: TextAlign.center,
                          fontFamily: AppTextStyles.fontFamily,
                          fontSize: FontSize(19),
                          fontWeight: FontWeight.bold),
                    },
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  SizedBox(
                    height: height * 0.35,
                    width: width,
                    child: SvgPicture.asset(
                      AppAssets.cbtRandomSvgUrl,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Html(
                    data: randomOption.summary == null
                        ? "Summary"
                        : randomOption.summary!
                            .replaceAll("\n", "")
                            .replaceAll("\r", "")
                            .replaceAll("\\", "")
                            .replaceAll("Â", ""),
                    onLinkTap: (url, attributes, element) async {
                      try {
                        await launchUrl(Uri.parse(url!));
                      } catch (e) {
                        log(e.toString());
                      }
                    },
                    style: {
                      'body': Style(
                        // textAlign: TextAlign.justify,
                        fontFamily: AppTextStyles.fontFamily,
                        fontSize: FontSize(19),
                      ),
                    },
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  CustomButtonWidget(
                    height: height * 0.055,
                    width: width * 0.4,
                    text: "Next",
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
