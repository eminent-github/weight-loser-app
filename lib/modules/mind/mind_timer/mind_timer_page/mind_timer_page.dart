import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/modules/mind/mind_timer/controller/mind_timer_controller.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

import '../../../../common/app_assets.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';

class AudioPlayerScreen extends GetView<MindTimerController> {
  const AudioPlayerScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return WillPopScope(
      onWillPop: () async {
        await controller.toogleback();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: AutoSizeText(
            controller.mindItemDetailModel!.title!,
            style: AppTextStyles.formalTextStyle(
                fontSize: height * 0.024,
                fontWeight: FontWeight.w600,
                color: AppColors.white),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppColors.white),
          backgroundColor: Colors.transparent,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Obx(
          () => Stack(
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      height: height * 0.6,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          controller.mindItemDetailModel!.imageFile == null
                              ? ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(40),
                                    bottomRight: Radius.circular(40),
                                  ),
                                  child: Image.asset(
                                    AppAssets.mindImgUrl,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Hero(
                                  tag:
                                      "${ApiUrls.s3ImageBaseUrl}Mind/${controller.mindItemDetailModel!.imageFile!}",
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(40),
                                      bottomRight: Radius.circular(40),
                                    ),
                                    child: S3LoadingImage(
                                      imageUrl:
                                          "${ApiUrls.s3ImageBaseUrl}Mind/${controller.mindItemDetailModel!.imageFile!}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                          Container(
                            decoration: BoxDecoration(
                                color: AppColors.black.withOpacity(0.3),
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(40),
                                    bottomRight: Radius.circular(40))),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.1,
                    ),
                    controller.isAudioLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.05),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: StreamBuilder(
                                          stream: controller.assetsAudioPlayer
                                              .currentPosition,
                                          initialData: const Duration(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<Duration?>
                                                  snapshot) {
                                            var duration = const Duration();
                                            if (snapshot.hasData) {
                                              duration = snapshot.data!;
                                            }
                                            return Text(
                                                durationToString(duration));
                                          },
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: StreamBuilder(
                                        stream: controller
                                            .assetsAudioPlayer.currentPosition,
                                        builder: (context, snapshot) {
                                          final position =
                                              snapshot.data ?? Duration.zero;

                                          return StreamBuilder(
                                            stream: controller
                                                .assetsAudioPlayer.current,
                                            builder: (context, snapshot) {
                                              final totalDuration = snapshot
                                                      .data?.audio.duration ??
                                                  Duration.zero;
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const SizedBox();
                                              } else {
                                                return Slider(
                                                  activeColor:
                                                      AppColors.buttonColor,
                                                  value: position.inMilliseconds
                                                      .toDouble(),
                                                  onChanged: (value) {
                                                    controller.assetsAudioPlayer
                                                        .seek(
                                                      Duration(
                                                        milliseconds:
                                                            value.round(),
                                                      ),
                                                    );
                                                  },
                                                  min: 0.0,
                                                  max: totalDuration
                                                      .inMilliseconds
                                                      .toDouble(),
                                                );
                                              }
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: StreamBuilder(
                                          stream: controller
                                              .assetsAudioPlayer.current,
                                          builder: (BuildContext context,
                                              AsyncSnapshot<Playing?>
                                                  snapshot) {
                                            var duration = const Duration();
                                            if (snapshot.hasData) {
                                              duration =
                                                  snapshot.data!.audio.duration;
                                            }
                                            return Text(
                                                durationToString(duration));
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.03,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.05),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          controller.assetsAudioPlayer.seekBy(
                                              const Duration(seconds: -10));
                                        },
                                        icon: Icon(
                                          Icons.replay_10_rounded,
                                          color: AppColors.buttonColor,
                                          size: min(width, height) * 0.1,
                                        ),
                                      ),
                                      Container(
                                        width: width * 0.2,
                                        height: height * 0.1,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 2,
                                              color: AppColors.buttonColor),
                                        ),
                                        child: Center(
                                          child: Container(
                                            width: width * 0.17,
                                            height: height * 0.15,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.buttonColor),
                                            child: IconButton(
                                              iconSize: height * 0.05,
                                              icon: StreamBuilder(
                                                  stream: controller
                                                      .assetsAudioPlayer
                                                      .isPlaying,
                                                  builder: (context, snapshot) {
                                                    bool isOn =
                                                        snapshot.data ?? false;
                                                    return Icon(
                                                      isOn
                                                          ? Icons.pause
                                                          : Icons.play_arrow,
                                                      color: AppColors.white,
                                                    );
                                                  }),
                                              onPressed: () {
                                                controller.toggleAudio();
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          controller.assetsAudioPlayer.seekBy(
                                              const Duration(seconds: 10));
                                        },
                                        icon: Icon(
                                          Icons.forward_10_rounded,
                                          color: AppColors.buttonColor,
                                          size: min(width, height) * 0.1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                  ],
                ),
              ),
              controller.isPostLoading.value
                  ? const OverlayWidget()
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  String durationToString(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return '$n';
      return '0$n';
    }

    final twoDigitMinutes =
        twoDigits(duration.inMinutes.remainder(Duration.minutesPerHour));
    final twoDigitSeconds =
        twoDigits(duration.inSeconds.remainder(Duration.secondsPerMinute));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }
}
