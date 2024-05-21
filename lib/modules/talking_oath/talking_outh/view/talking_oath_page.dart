import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/registeration_questions/complete_profile/complete_profile_page.dart';
import 'package:weight_loss_app/modules/talking_oath/talking_outh/controller/talking_oath_controller.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

import '../../../../common/app_assets.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_texts.dart';

class TalkingOathPage extends GetView<TalkingOathController> {
  const TalkingOathPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Scaffold(
      body: InternetCheckWidget<ConnectivityService>(
        child: Obx(
          () => Stack(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Get.offAll(
                              //     () => ShowCaseWidget(builder: Builder(
                              //           builder: (context) {
                              //             return const DashboaredPage();
                              //           },
                              //         )),
                              //     binding: DashboaredBinding());
                              Get.to(
                                () => const CompleteProfilePage(),
                              );
                            },
                            child: Text(
                              AppTexts.skipText,
                              style: TextStyle(
                                color: Colors.black
                                    .withOpacity(0.6200000047683716),
                                fontSize: 12,
                                fontFamily: AppTextStyles.fontFamily,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    SizedBox(
                      height: height * 0.43,
                      child: Image.asset(
                        controller.gender.value == "Male"
                            ? AppAssets.maleOathImgUrl
                            : controller.gender.value == "Female"
                                ? AppAssets.femaleOathImgUrl
                                : AppAssets.transgenderOathImgUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Text(
                      AppTexts.takeAnOathText,
                      style: TextStyle(
                        color: AppColors.buttonColor,
                        fontSize: 24,
                        fontFamily: AppTextStyles.fontFamily,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                      child: AutoSizeText.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  'I ${controller.userName.value}, solemnly swear with unwavering determination to achieve my targeted weight loss goal of ',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '${controller.targetWeight.value} ${controller.weightUnit.value}s',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const TextSpan(
                              text: ' by ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            TextSpan(
                              text: '${DateFormat("MM-dd-yyyy").format(
                                DateTime.now().add(
                                  Duration(
                                    days: controller.daysToLoseWeight(
                                      currentWeight:
                                          controller.weightUnit.value == "kg"
                                              ? controller.currentWeight.value *
                                                  2.2
                                              : controller.currentWeight.value,
                                      goalWeight: controller.weightUnit.value ==
                                              "kg"
                                          ? controller.targetWeight.value * 2.2
                                          : controller.targetWeight.value,
                                      weightPerWeek: 1.5,
                                    ),
                                  ),
                                ),
                              )}.',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        maxLines: 3,
                        minFontSize: 5,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                      child: const AutoSizeText.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  'I commit to the relentless pursuit of transformative health. No obstacle shall deter my path.',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13.5,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        maxLines: 3,
                        minFontSize: 5,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.takenOathApi();
                      },
                      child: Container(
                        height: height * 0.06,
                        width: width * 0.6,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: AppColors.buttonColor),
                        child: const Center(
                          child: Text(
                            AppTexts.takeTheOathText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: AppTextStyles.fontFamily,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
