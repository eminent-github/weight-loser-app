import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/modules/diet/diet_plan_detail/controller/diet_plan_detail_controller.dart';
import 'package:weight_loss_app/modules/exercise/exercise_plan_detail/controller/exercise_plan_detial_controller.dart';
import 'package:weight_loss_app/modules/exercise/exercise_plan_detail/models/exercise_item_detial_model.dart';
import 'package:weight_loss_app/modules/exercise/exercise_reps/exercise_reps_page.dart';
import 'package:weight_loss_app/modules/exercise/exercise_timer/binding/exercise_timer_binding.dart';
import 'package:weight_loss_app/modules/exercise/rest_day/rest_day_page.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../exercise_timer/exercise_timer_page/exercise_timer_page.dart';

class ExercisePlanItem extends StatelessWidget {
  ExercisePlanItem({
    super.key,
    required this.getActivePlanDetailList,
    required this.planIdAndDuration,
    required this.isCurrentDay,
  });
  final List<ExerciseItemDetailModel> getActivePlanDetailList;
  final PlanIdAndDuration planIdAndDuration;
  final bool isCurrentDay;
  final controller = Get.find<ExercisePlanDetialController>();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return getActivePlanDetailList.isEmpty
        ? Center(
            child: Text(
              "No Exercise Available",
              style: AppTextStyles.formalTextStyle(),
            ),
          )
        : ListView.builder(
            itemCount: getActivePlanDetailList.length,
            padding: EdgeInsets.only(top: height * 0.02),
            itemBuilder: (context, index) {
              ExerciseItemDetailModel exerciseItemDetailModel =
                  getActivePlanDetailList[index];
              // print(exerciseItemDetailModel.videoDuration);
              int remainingTime = exerciseItemDetailModel.userExerciseDuration!;
              int completedTime =
                  exerciseItemDetailModel.videoDuration! - remainingTime;
              print(exerciseItemDetailModel.fileName);
              return GestureDetector(
                onTap: isCurrentDay
                    ? () async {
                        if (exerciseItemDetailModel.name == "Rest Day") {
                          Get.to(() => const RestDayPage());
                        } else {
                          if (exerciseItemDetailModel.isRep!) {
                            await Get.to(() => ExerciseRepsPage(
                                exerciseItemDetailModel:
                                    exerciseItemDetailModel));
                          } else {
                            await Get.to(
                                () => ExerciseTimerPage(exerciseIndex: index),
                                binding: ExerciseTimerBinding(
                                  exerciseItemDetailModel:
                                      exerciseItemDetailModel,
                                ));
                          }
                          controller.planExercises(planIdAndDuration.planId!,
                              planIdAndDuration.duration!);
                        }
                      }
                    : null,
                child: exerciseItemDetailModel.name == "Rest Day"
                    ? Container(
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
                              flex: 6,
                              child: Padding(
                                padding: EdgeInsets.only(left: width * 0.05),
                                child: Column(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    Text(
                                      exerciseItemDetailModel.name!,
                                      style: AppTextStyles.formalTextStyle(
                                        color: AppColors.buttonColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.005,
                                    ),
                                    AutoSizeText(
                                      'In this moment of calm, feel the strength forged within.',
                                      maxLines: 2,
                                      style: AppTextStyles.formalTextStyle(
                                        fontSize: 10,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: SizedBox(
                                  height: height * 0.11,
                                  // padding: EdgeInsets.only(right: width * 0.02),
                                  child: SvgPicture.asset(
                                    AppAssets.restDaySvgUrl,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
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
                              flex: 9,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.05),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      exerciseItemDetailModel.name!,
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
                                          exerciseItemDetailModel.videoDuration!
                                              .toDouble(),
                                      backgroundColor: const Color(0xffC7C7C7),
                                      barRadius: const Radius.circular(20),
                                      progressColor: AppColors.themeColor,
                                      alignment: MainAxisAlignment.center,
                                      padding: const EdgeInsets.all(0),
                                    ),
                                    exerciseItemDetailModel.isRep!
                                        ? Text(
                                            "Number of ${exerciseItemDetailModel.name} : ${exerciseItemDetailModel.videoDuration}",
                                            style:
                                                AppTextStyles.formalTextStyle(
                                              color: AppColors.black,
                                              fontSize: 11,
                                            ),
                                          )
                                        : Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: completedTime > 60
                                                      ? 'Completed: ${(completedTime / 60).toPrecision(1)} Minutes'
                                                      : 'Completed: $completedTime Seconds',
                                                  style: AppTextStyles
                                                      .formalTextStyle(
                                                    color:
                                                        const Color(0xFF535353),
                                                    fontSize: 9,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' | ',
                                                  style: AppTextStyles
                                                      .formalTextStyle(
                                                    color:
                                                        const Color(0xFFA3A8AC),
                                                    fontSize: 9,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: remainingTime > 60
                                                      ? 'Left: ${(remainingTime / 60).toPrecision(1)} Minutes'
                                                      : 'Left: $remainingTime Seconds',
                                                  style: AppTextStyles
                                                      .formalTextStyle(
                                                    color:
                                                        AppColors.buttonColor,
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
                              flex: 4,
                              child: Container(
                                // width: width * 0.21,
                                height: height * 0.11,
                                padding: EdgeInsets.only(right: width * 0.02),
                                decoration: const BoxDecoration(
                                    // shape: OvalBorder(
                                    //   side: BorderSide(
                                    //       width: 0.50, color: Colors.white),
                                    // ),
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: Colors.black.withOpacity(0.5),
                                    //     blurRadius: 2,
                                    //     // offset: Offset(0, 1),
                                    //     spreadRadius: 0,
                                    //   )
                                    // ],
                                    ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child:
                                      exerciseItemDetailModel.fileName == null
                                          ? const CircleAvatar(
                                              backgroundColor: AppColors.white,
                                              child: Center(
                                                child: Icon(Icons.image),
                                              ),
                                            )
                                          : S3LoadingImage(
                                              imageUrl:
                                                  "${ApiUrls.s3ImageBaseUrl}Exercise/${exerciseItemDetailModel.fileName!}",
                                              fit: BoxFit.cover,
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
