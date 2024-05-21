import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/modules/exercise_intervel_time/ready_time/widgets/custom_ready_time_timer/circular_countdown_timer.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import '../../../../common/app_assets.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';
import '../controller/challenge_controller.dart';

class ChallengePage extends GetView<ChallengeController> {
  const ChallengePage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppTexts.twoKRunningText,
          style: TextStyle(
            fontFamily: AppTextStyles.fontFamily,
            fontSize: 18,
            color: AppColors.blue,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData.fallback(),
        elevation: 0,
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: width * 0.05),
              child: const Text(
                AppTexts.oneFiftyJoined,
                style: TextStyle(
                  color: AppColors.black,
                  fontFamily: AppTextStyles.fontFamily,
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                ),
              ),
            ),
          )
        ],
      ),
      body: InternetCheckWidget<ConnectivityService>(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              SizedBox(
                width: width * 0.85,
                height: height * 0.13,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: 14,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.stepperColor,
                          width: 1,
                        ),
                        image: const DecorationImage(
                          image: AssetImage(
                            AppAssets.runningUrl,
                          ),
                          fit: BoxFit.fill,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 1),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                width: width * 0.6,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Color(0xFFE8E8E8),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              const Text(
                AppTexts.runningTimeText,
                style: TextStyle(
                    color: AppColors.blue,
                    fontFamily: AppTextStyles.fontFamily,
                    fontSize: 11,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              const Text(
                'Starting at: 09:15 PM',
                style: TextStyle(
                    color: AppColors.black,
                    fontFamily: AppTextStyles.fontFamily,
                    fontSize: 10,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              SizedBox(
                height: height * 0.27,
                width: width,
                child: SvgPicture.asset(
                  AppAssets.groupExerciseSvg,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CircularReadyTimeTimer(
                width: width,
                height: height * 0.16,
                fillColor: AppColors.buttonColor,
                ringColor: AppColors.progressBackgroundColor,
                duration: 60,
                textStyle: AppTextStyles.formalTextStyle(
                  color: AppColors.buttonColor,
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                ),
                isReverse: true,
                strokeCap: StrokeCap.round,
                isReverseAnimation: true,
                supportText: " s",
                startAngleValue: 2,
                strokeWidth: 3,
                onComplete: () {},
              ),
              SizedBox(
                height: height * 0.02,
              ),
              const Text(
                AppTexts.raceEndsInText,
                style: TextStyle(
                  fontFamily: AppTextStyles.fontFamily,
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: height * 0.05,
                  width: width * 0.4,
                  decoration: BoxDecoration(
                    color: const Color(0xffEC8A8A),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Text(
                      AppTexts.leaveChallengeText,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: AppTextStyles.fontFamily),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
