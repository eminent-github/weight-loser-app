import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/doctor/audio_call/audio_call_page/audio_call_page.dart';
import 'package:weight_loss_app/modules/doctor/audio_call/binding/audio_call_binding.dart';
import 'package:weight_loss_app/modules/doctor/messaging/binding/messaging_binding.dart';
import 'package:weight_loss_app/modules/doctor/messaging/messaging_page/messaging_page.dart';
import 'package:weight_loss_app/modules/doctor/video_call/binding/video_call_binding.dart';
import 'package:weight_loss_app/modules/doctor/video_call/video_call_page/video_call_page.dart';
import 'package:weight_loss_app/modules/doctor/waiting_area/controller/waiting_area_controller.dart';
import 'package:weight_loss_app/modules/exercise_intervel_time/ready_time/widgets/custom_ready_time_timer/circular_countdown_timer.dart';
import 'package:weight_loss_app/modules/page_not_found/not_found_page.dart';

class WaitingAreaPage extends GetView<WaitingAreaController> {
  const WaitingAreaPage({
    super.key,
    required this.contactType,
  });
  final String contactType;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double screenHeight = screenSize.height;
    double height = screenSize.height - kToolbarHeight;
    double width = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData.fallback(),
        elevation: 0,
        toolbarHeight: screenHeight * 0.1,
        title: Text(
          'Waiting Area',
          style: AppTextStyles.formalTextStyle(
            color: AppColors.buttonColor,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: height * 0.05,
          ),
          Container(
            height: height * 0.43,
            decoration: const BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(99, 70, 66, 66),
                  blurRadius: 15.32,
                  offset: Offset(5, -5),
                  spreadRadius: 5,
                )
              ],
              image: DecorationImage(
                image: AssetImage(AppAssets.waitingAreaImgUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.07,
          ),
          Text(
            'You are in Just',
            style: AppTextStyles.formalTextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: height * 0.05,
          ),
          CircularReadyTimeTimer(
            width: width * 0.3,
            height: height * 0.14,
            fillColor: AppColors.buttonColor,
            ringColor: AppColors.progressBackgroundColor,
            duration: 2,
            textStyle: AppTextStyles.formalTextStyle(),
            isReverse: true,
            strokeCap: StrokeCap.round,
            strokeWidth: 9,
            isReverseAnimation: true,
            supportText: " Mins",
            startAngleValue: 2.0,
            onComplete: () {
              switch (contactType) {
                case "Video Call":
                  Get.off(() => const VideoCallPage(),
                      binding: VideoCallBinding());
                  break;
                case "Voice Call":
                  Get.off(() => const AudioCallPage(),
                      binding: AudioCallBinding());
                  break;
                case "Messaging":
                  Get.off(() => const MessagingPage(),
                      binding: MessagingBinding());
                  break;
                default:
                  Get.off(
                    () => const NotFoundPage(),
                  );
              }
            },
          ),
        ],
      )),
    );
  }
}
