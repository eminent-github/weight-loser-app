import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_today/models/today_diet_model.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';

class ExercisePerformanceWidget extends StatelessWidget {
  const ExercisePerformanceWidget({
    super.key,
    required this.width,
    required this.height,
    required this.onPressed,
    // required this.onRefreshTap,
    required this.exercise,
  });

  final double width;
  final double height;
  final VoidCallback onPressed;
  // final VoidCallback onRefreshTap;
  final ActiveExercisePlanVM exercise;

  @override
  Widget build(BuildContext context) {
    return exercise.name == "Rest Day"
        ? InkWell(
            onTap: onPressed,
            child: Container(
              width: width,
              height: height * 0.12,
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02, vertical: height * 0.005),
              margin: EdgeInsets.symmetric(horizontal: width * 0.02),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
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
                            exercise.name!,
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
            ),
          )
        : InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(15),
            child: Container(
              height: height * 0.12,
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02, vertical: height * 0.005),
              margin: EdgeInsets.symmetric(horizontal: width * 0.02),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: height * 0.1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: exercise.exerciseImage != null
                            ? S3LoadingImage(
                                imageUrl:
                                    "${ApiUrls.s3ImageBaseUrl}Exercise/${exercise.exerciseImage!}",
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/exercise.png',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: ExerciseTrackerWidget(
                        minutes: exercise.exerciseDuration!,
                        remainingTime: exercise.durationCompleted!,
                        exerciseName: exercise.name!,
                        isRep: exercise.isRep!,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Container(
                        height: height * 0.04,
                        width: width * 0.08,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.buttonColor,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: AppColors.buttonColor,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}

class ExerciseTrackerWidget extends StatelessWidget {
  const ExerciseTrackerWidget(
      {super.key,
      required this.minutes,
      required this.remainingTime,
      required this.exerciseName,
      required this.isRep});
  final int minutes;
  final String exerciseName;
  final int remainingTime;
  final bool isRep;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          exerciseName,
          textAlign: TextAlign.start,
          style: AppTextStyles.formalTextStyle(
              fontSize: 12,
              color: isRep ? AppColors.buttonColor : AppColors.black,
              fontWeight: FontWeight.bold),
        ),
        isRep
            ? Text(
                "Number of $exerciseName : $minutes",
                style: AppTextStyles.formalTextStyle(
                  fontSize: 11,
                ),
              )
            : FittedBox(
                child: Text.rich(
                  TextSpan(
                    children: [
                      // TextSpan(
                      //   text: messageOne(
                      //     minutes: minutes,
                      //     remainingTime: remainingTime,
                      //   ),
                      //   style: AppTextStyles.formalTextStyle(fontSize: 8),
                      // ),
                      TextSpan(
                        text: messageTwo(
                            minutes: minutes, remainingTime: remainingTime),
                        style: AppTextStyles.formalTextStyle(
                            color: AppColors.buttonColor, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ),
        LinearPercentIndicator(
          animation: true,
          lineHeight: 10,
          animationDuration: 1000,
          percent: getSpentTime(minutes, remainingTime) / minutes,
          backgroundColor: const Color.fromARGB(255, 231, 235, 235),
          barRadius: const Radius.circular(20),
          progressColor: AppColors.buttonColor,
          padding: const EdgeInsets.all(0),
        ),
      ],
    );
  }
}

String messageOne({required int minutes, required int remainingTime}) {
  return minutes > 60
      ? "Completed: ${((minutes - remainingTime) / 60).toPrecision(1)} Minutes |"
      : "Completed: ${minutes - remainingTime} Seconds |";
}

String messageTwo({required int minutes, required int remainingTime}) {
  return remainingTime > 60
      ? " Left: ${(remainingTime / 60).toPrecision(1)} Minutes"
      : " Left: $remainingTime Seconds";
}

int getSpentTime(int minutes, int remainingTime) => minutes - remainingTime;
