// ignore_for_file: must_be_immutable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';
import '../../../../common/app_assets.dart';
import '../../../../common/app_texts.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../widgets/app_logo.dart';
import '../../widgets/qus_next_button.dart';
import '../controller/goal_diet_controller.dart';

class GoalDietPage extends GetView<GoalDietController> {
  const GoalDietPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height - kToolbarHeight;
    double width = size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: InternetCheckWidget<ConnectivityService>(
        child: Obx(
          () => Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const AppLogo(),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.07),
                        child: const Center(
                          child: AutoSizeText(
                            AppTexts.goalShare,
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            style: TextStyle(
                                color: AppColors.understandWidgetBorderColor,
                                fontFamily: AppTextStyles.fontFamily,
                                fontWeight: FontWeight.w400,
                                fontSize: 19,
                                letterSpacing: 1),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
                        height: height * 0.27,
                        width: width * 0.5,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AppAssets.goalstartedUrl),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      const Center(
                        child: Text(
                          AppTexts.goaldate,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              fontFamily: AppTextStyles.fontFamily,
                              color: AppColors.understandWidgetBorderColor),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      InkWell(
                        onTap: () async {
                          await controller.selectDate(context);
                        },
                        child: Obx(
                          () => Container(
                            height: height * 0.075,
                            width: width * 0.6,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.lightGrey,
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0))),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  AutoSizeText(
                                    DateFormat("MMMM d, y")
                                        .format(controller.selectedDate.value),
                                    maxLines: 1,
                                    minFontSize: 10,
                                    style: const TextStyle(
                                      fontFamily: AppTextStyles.fontFamily,
                                      fontSize: 17,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  Icon(
                                    Icons.calendar_month_outlined,
                                    color: AppColors.buttonColor,
                                    size: 27,
                                    weight: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.12,
                      ),
                      QusNextButton(
                        callBack: () {
                          if (controller.selectedDate.value
                              .isAfter(DateTime.now())) {
                            controller.targeDateApi();
                          } else {
                            customSnackbar(
                                title: AppTexts.error,
                                message: "Please select correct date");
                          }
                        },
                        height: height * 0.07,
                        width: width * 0.5,
                      ),
                    ],
                  ),
                ),
              ),
              controller.isLoading.value
                  ? OverlayWidget(
                      height: height,
                      width: width,
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
