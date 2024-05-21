import 'dart:convert';
import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/diary/controller/diary_controller.dart';
import 'package:weight_loss_app/modules/exercise/exercise_plan_detail/models/exercise_item_detial_model.dart';
import 'package:weight_loss_app/modules/progress_user/controller/progress_user_controller.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_large_button.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

class ExerciseRepsPage extends StatefulWidget {
  const ExerciseRepsPage({super.key, required this.exerciseItemDetailModel});
  final ExerciseItemDetailModel exerciseItemDetailModel;
  @override
  State<ExerciseRepsPage> createState() => _ExerciseRepsPageState();
}

class _ExerciseRepsPageState extends State<ExerciseRepsPage> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
    initializedPlayer();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    if (chewieController != null) {
      chewieController!.dispose();
    }
    super.dispose();
  }

  Future<void> initializedPlayer() async {
    log("${ApiUrls.s3VideoAudioBaseUrl}Exercise/${widget.exerciseItemDetailModel.videoFile}");

    try {
      videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(
          "${ApiUrls.s3VideoAudioBaseUrl}Exercise/${widget.exerciseItemDetailModel.videoFile}",
        ),
      );
      await videoPlayerController.initialize();
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        looping: false,
        autoPlay: true,
        materialProgressColors: ChewieProgressColors(
          backgroundColor: const Color(0xff6b6a68),
          bufferedColor: const Color(0xffb8b8b8),
          handleColor: Colors.white,
          playedColor: AppColors.buttonColor,
        ),
        autoInitialize: true,
        allowFullScreen: false,
        allowedScreenSleep: false,
      );
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Exercise',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        centerTitle: true,
      ),
      body: WillPopScope(
        onWillPop: () async {
          videoPlayerController.pause();
          return true;
        },
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  Container(
                    width: width,
                    height: height * 0.35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.black),
                    child: chewieController != null &&
                            videoPlayerController.value.isInitialized
                        ? AspectRatio(
                            aspectRatio:
                                videoPlayerController.value.aspectRatio,
                            child: Chewie(
                              controller: chewieController!,
                            ),
                          )
                        : const Center(child: CircularProgressIndicator()),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.exerciseItemDetailModel.name!,
                          style: AppTextStyles.formalTextStyle(
                            color: AppColors.buttonColor,
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Text(
                          'X ${widget.exerciseItemDetailModel.videoDuration}',
                          style: AppTextStyles.formalTextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context)
                                .primaryTextTheme
                                .titleMedium!
                                .color!,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.07,
                        ),
                        CustomLargeButton(
                          height: height,
                          width: width * 0.65,
                          text: "Done",
                          borderRadius: BorderRadius.circular(15),
                          onPressed: () async {
                            videoPlayerController.pause();
                            await updateExerciseTime(
                              duration: "0",
                              exerciseId: widget
                                  .exerciseItemDetailModel.exerciseId
                                  .toString(),
                              planId: widget.exerciseItemDetailModel.planId
                                  .toString(),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            isLoading ? const OverlayWidget() : const SizedBox()
          ],
        ),
      ),
    );
  }

  bool isLoading = false;
  final ApiService apiService = ApiService();
  Future<void> updateExerciseTime({
    required String planId,
    required String exerciseId,
    required String duration,
  }) async {
    Map<String, dynamic> bodyData = {
      "exerciseId": exerciseId,
      "planId": planId,
      "duration": duration
    };
    try {
      isLoading = true;
      setState(() {});
      String? token = await StorageServivce.getToken();
      var response = await apiService.post(
        ApiUrls.updateExerciseTime,
        jsonEncode(bodyData),
        authToken: token,
      );

      if (response.statusCode == 200) {
        // var dataObj = await jsonDecode(response.body);
        // log(dataObj.toString());
        await Get.find<ProgressUserController>().getUserStats();
        await Get.find<DiaryController>().getDiaryDetail(DateTime.now());
        isLoading = false;
        setState(() {});
        Get.back();
      } else {
        isLoading = false;
        setState(() {});
        customSnackbar(title: AppTexts.success, message: 'Time not update');
      }
    } catch (e) {
      isLoading = false;
      setState(() {});
      // log(e.toString());
    }
  }
}
