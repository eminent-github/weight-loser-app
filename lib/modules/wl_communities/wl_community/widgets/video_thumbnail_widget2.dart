// import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:weight_loss_app/common/app_colors.dart';

class VideoThumbnailWidget extends StatefulWidget {
  final String videoUrl;

  const VideoThumbnailWidget({super.key, required this.videoUrl});

  @override
  State<VideoThumbnailWidget> createState() => _VideoThumbnailWidgetState();
}

class _VideoThumbnailWidgetState extends State<VideoThumbnailWidget> {
  late Future<Uint8List?> thumb;
  @override
  void initState() {
    thumb = VideoThumbnail.thumbnailData(
      video: widget.videoUrl,
      imageFormat: ImageFormat.PNG,
      quality: 50,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: thumb,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(
                Icons.play_circle_outline_rounded,
                size: 50,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return const Icon(Icons.error_outline);
        } else if (snapshot.hasData) {
          // log("snap${snapshot.data!}");
          return Stack(
            alignment: Alignment.center,
            children: [
              Image.memory(
                snapshot.data!,
                fit: BoxFit.cover,
                height: Get.height,
                width: Get.width,
                gaplessPlayback: true,
              ),
              const Icon(
                Icons.play_circle_outline_rounded,
                color: AppColors.white,
                shadows: [
                  BoxShadow(
                    color: Colors.black54,
                    spreadRadius: 5,
                    blurRadius: 7,
                  ),
                ],
                size: 45,
              ),
            ],
          );
        } else {
          return const Text('No Thumbnail');
        }
      },
    );
  }
}
