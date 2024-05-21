import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/deep_sleep/controller/deep_sleep_controller.dart';
import 'package:weight_loss_app/modules/deep_sleep/models/deep_sleep_model.dart';
import 'package:weight_loss_app/modules/deep_sleep/screen/sleep_Video_screen/sleep_video_screen.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';

class SleepVideos extends StatelessWidget {
  const SleepVideos(
      {super.key, required this.sleepVideosList, required this.controller});
  final List<SleepVedios> sleepVideosList;
  final DeepSleepController controller;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return sleepVideosList.isEmpty
        ? Center(
            child: Text(
              "No Sleep Video Available.",
              style: AppTextStyles.formalTextStyle(),
            ),
          )
        : Obx(
            () => Column(
              children: [
                GridView.builder(
                  itemCount: controller.showAllItems.value
                      ? sleepVideosList.length
                      : 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1.25),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.all(height * .01),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            log("${ApiUrls.s3VideoAudioBaseUrl}Sleep/${sleepVideosList[index].videoFile}");
                            return CustomSleepVideoPlayer(
                              videoUrl:
                                  "${ApiUrls.s3VideoAudioBaseUrl}Sleep/${sleepVideosList[index].videoFile}",
                              videoTitle: sleepVideosList[index].title!,
                            );
                          },
                        ));
                      },
                      borderRadius: BorderRadius.circular(height * .02),
                      child: Container(
                        height: height * .08,
                        width: width * .3,
                        decoration: BoxDecoration(
                          color: AppColors.buttonColor,
                          borderRadius: BorderRadius.circular(height * .02),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            sleepVideosList[index].imageFile!.isEmpty
                                ? ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(height * .02),
                                    child: Image.asset(
                                      AppAssets.sleepVideoImgUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(height * .02),
                                    child: S3LoadingImage(
                                      imageUrl:
                                          "${ApiUrls.s3ImageBaseUrl}Sleep/${sleepVideosList[index].imageFile}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(height * .02),
                                color: AppColors.black.withOpacity(0.4),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.02),
                                  child: AutoSizeText(
                                    sleepVideosList[index].title!,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles.formalTextStyle(
                                      color: const Color(0xFFF2EFFF),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      index < 9
                                          ? "0${index + 1}"
                                          : "${index + 1}",
                                      style: AppTextStyles.formalTextStyle(
                                        color: const Color(0xFFF2EFFF),
                                        fontSize: 40,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: const ShapeDecoration(
                                        color: Color(0x59F2EFFF),
                                        shape: OvalBorder(),
                                      ),
                                      child: const Icon(
                                        Icons.play_arrow_rounded,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    controller.showAllItems.value =
                        !controller.showAllItems.value;
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.amber),
                  ),
                  child: Text(
                    controller.showAllItems.value ? "Show less" : "Show more",
                    style: AppTextStyles.formalTextStyle(),
                  ),
                ),
              ],
            ),
          );
  }
}
