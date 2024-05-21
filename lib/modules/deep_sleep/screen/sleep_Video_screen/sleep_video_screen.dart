import 'dart:developer';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/deep_sleep/screen/widgets/sleep_custom_progress_bar.dart';
import 'package:weight_loss_app/modules/deep_sleep/screen/widgets/sleep_play_pause_button.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';

class CustomSleepVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final String videoTitle;
  const CustomSleepVideoPlayer(
      {super.key, required this.videoUrl, required this.videoTitle});
  @override
  CustomSleepVideoPlayerState createState() => CustomSleepVideoPlayerState();
}

class CustomSleepVideoPlayerState extends State<CustomSleepVideoPlayer> {
  late VideoPlayerController _controller;
  bool _showReplayButton = false;
  @override
  void initState() {
    super.initState();
    // print("video url ${widget.videoUrl}");
    try {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl),
          videoPlayerOptions: VideoPlayerOptions(
            allowBackgroundPlayback: true,
          ))
        ..initialize().then((_) {
          _controller.setLooping(false);
          _controller.addListener(_videoListener);
          setState(() {});
        });
    } catch (e) {
      print(e);
    }
  }

  void _videoListener() {
    if (_controller.value.position >= _controller.value.duration) {
      setState(() {
        _showReplayButton = true;
      });
    } else {
      setState(() {
        _showReplayButton = false;
      });
    }
  }

  void _replayVideo() {
    _controller.seekTo(Duration.zero); // Rewind the video
    _controller.play();
    setState(() {
      _showReplayButton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    log('this is video height === ${_controller.value.size.height}');
    // double videoAspectRatio = _controller.value.aspectRatio;
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: AutoSizeText(
          widget.videoTitle,
          style: AppTextStyles.formalTextStyle(
              fontSize: height * 0.024,
              fontWeight: FontWeight.w600,
              color: AppColors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.white),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: InternetCheckWidget<ConnectivityService>(
        child: Center(
          child: _controller.value.isInitialized
              ? Stack(
                  children: [
                    Center(
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: SizedBox(
                          width: _controller.value.size.height < 800
                              ? _controller.value.size.width
                              : width,
                          height: _controller.value.size.height < 800
                              ? _controller.value.size.height
                              : height,
                          child: VideoPlayer(
                            _controller,
                          ),
                        ),
                      ),
                    ),
                    // Positioned(
                    //   top: height * 0.04,
                    //   child: Container(
                    //     height: height * 0.08,
                    //     width: width,
                    //     color: Colors.transparent,
                    //     child: Row(
                    //       children: [
                    //         Flexible(
                    //           flex: 2,
                    //           child: Center(
                    //             child: IconButton(
                    //               onPressed: () {
                    //                 Navigator.pop(context);
                    //               },
                    //               icon: Icon(
                    //                 Icons.arrow_back,
                    //                 color: AppColors.white,
                    //                 size: height * 0.036,
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //         Flexible(
                    //           flex: 6,
                    //           child: Center(
                    //             child: Text(
                    //               widget.videoTitle,
                    //               style: const TextStyle(
                    //                 color: Colors.white,
                    //                 fontSize: 22,
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //         const Flexible(
                    //           flex: 2,
                    //           child: SizedBox(),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    if (_showReplayButton)
                      Center(
                        child: IconButton(
                          onPressed: _replayVideo,
                          icon: Icon(
                            Icons.replay,
                            size: height * 0.08,
                            color: Colors.white,
                          ),
                          // child: const Text('Replay'),
                        ),
                      ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SleepCustomProgressBar(controller: _controller),
                        SizedBox(
                          height: height * 0.006,
                        ),
                        SleepPlayPauseButton(
                          isPlaying: _controller.value
                              .isPlaying, // Set to true if video is playing, false if paused
                          onTap: () {
                            setState(() {
                              if (_controller.value.isPlaying) {
                                _controller.pause();
                              } else {
                                _controller.play();
                              }
                            });
                          },
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                      ],
                    ),
                  ],
                )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
