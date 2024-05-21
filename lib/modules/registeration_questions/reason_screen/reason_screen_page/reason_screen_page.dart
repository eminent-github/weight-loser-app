import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';
import '../../../../common/app_assets.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';
import '../../../../widgets/app_logo.dart';
import '../../widgets/qus_next_button.dart';
import '../controller/reason_screen_controller.dart';

// ignore: must_be_immutable
class ReasonScreenPage extends GetView<ReasonScreenController> {
  const ReasonScreenPage({super.key});
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double height = screenSize.height;
    double width = screenSize.width;
    return Scaffold(
      body: InternetCheckWidget<ConnectivityService>(
        child: Obx(
          () => Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.015,
                      ),
                      const AppLogo(),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: height * 0.03),
                        child: const Center(
                          child: Text(
                            AppTexts.reason,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: AppTextStyles.fontFamily,
                              color: AppColors.gray,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
                        height: height * 0.36,
                        width: width * 0.8,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(AppAssets.reasonUrl),
                                fit: BoxFit.fill)),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.lightGrey,
                            width: 0.7,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                        height: height * 0.08,
                        width: width * 0.61,
                        child: Center(
                          child: Obx(() => DropdownButton(
                                onChanged: (newValue) {
                                  controller.selected.value = newValue!;
                                },
                                underline: const SizedBox(),
                                isExpanded: true,
                                borderRadius: BorderRadius.circular(12),
                                value: controller.selected.value,
                                style: const TextStyle(
                                    color: AppColors.understandWidgetBorderColor,
                                    fontFamily: AppTextStyles.fontFamily,
                                    fontSize: 14),
                                items:
                                    controller.purposeTypeList.map((selectedType) {
                                  return DropdownMenuItem(
                                    value: selectedType,
                                    child: Text(
                                      selectedType,
                                    ),
                                  );
                                }).toList(),
                                icon: Icon(
                                  size: 28,
                                  grade: 10,
                                  Icons.expand_more,
                                  color: AppColors.buttonColor,
                                ),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.15,
                      ),
                      QusNextButton(
                        height: height * 0.07,
                        width: width * 0.5,
                        callBack: () {
                          if (controller.selected.value !=
                              "Select your motivation") {
                            controller.lossReasonApi();
                          } else {
                            customSnackbar(
                                title: AppTexts.error,
                                message: "Please select your weight loss Reason!");
                          }
                        },
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
