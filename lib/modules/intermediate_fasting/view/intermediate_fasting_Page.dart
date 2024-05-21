import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/modules/intermediate_fasting/controller/intermediate_fasting_controller.dart';
import 'package:weight_loss_app/modules/intermediate_fasting/widgets/custom_fasting_progress/custom_fasting_timer.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_text_styles.dart';
import '../../../common/app_texts.dart';

class IntermediateFastingPage extends GetView<IntermediateFastingController> {
  const IntermediateFastingPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double screenHeight = screenSize.height;
    double height = screenSize.height - kToolbarHeight;
    double width = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: screenHeight * 0.1,
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData(color: AppColors.black),
        elevation: 0,
      ),
      body: InternetCheckWidget<ConnectivityService>(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.01,
              ),
              CircularFastingTimer(
                width: width * 0.45,
                height: height * 0.22,
                controller: controller.countDownController,
                fillColor: AppColors.buttonColor,
                ringColor: AppColors.progressBackgroundColor,
                duration: 60 * 180,
                textStyle: AppTextStyles.formalTextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                isReverse: true,
                strokeCap: StrokeCap.round,
                strokeWidth: 10,
                isReverseAnimation: true,
                iconUrl: AppAssets.fastingSvgUrl,
                startAngleValue: 2,
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                AppTexts.fastingWindowText,
                style: AppTextStyles.formalTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                '10:00 AM - 10:00 PM',
                style: AppTextStyles.formalTextStyle(),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.27),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Material(
                          shape: const CircleBorder(),
                          color: AppColors.intermediateContainerColor,
                          child: InkWell(
                            onTap: controller.togglePlayPause,
                            borderRadius: BorderRadius.circular(50),
                            child: SizedBox(
                              height: height * 0.08,
                              width: width * 0.16,
                              child: Obx(
                                () => Icon(
                                  color: AppColors.buttonColor,
                                  controller.isPlaying.value
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.007,
                        ),
                        Obx(() => Text(
                              controller.isPlaying.value ? 'Playing' : 'Paused',
                              style: AppTextStyles.formalTextStyle(
                                color: AppColors.buttonColor,
                                fontSize: 12,
                              ),
                            )),
                      ],
                    ),
                    Column(
                      children: [
                        Material(
                          shape: const CircleBorder(),
                          color: AppColors.intermediateContainerColor,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () {},
                            child: SizedBox(
                              height: height * 0.08,
                              width: width * 0.16,
                              child: Icon(
                                Icons.access_time_filled_sharp,
                                color: AppColors.buttonColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.007,
                        ),
                        Text(
                          AppTexts.adjustTimeText,
                          style: AppTextStyles.formalTextStyle(
                            color: AppColors.buttonColor,
                            fontSize: 12,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: width * 0.08),
                  child: Text(
                    AppTexts.previousFastingText,
                    style: AppTextStyles.formalTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Expanded(
                child: Stepper(
                  connectorColor: MaterialStatePropertyAll(AppColors.buttonColor),
                  connectorThickness: 2,
                  controlsBuilder: (context, details) => Container(),
                  margin: const EdgeInsets.all(0),
                  stepIconBuilder: (stepIndex, stepState) {
                    return Container(
                      height: height * 0.015,
                      width: width * 0.025,
                      decoration: const BoxDecoration(
                          color: AppColors.white, shape: BoxShape.circle),
                    );
                  },
                  steps: controller.fastingList
                      .map(
                        (e) => Step(
                          title: Container(
                            width: width * 0.75,
                            height: height * 0.07,
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.05),
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(11),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 1),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    e.date,
                                    style: AppTextStyles.formalTextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '${e.hours} Hours',
                                        style: AppTextStyles.formalTextStyle(
                                          color: AppColors.buttonColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Status: ',
                                              style:
                                                  AppTextStyles.formalTextStyle(
                                                fontSize: 8,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            TextSpan(
                                              text: e.status,
                                              style:
                                                  AppTextStyles.formalTextStyle(
                                                color: e.status == "Bad"
                                                    ? AppColors
                                                        .abstractionTextColor
                                                    : AppColors.black,
                                                fontSize: 8,
                                              ),
                                            ),
                                          ],
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          content: Container(),
                        ),
                      )
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
