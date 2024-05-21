import 'dart:convert';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/diary/controller/diary_controller.dart';
import 'package:weight_loss_app/modules/mind/mind_plan_detail/models/mind_item_detail_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class MindTimerController extends GetxController {
  var isPostLoading = false.obs;
  var isAudioLoading = false.obs;
  MindItemDetailModel? mindItemDetailModel;

  void getModel(MindItemDetailModel? imindItemDetailModel) {
    mindItemDetailModel = imindItemDetailModel;
  }

  final ApiService apiService = ApiService();
  Future<void> updateMindTime({
    required int planId,
    required int videoId,
    required String duration,
  }) async {
    if (assetsAudioPlayer.isPlaying.value) {
      await assetsAudioPlayer.stop();
    }
    Map<String, dynamic> bodyData = {
      "videoId": videoId,
      "planId": planId,
      "duration": duration
    };
    try {
      isPostLoading.value = true;

      String? token = await StorageServivce.getToken();
      var response = await apiService.post(
        ApiUrls.updateMindTime,
        jsonEncode(bodyData),
        authToken: token,
      );
      print("status code: ${response.statusCode} body : ${response.body}");
      if (response.statusCode == 200) {
        // var dataObj = await jsonDecode(response.body);
        // log(dataObj.toString());
        Get.find<DiaryController>()
            .getDiaryDetail(DateTime.now())
            .then((value) async {
          isPostLoading.value = false;
        }).onError((error, stackTrace) {
          isPostLoading.value = false;
        });
      } else {
        isPostLoading.value = false;

        customSnackbar(title: AppTexts.success, message: 'Time not update');
      }
    } catch (e) {
      isPostLoading.value = false;
    }
  }

  late AssetsAudioPlayer assetsAudioPlayer;
  @override
  void dispose() async {
    super.dispose();
    await assetsAudioPlayer.stop();
    await assetsAudioPlayer.dispose();
  }

  // MindItemDetailModel? mindItemDetailModel;
  // void getMindAudioModel(MindItemDetailModel nMindItemDetailModel) {
  //   mindItemDetailModel = nMindItemDetailModel;
  // }

  @override
  void onInit() {
    // print(
    //     "${ApiUrls.s3VideoAudioBaseUrl}Mind/${widget.mindItemDetailModel.videoFile!}");
    isAudioLoading.value = true;
    assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    initAudio();
    super.onInit();
  }

  void initAudio() async {
    await assetsAudioPlayer
        .open(
            Audio.network(
              "${ApiUrls.s3VideoAudioBaseUrl}Mind/${mindItemDetailModel!.videoFile!}",
              // cached: true,
            ),
            autoStart: true,
            loopMode: LoopMode.none,
            showNotification: false,
            playInBackground: PlayInBackground.enabled,
            seek: Duration(
                seconds: mindItemDetailModel!.watchedVideoDuration ?? 0))
        .then(
          (value) => isAudioLoading.value = false,
        )
        .onError(
          (error, stackTrace) => isAudioLoading.value = false,
        );
  }

  Future<void> toggleAudio() async {
    if (assetsAudioPlayer.isPlaying.value) {
      await assetsAudioPlayer.pause();
    } else {
      await assetsAudioPlayer.play();
    }
  }

  Future<void> toogleback() async {
    // print(assetsAudioPlayer.currentPosition.value.inSeconds);
    await updateMindTime(
        duration: assetsAudioPlayer.currentPosition.value.inSeconds.toString(),
        planId: mindItemDetailModel!.planId!,
        videoId: mindItemDetailModel!.vidId!);
  }
}
