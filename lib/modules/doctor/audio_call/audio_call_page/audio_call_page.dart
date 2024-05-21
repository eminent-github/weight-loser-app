import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/doctor/audio_call/controller/audio_call_controller.dart';
import 'package:weight_loss_app/modules/doctor/video_call/widgets/call_components.dart';

class AudioCallPage extends GetView<AudioCallController> {
  const AudioCallPage({super.key});

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
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '00:45:30',
                  style: AppTextStyles.formalTextStyle(
                    fontSize: 22,
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Container(
                  width: width * 0.55,
                  height: height * 0.3,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 0.8, color: AppColors.audioCallColor),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: width * 0.5,
                      height: height * 0.27,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 0.8, color: AppColors.audioCallColor),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Center(
                        child: Container(
                          width: width * 0.45,
                          height: height * 0.24,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 0.8, color: AppColors.audioCallColor),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Center(
                            child: Container(
                              width: width * 0.4,
                              height: height * 0.21,
                              decoration: ShapeDecoration(
                                image: const DecorationImage(
                                  image: AssetImage(AppAssets.doctorImgUrl),
                                  fit: BoxFit.fill,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(17),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Text(
                  'Dr. Amit Kumar',
                  style: AppTextStyles.formalTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                )
              ],
            ),
            SizedBox(
              height: height * 0.12,
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                        controller.micIndex.value = !controller.micIndex.value;
                      },
                    ),
                  ),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  CallComponents(
                    callIcon: Icons.call_end_outlined,
                    backgroundColor: Colors.red,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
