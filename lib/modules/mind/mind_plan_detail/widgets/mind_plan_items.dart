import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/modules/diet/diet_plan_detail/controller/diet_plan_detail_controller.dart';
import 'package:weight_loss_app/modules/mind/mind_plan_detail/controller/mind_paln_detail_controller.dart';
import 'package:weight_loss_app/modules/mind/mind_plan_detail/models/mind_item_detail_model.dart';
import 'package:weight_loss_app/modules/mind/mind_timer/binding/mind_timing_binding.dart';
import 'package:weight_loss_app/modules/mind/mind_timer/mind_timer_page/mind_timer_page.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';

class MindPlanItem extends StatelessWidget {
  MindPlanItem({
    super.key,
    required this.getActivePlanDetailList,
    required this.planIdAndDuration,
    required this.isCurrentDay,
  });
  final List<MindItemDetailModel> getActivePlanDetailList;
  final PlanIdAndDuration planIdAndDuration;
  final bool isCurrentDay;
  final controller = Get.find<MindPalnDetailController>();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return getActivePlanDetailList.isEmpty
        ? Center(
            child: Text(
              "No Meditation Found",
              style: AppTextStyles.formalTextStyle(),
            ),
          )
        : ListView.builder(
            itemCount: getActivePlanDetailList.length,
            padding: EdgeInsets.only(top: height * 0.02),
            itemBuilder: (context, index) {
              MindItemDetailModel mindItemDetailModel =
                  getActivePlanDetailList[index];
              int remainingTime = mindItemDetailModel.duration! -
                  mindItemDetailModel.watchedVideoDuration!;
              int completedTime = mindItemDetailModel.watchedVideoDuration!;
              print(mindItemDetailModel.imageFile);
              return GestureDetector(
                onTap: () async {
                  if (!isCurrentDay) {
                    print("do nothing");
                  } else {
                    await Get.to(() => const AudioPlayerScreen(),
                        binding: MindTimerBinding(
                            mindItemDetailModel: mindItemDetailModel));
                  }

                  // await Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => AudioPlayerScreen(
                  //             mindItemDetailModel: mindItemDetailModel)));
                  controller.getMindPlanDetail(
                      planIdAndDuration.planId!, planIdAndDuration.duration!);
                },
                child: Container(
                  width: width,
                  height: height * 0.13,
                  margin: EdgeInsets.symmetric(
                      horizontal: width * 0.07, vertical: height * 0.015),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
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
                        flex: 8,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.05),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                mindItemDetailModel.title!,
                                style: AppTextStyles.formalTextStyle(
                                  color: AppColors.buttonColor,
                                  fontSize: 14,
                                ),
                              ),
                              LinearPercentIndicator(
                                animation: true,
                                lineHeight: height * 0.014,
                                animationDuration: 500,
                                percent: completedTime.toDouble() /
                                            mindItemDetailModel.duration!
                                                .toDouble() >
                                        1
                                    ? 1
                                    : completedTime.toDouble() /
                                        mindItemDetailModel.duration!
                                            .toDouble(),
                                backgroundColor: const Color(0xffC7C7C7),
                                barRadius: const Radius.circular(20),
                                progressColor: AppColors.themeColor,
                                alignment: MainAxisAlignment.center,
                                padding: const EdgeInsets.all(0),
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: completedTime > 60
                                          ? 'Completed: ${(completedTime / 60).toPrecision(1)} Minutes'
                                          : 'Completed: $completedTime Seconds',
                                      style: AppTextStyles.formalTextStyle(
                                        color: const Color(0xFF535353),
                                        fontSize: 9,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' | ',
                                      style: AppTextStyles.formalTextStyle(
                                        color: const Color(0xFFA3A8AC),
                                        fontSize: 9,
                                      ),
                                    ),
                                    TextSpan(
                                      text: remainingTime > 60
                                          ? 'Left: ${(remainingTime / 60).toPrecision(1)} Minutes'
                                          : 'Left: $remainingTime Seconds',
                                      style: AppTextStyles.formalTextStyle(
                                        color: AppColors.buttonColor,
                                        fontSize: 9,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: Container(
                            width: width * 0.19,
                            height: height * 0.09,
                            decoration: const ShapeDecoration(
                              color: AppColors.white,
                              shape: OvalBorder(
                                side: BorderSide(
                                    width: 0.50, color: Colors.white),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 1),
                                )
                              ],
                            ),
                            // child: ClipOval(
                            //   child: Image.asset(
                            //     AppAssets.mindImgUrl,
                            //     fit: BoxFit.cover,
                            //   ),
                            //   //child:  LoadingImage(
                            //   //     imageUrl: mindItemDetailModel.imageFile!),
                            // ),
                            child: mindItemDetailModel.imageFile != null
                                ? Hero(
                                    tag:
                                        "${ApiUrls.s3ImageBaseUrl}Mind/${mindItemDetailModel.imageFile!}",
                                    child: ClipOval(
                                        child: S3LoadingImage(
                                      imageUrl:
                                          "${ApiUrls.s3ImageBaseUrl}Mind/${mindItemDetailModel.imageFile!}",
                                      fit: BoxFit.cover,
                                    )),
                                  )
                                : ClipOval(
                                    child: Image.asset(
                                      AppAssets.mindImgUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
