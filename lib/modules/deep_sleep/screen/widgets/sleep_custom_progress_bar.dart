import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';

class SleepCustomProgressBar extends StatelessWidget {
  final VideoPlayerController controller;
  const SleepCustomProgressBar({super.key, required this.controller});
  @override
  Widget build(BuildContext context) {
    // print("video time${controller.value.position}");
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 365,
            height: 43,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: ShapeDecoration(
              color: Colors.white.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      _formatDuration(
                        controller.value.position,
                      ),
                      style:
                          AppTextStyles.formalTextStyle(color: AppColors.white),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: SizedBox(
                    height: 28,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: VideoProgressIndicator(
                        controller,
                        allowScrubbing: true,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        colors: const VideoProgressColors(
                          backgroundColor: Color(0xFFD9D9D9),
                          bufferedColor: Color.fromARGB(255, 190, 186, 186),
                          playedColor: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      _formatDuration(
                        controller.value.duration,
                      ),
                      style:
                          AppTextStyles.formalTextStyle(color: AppColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }
}
