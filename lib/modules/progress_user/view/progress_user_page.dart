import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/progress_user/controller/progress_user_controller.dart';
import 'package:weight_loss_app/modules/progress_user/modal/pdf_file_model.dart';
import 'package:weight_loss_app/modules/progress_user/widgets/weight_progress_graph.dart';
import 'package:weight_loss_app/modules/progress_user/widgets/weight_stats_container.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_text_styles.dart';
import '../widgets/user_stats_ui.dart';

class ProgressUserPage extends GetView<ProgressUserController> {
  const ProgressUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: InternetCheckWidget<ConnectivityService>(
        child: Obx(
          () => SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.03,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.02,
                    ),
                    SizedBox(
                      height: height * 0.04,
                      width: width * 0.83,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.progressTitle.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            controller.selectedIndex.value = index;
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.04),
                            child: Container(
                              width: width * 0.35,
                              decoration: BoxDecoration(
                                color: controller.selectedIndex.value == index
                                    ? AppColors.buttonColor
                                    : AppColors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: AppColors.buttonColor,
                                    width: width * 0.003),
                              ),
                              child: Center(
                                child: Text(
                                  controller.progressTitle[index],
                                  style: TextStyle(
                                    color:
                                        controller.selectedIndex.value == index
                                            ? AppColors.white
                                            : AppColors.buttonColor,
                                    fontSize: 15,
                                    fontFamily: AppTextStyles.fontFamily,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    PopupMenuButton<String>(
                      padding: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      // constraints: BoxConstraints(
                      //     maxWidth: width * 0.3, maxHeight: height * 0.06),
                      onSelected: (value) async {
                        if (value == 'share') {
                          File downloadFile = await PdfApi.generateCenteredText(
                              pdfModel: PdfModel(
                                  name: controller.userName.value,
                                  age: controller.userStatsModal.value.age ?? 0,
                                  weightUnit: controller.weightUnit.value,
                                  startingweight:
                                      controller.startingWeight.value.toInt(),
                                  startingDate:
                                      controller.startingWeightDate.value,
                                  currentweight: controller.currentWeight.value.toInt() == 0
                                      ? controller.startingWeight.value.toInt()
                                      : controller.currentWeight.value.toInt(),
                                  currentDate:
                                      controller.currentWeightDate.value,
                                  goalweight:
                                      controller.targetWeight.value.toInt(),
                                  goalDate: controller.targetWeightDate.value,
                                  totalAvg: (controller
                                          .userStatsModal.value.totalAvgCal) ??
                                      0.0,
                                  carbs:
                                      controller.userStatsModal.value.sumOfCarbs ??
                                          0.0,
                                  fat: controller.userStatsModal.value.sumOfFat ??
                                      0.0,
                                  protien: controller
                                          .userStatsModal.value.sumOfProtein ??
                                      0.0,
                                  goalCarbs: controller
                                          .userStatsModal.value.goalCarbCount ??
                                      0.0,
                                  goalFat: controller.userStatsModal.value.goalFatCount ?? 0.0,
                                  goalProtien: controller.userStatsModal.value.goalProteinCount ?? 0.0,
                                  aveSleep: "${controller.userStatsModal.value.averageSleepHours!.hours}h${controller.userStatsModal.value.averageSleepHours!.minutes}m",
                                  aveExercise: controller.userStatsModal.value.weekAvgExer ?? 0.0));
                          if (await downloadFile.exists()) {
                            // print('PDF saved to: ${downloadFile.path}');

                            Share.shareXFiles([XFile(downloadFile.path)]);
                          } else {
                            // File does not exist, PDF download failed
                            customSnackbar(
                                title: AppTexts.error,
                                message:
                                    "File does not exist, PDF download failed");
                          }
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem<String>(
                            // height: height * 0.025,
                            value: 'share',

                            child: SizedBox(
                              height: height * 0.025,
                              width: width * 0.25,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.ios_share_rounded,
                                    color: AppColors.black,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  AutoSizeText(
                                    'Share PDF',
                                    maxLines: 1,
                                    minFontSize: 6,
                                    style: AppTextStyles.formalTextStyle(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ];
                      },
                      icon: Icon(
                        Icons.more_vert_rounded,
                        color: Theme.of(context)
                            .primaryTextTheme
                            .titleMedium!
                            .color!,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: controller.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.buttonColor,
                          ),
                        )
                      : controller.selectedIndex.value == 0
                          ? UserStatsUI(
                              userStatsModal: controller.userStatsModal.value,
                              currentWeight: controller.startingWeight.value,
                              startWeightDate: controller.userWeightDate.value,
                              weightUnit: controller.weightUnit.value,
                            )
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: height * 0.04,
                                  ),
                                  SizedBox(
                                    height: height * 0.35,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: WeightProgressGraph(
                                        weightList: controller.userStatsModal
                                                .value.updateWeight ??
                                            [],
                                        currentWeight:
                                            controller.startingWeight.value,
                                        startWeightDate:
                                            controller.userWeightDate.value,
                                        weightUnit: controller.weightUnit.value,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.03,
                                  ),
                                  WeightStatsContainer(
                                    tileTitle: 'Starting Weight',
                                    weightValue:
                                        controller.startingWeight.value.toInt(),
                                    dateValue:
                                        controller.startingWeightDate.value,
                                    weightUnit: controller.weightUnit.value,
                                    showIcon: AppAssets.startingWeightSvgUrl,
                                  ),
                                  WeightStatsContainer(
                                    tileTitle: 'Current Weight',
                                    weightValue:
                                        controller.currentWeight.value == 0
                                            ? controller.startingWeight.value
                                                .toInt()
                                            : controller.currentWeight.value,
                                    dateValue:
                                        controller.currentWeightDate.value,
                                    weightUnit: controller.weightUnit.value,
                                    showIcon: AppAssets.currentWeightSvgUrl,
                                  ),
                                  WeightStatsContainer(
                                    tileTitle: 'Goal Weight',
                                    weightValue:
                                        controller.targetWeight.value.toInt(),
                                    dateValue:
                                        controller.targetWeightDate.value,
                                    weightUnit: controller.weightUnit.value,
                                    showIcon: 'assets/icons/weight.svg',
                                  ),
                                ],
                              ),
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
