import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/cbt/cbt_question/binding/cbt_ques_binding.dart';
import 'package:weight_loss_app/modules/cbt/cbt_question/view/cbt_ques_page.dart';
import 'package:weight_loss_app/modules/cbt/model/cbt_questions_model.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_button_widget.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';

class CBTSummary extends StatefulWidget {
  const CBTSummary({super.key, required this.cbtQuestionsList});
  final List<CBTQuestionsModel> cbtQuestionsList;

  @override
  State<CBTSummary> createState() => _CBTSummaryState();
}

class _CBTSummaryState extends State<CBTSummary> {
  late PageController pageController;
  List<String> chunks() {
    List<String> words = widget.cbtQuestionsList[0].title!.summary!.split(' ');
    List<String> pages = [];

    for (int i = 0; i < words.length; i += 80) {
      int endIndex = i + 80;
      endIndex = endIndex > words.length ? words.length : endIndex;
      pages.add(words.sublist(i, endIndex).join(' '));
    }

    return pages;
  }

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    double height = size.height;
    double width = size.width;
    // List<String> chunks = widget.cbtQuestionsList[0].title!.summary!.split(' ');

    return Scaffold(
      body: InternetCheckWidget<ConnectivityService>(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: chunks().length,
                  itemBuilder: (context, index) {
                    return SummaryWidget(
                      imageUrl: widget.cbtQuestionsList[0].title!.image,
                      summaryDescription: chunks()[index],
                      title: widget.cbtQuestionsList[0].title!.title ??
                          'Topic name',
                      index: index,
                    );
                  },
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButtonWidget(
                    height: height * 0.055,
                    width: width * 0.4,
                    text: "Previous",
                    onPressed: () {
                      pageController.page!.toInt() == 0
                          ? Get.back()
                          : pageController.previousPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.linear,
                            );
                    },
                  ),
                  CustomButtonWidget(
                    height: height * 0.055,
                    width: width * 0.4,
                    text: "Next",
                    onPressed: () {
                      if (pageController.page!.toInt() == chunks().length - 1) {
                        Get.off(
                          CbtQuestionPage(
                              cbtQuestionsList: widget.cbtQuestionsList),
                          binding: CbtQuestionBinding(),
                        );
                      } else {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.linear,
                        );
                      }
                    },
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SummaryWidget extends StatelessWidget {
  const SummaryWidget(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.summaryDescription,
      required this.index});
  final String? imageUrl;
  final String title;
  final String summaryDescription;
  final int index;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    double height = size.height;
    double width = size.width;
    // print("${ApiUrls.s3ImageBaseUrl}CBT/$imageUrl");
    return Column(
      children: [
        SizedBox(
          height: height * 0.28,
          width: width,
          child: imageUrl == null
              ? Image.asset(
                  AppAssets.cbtSummaryImgUrl,
                  fit: BoxFit.contain,
                )
              : S3LoadingImage(
                  imageUrl: "${ApiUrls.s3ImageBaseUrl}CBT/$imageUrl",
                  fit: BoxFit.contain,
                ),
        ),
        index == 0
            ? SizedBox(
                height: height * 0.02,
              )
            : const SizedBox(),
        index == 0
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Html(
                  data: title
                      .replaceAll("\n", "")
                      .replaceAll("\r", "")
                      .replaceAll("\\", "")
                      .replaceAll("Â", ""),
                  style: {
                    'body': Style(
                        // textAlign: TextAlign.justify,
                        fontFamily: AppTextStyles.fontFamily,
                        color: AppColors.buttonColor,
                        fontSize: FontSize(20),
                        fontWeight: FontWeight.bold),
                  },
                ),
              )
            : const SizedBox.shrink(),
        SizedBox(
          height: height * 0.01,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Html(
                data: summaryDescription
                    .replaceAll("\n", "")
                    .replaceAll("\r", "")
                    .replaceAll("\\", "")
                    .replaceAll("Â", ""),
                shrinkWrap: true,
                onLinkTap: (url, attributes, element) async {
                  try {
                    await launchUrl(Uri.parse(url!));
                  } catch (e) {
                    log(e.toString());
                  }
                },
                style: {
                  'body': Style(
                    fontFamily: AppTextStyles.fontFamily,
                    fontSize: FontSize(16),
                    textAlign: TextAlign.justify,
                  ),
                  // "b": Style(fontWeight: FontWeight.w600,color: AppColors.buttonColor),
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
