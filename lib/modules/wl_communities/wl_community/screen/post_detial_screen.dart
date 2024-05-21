import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/modules/deep_sleep/screen/sleep_Video_screen/sleep_video_screen.dart';
import 'package:weight_loss_app/modules/wl_communities/wl_community/widgets/video_thumbnail_widget2.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({super.key, required this.fileUrlList});
  final List<String> fileUrlList;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Scaffold(
      // backgroundColor: AppColors.greyDim,
      body: InternetCheckWidget<ConnectivityService>(
        child: SafeArea(
          child: ListView.builder(
            itemCount: fileUrlList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  fileUrlList[index].contains(".mp4")
                      ? InkWell(
                          onTap: () {
                            Get.to(
                              () => CustomSleepVideoPlayer(
                                videoUrl:
                                    ApiUrls.videoBaseUrl + fileUrlList[index],
                                videoTitle: "Video",
                              ),
                            );
                          },
                          child: VideoThumbnailWidget(
                            videoUrl: ApiUrls.videoBaseUrl + fileUrlList[index],
                            
                          ),
                        )
                      // AspectRatio(
                      //   aspectRatio: 16/9,
                      //   child: InkWell(
                      //       onTap: () {
                      //         Get.to(
                      //           () => CustomSleepVideoPlayer(
                      //             videoUrl:
                      //                 ApiUrls.videoBaseUrl + fileUrlList[index],
                      //             videoTitle: "Video",
                      //           ),
                      //         );
                      //       },
                      //       child: Container(
                      //         decoration: const BoxDecoration(
                      //           image: DecorationImage(
                      //               image: AssetImage(AppAssets.sleepVideoImgUrl),
                      //               fit: BoxFit.fill),
                      //         ),
                      //         child: const Center(
                      //           child: Icon(
                      //             Icons.play_circle_outline_rounded,
                      //             color: AppColors.white,
                      //             shadows: [
                      //               BoxShadow(
                      //                 color: Colors.black54,
                      //                 spreadRadius: 5,
                      //                 blurRadius: 7,
                      //               ),
                      //             ],
                      //             size: 45,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      // )
                      : LoadingImage(
                          imageUrl: fileUrlList[index],
                          fit: BoxFit.contain,
                        ),
                  Container(
                    color: AppColors.greyDim,
                    height: height * 0.015,
                    margin: EdgeInsets.symmetric(vertical: height * 0.02),
                    width: width,
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

Future<Widget> getVideoThumbnail(String videoUrl) async {
  final thumbnailPath = await VideoThumbnail.thumbnailFile(
    video: videoUrl,
    thumbnailPath: (await getTemporaryDirectory()).path,
    imageFormat: ImageFormat.WEBP,
    quality: 100,
  );
  final thumbnailWidget = Image.file(
    File(thumbnailPath!),
    fit: BoxFit.fill,
  );
  return thumbnailWidget;
}
