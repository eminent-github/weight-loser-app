import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/modules/doctor/video_call/controller/video_call_controller.dart';
import 'package:weight_loss_app/modules/doctor/video_call/widgets/call_components.dart';

class VideoCallPage extends GetView<VideoCallController> {
  const VideoCallPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.doctorImgUrl),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  top: height * 0.08,
                  left: width * 0.07,
                  child: Container(
                    width: width * 0.25,
                    height: height * 0.17,
                    decoration: ShapeDecoration(
                      color: AppColors.white,
                      image: const DecorationImage(
                        image: AssetImage(AppAssets.userGoalWeddingImgUrl),
                        fit: BoxFit.fill,
                      ),
                      shape: RoundedRectangleBorder(
                        side:
                            const BorderSide(width: 0.50, color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: AppColors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Obx(
                      () => CallComponents(
                        callIcon: controller.micIndex.value
                            ? Icons.mic_off_outlined
                            : Icons.mic_none_outlined,
                        backgroundColor: controller.micIndex.value
                            ? AppColors.buttonColor.withOpacity(0.7)
                            : AppColors.buttonColor,
                        onTap: () {
                          controller.micIndex.value =
                              !controller.micIndex.value;
                        },
                      ),
                    ),
                    Obx(
                      () => CallComponents(
                        callIcon: controller.videoCallIndex.value
                            ? Icons.videocam_off_outlined
                            : Icons.videocam_outlined,
                        backgroundColor: controller.videoCallIndex.value
                            ? AppColors.buttonColor.withOpacity(0.7)
                            : AppColors.buttonColor,
                        onTap: () {
                          controller.videoCallIndex.value =
                              !controller.videoCallIndex.value;
                        },
                      ),
                    ),
                    Obx(
                      () => CallComponents(
                        callIcon: controller.volumeIndex.value
                            ? Icons.volume_off_outlined
                            : Icons.volume_up_outlined,
                        backgroundColor: controller.volumeIndex.value
                            ? AppColors.buttonColor.withOpacity(0.7)
                            : AppColors.buttonColor,
                        onTap: () {
                          controller.volumeIndex.value =
                              !controller.volumeIndex.value;
                        },
                      ),
                    ),
                    CallComponents(
                      callIcon: Icons.call_end_outlined,
                      backgroundColor: Colors.red,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
