import 'dart:convert';
import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_today/controller/home_inner_today_controller.dart';
import 'package:weight_loss_app/modules/diary/controller/diary_controller.dart';
import 'package:weight_loss_app/modules/exercise/exercise_plan_detail/models/exercise_item_detial_model.dart';
import 'package:weight_loss_app/modules/progress_user/controller/progress_user_controller.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

import '../../../../widgets/custom_progress_timer/circular_countdown_timer.dart';

class ExerciseTimerController extends GetxController {
  final CountDownController countDownController = CountDownController();
  var isStopped = true.obs;
  var isLoading = false.obs;
  var isShowVideoPlayer = true.obs;

  ExerciseItemDetailModel? exerciseItemDetailModel;

  void getModelDat(ExerciseItemDetailModel mexerciseItemDetailModel) {
    exerciseItemDetailModel = mexerciseItemDetailModel;
  }

  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  @override
  void onInit() {
    super.onInit();
    // print(
    //     "${ApiUrls.s3VideoAudioBaseUrl}Exercise/${exerciseItemDetailModel!.videoFile}");
    print(
        "completed duration${exerciseItemDetailModel!.userExerciseDuration!}");
    initializedPlayer(
        "${ApiUrls.s3VideoAudioBaseUrl}Exercise/${exerciseItemDetailModel!.videoFile}");
  }

  void videoListener() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      if (videoPlayerController.value.position ==
          videoPlayerController.value.duration) {
        isShowVideoPlayer.value = false;
        isStopped.value = false;
        if (!countDownController.isStarted) {
          countDownController.start();
        }
      }
    });
  }

  @override
  void onClose() {
    videoPlayerController.dispose();
    if (chewieController != null) {
      chewieController!.dispose();
    }
    videoPlayerController.removeListener(() {});
    super.onClose();
  }

  Future<void> initializedPlayer(String? videoUrl) async {
    try {
      videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(videoUrl!),
      );
      await videoPlayerController.initialize();
      videoPlayerController.addListener(videoListener);
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
          allowFullScreen: false,
          autoInitialize: true,
          allowedScreenSleep: false);
      update();
    } catch (e) {
      print(e);
    }
  }

  final ApiService apiService = ApiService();
  Future<void> updateExerciseTime(
    int exerciseIndex, {
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
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.post(
        ApiUrls.updateExerciseTime,
        jsonEncode(bodyData),
        authToken: token,
      );

      if (response.statusCode == 200) {
        var dataObj = await jsonDecode(response.body);
        log(dataObj.toString());
        if (exerciseIndex == 0) {
          await Get.find<HomeInnerTodayController>().getTodayExerciseApi();
        }

        await Get.find<ProgressUserController>().getUserStats();
        await Get.find<DiaryController>().getDiaryDetail(DateTime.now());
        isLoading.value = false;
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.success, message: 'Time not update');
      }
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }
}
