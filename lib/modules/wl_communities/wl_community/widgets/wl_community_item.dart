import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/deep_sleep/screen/sleep_Video_screen/sleep_video_screen.dart';
import 'package:weight_loss_app/modules/wl_communities/wl_community/controller/wl_community_controller.dart';
import 'package:weight_loss_app/modules/wl_communities/wl_community/model/wl_community_model.dart';
import 'package:weight_loss_app/modules/wl_communities/wl_community/screen/post_detial_screen.dart';
import 'package:weight_loss_app/modules/wl_communities/wl_community/widgets/image_post_detail.dart';
import 'package:weight_loss_app/modules/wl_communities/wl_community/widgets/post_comments_widget.dart';
import 'package:weight_loss_app/modules/wl_communities/wl_community/widgets/video_thumbnail_widget2.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';

class WlCommunityItem extends StatelessWidget {
  const WlCommunityItem({
    super.key,
    required this.controller,
    required this.communityPost,
  });
  final WlCommunityController controller;
  final CommunityAllPostsModel communityPost;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return communityPost.chatPoster!.filename!.isNotEmpty
        ? SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.5,
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              communityPost.chatPoster!.imgPath == null
                                  ? const CircleAvatar(
                                      backgroundColor: Color(0xffE5E7EB),
                                      child: Icon(
                                        Icons.person,
                                        color: AppColors.white,
                                      ),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: const Color(0xffE5E7EB),
                                      backgroundImage: NetworkImage(ApiUrls
                                              .imageBaseUrl +
                                          communityPost.chatPoster!.imgPath!),
                                    ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  width: 9.23,
                                  height: 9.23,
                                  decoration: ShapeDecoration(
                                    color: communityPost.chatPoster!.isActive!
                                        ? const Color(0xFF44B461)
                                        : const Color(0xffE5E7EB),
                                    shape: const OvalBorder(
                                      side: BorderSide(
                                          width: 1.54, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          AutoSizeText(
                            communityPost.chatPoster!.name.toString(),
                            minFontSize: 5,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium!
                                  .color!,
                              fontSize: 12,
                              fontFamily: AppTextStyles.fontFamily,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                SizedBox(
                  width: width,
                  child: Text(
                    communityPost.chatPoster!.text!,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: AppColors.iconTextColor,
                      fontSize: 10.77,
                      fontFamily: AppTextStyles.fontFamily,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: const Color(0xFFD9D9D9),
                  child: communityPost.chatPoster!.filename!.length == 1
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            height: height * 0.45,
                            child: communityPost.chatPoster!.filename![0]
                                    .toLowerCase()
                                    .endsWith('.mp4')
                                ? InkWell(
                                    onTap: () {
                                      Get.to(
                                        () => CustomSleepVideoPlayer(
                                          videoUrl: ApiUrls.videoBaseUrl +
                                              communityPost
                                                  .chatPoster!.filename![0],
                                          videoTitle: "Video",
                                        ),
                                      );
                                    },
                                    child: VideoThumbnailWidget(
                                      videoUrl: ApiUrls.videoBaseUrl +
                                          communityPost
                                              .chatPoster!.filename![0],
                                    ),
                                  )
                                : MyImageDetial(
                                    id: UniqueKey().toString(),
                                    image: LoadingImage(
                                      imageUrl: communityPost
                                          .chatPoster!.filename![0],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            Get.to(
                              () => PostDetailScreen(
                                fileUrlList:
                                    communityPost.chatPoster!.filename!,
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 3,
                                      mainAxisSpacing: 3),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  communityPost.chatPoster!.filename!.length > 4
                                      ? 4
                                      : communityPost
                                          .chatPoster!.filename!.length,
                              itemBuilder: (BuildContext context, int index) {
                                String mediaFile =
                                    communityPost.chatPoster!.filename![index];
                                bool isVideo =
                                    mediaFile.toLowerCase().endsWith('.mp4');
                                if (index == 3 &&
                                    communityPost.chatPoster!.filename!.length >
                                        4) {
                                  return Stack(
                                    children: [
                                      isVideo
                                          ? VideoThumbnailWidget(
                                              videoUrl: ApiUrls.videoBaseUrl +
                                                  mediaFile,
                                            )
                                          : LoadingImage(
                                              imageUrl: mediaFile,
                                              fit: BoxFit.cover,
                                            ),
                                      Positioned.fill(
                                        child: Container(
                                          color: Colors.black.withOpacity(0.6),
                                          child: Center(
                                            child: Text(
                                              "+${communityPost.chatPoster!.filename!.length - 3}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return isVideo
                                      ? VideoThumbnailWidget(
                                          videoUrl:
                                              ApiUrls.videoBaseUrl + mediaFile,
                                        )
                                      : LoadingImage(
                                          imageUrl: mediaFile,
                                          fit: BoxFit.cover,
                                        );
                                }
                              },
                            ),
                          ),
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: width * 0.32,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.likePost(
                                      chatId: communityPost.chatPoster!.chatId!,
                                      isliked:
                                          communityPost.isLikedByUser == true
                                              ? false
                                              : true);
                                },
                                child: SvgPicture.asset(
                                  AppAssets.favouriteSvg,
                                  color: communityPost.isLikedByUser == true
                                      ? AppColors.buttonColor
                                      : AppColors.iconColor,
                                ),
                              ),
                              Text(
                                " ${communityPost.totalLikes}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: AppColors.iconTextColor,
                                  fontSize: 12.95,
                                  fontFamily: AppTextStyles.fontFamily,
                                  fontWeight: FontWeight.w600,
                                  height: 1.50,
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () async {
                              await showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                showDragHandle: true,
                                builder: (BuildContext context) {
                                  return PostCommentWidget(
                                    chatId: communityPost.chatPoster!.chatId!,
                                  );
                                },
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    AppAssets.chatBubbleSvg,
                                    color: AppColors.iconColor,
                                  ),
                                  Text(
                                    " ${communityPost.totlalComments}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: AppColors.iconTextColor,
                                      fontSize: 12.95,
                                      fontFamily: AppTextStyles.fontFamily,
                                      fontWeight: FontWeight.w600,
                                      height: 1.50,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              log('Share Button clicked');
                              try {
                                controller.isSavedLoading.value = true;
                                await shareNetworkImageWithTitle(
                                    "${ApiUrls.imageBaseUrl}${communityPost.chatPoster!.filename![0]}",
                                    communityPost.chatPoster!.text ?? "");
                              } catch (e) {
                                print(e);
                              }
                            },
                            child: SvgPicture.asset(
                              AppAssets.sendWlSvg,
                            ),
                          )
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // print(communityPost.chatPoster!.chatId!);
                        communityPost.isSavedByUser!
                            ? controller.unSavePost(
                                chatId: communityPost.chatPoster!.chatId!,
                                id: communityPost.chatPoster!.savedId!)
                            : controller.savePost(
                                chatId: communityPost.chatPoster!.chatId!,
                                isSaved: true);
                      },
                      icon: communityPost.isSavedByUser!
                          ? Icon(
                              Icons.bookmark,
                              color: AppColors.buttonColor,
                            )
                          : Icon(
                              Icons.bookmark_border,
                              color: AppColors.iconColor,
                            ),
                    )
                  ],
                ),
              ],
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: width * 0.45,
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            communityPost.chatPoster!.imgPath == null
                                ? const CircleAvatar(
                                    backgroundColor: Color(0xffE5E7EB),
                                    child: Icon(
                                      Icons.person,
                                      color: AppColors.white,
                                    ),
                                  )
                                : CircleAvatar(
                                    backgroundColor: const Color(0xffE5E7EB),
                                    backgroundImage: NetworkImage(
                                        ApiUrls.imageBaseUrl +
                                            communityPost.chatPoster!.imgPath!),
                                  ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                width: 9.23,
                                height: 9.23,
                                decoration: ShapeDecoration(
                                  color: communityPost.chatPoster!.isActive!
                                      ? const Color(0xFF44B461)
                                      : const Color(0xffE5E7EB),
                                  shape: const OvalBorder(
                                    side: BorderSide(
                                        width: 1.54, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Text(
                          communityPost.chatPoster!.name.toString(),
                          style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .titleMedium!
                                .color!,
                            fontSize: 12,
                            fontFamily: AppTextStyles.fontFamily,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                communityPost.chatPoster!.text!,
                style: const TextStyle(
                  color: AppColors.iconTextColor,
                  fontSize: 11,
                  fontFamily: AppTextStyles.fontFamily,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width * 0.23,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.likePost(
                                    chatId: communityPost.chatPoster!.chatId!,
                                    isliked: communityPost.isLikedByUser == true
                                        ? false
                                        : true);
                              },
                              child: SvgPicture.asset(
                                AppAssets.favouriteSvg,
                                color: communityPost.isLikedByUser == true
                                    ? AppColors.buttonColor
                                    : AppColors.iconColor,
                              ),
                            ),
                            Text(
                              " ${communityPost.totalLikes}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppColors.iconTextColor,
                                fontSize: 12.95,
                                fontFamily: AppTextStyles.fontFamily,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () async {
                            await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              showDragHandle: true,
                              builder: (BuildContext context) {
                                return PostCommentWidget(
                                  chatId: communityPost.chatPoster!.chatId!,
                                );
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  AppAssets.chatBubbleSvg,
                                  color: AppColors.iconColor,
                                ),
                                Text(
                                  " ${communityPost.totlalComments}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: AppColors.iconTextColor,
                                    fontSize: 12.95,
                                    fontFamily: AppTextStyles.fontFamily,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Share.share(communityPost.chatPoster!.text!);
                    },
                    icon: Icon(
                      Icons.share,
                      color: AppColors.iconColor,
                    ),
                  )
                ],
              ),
            ],
          );
  }

  Future<Uint8List> downloadImage(String imageUrl) async {
    controller.isSavedLoading.value = true;
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      controller.isSavedLoading.value = false;
      throw Exception('Failed to Send image');
    }
  }

  Future<File> getTemporaryFileFromNetwork(String imageUrl) async {
    final imageData = await downloadImage(imageUrl);
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/${DateTime.now()}.png');
    await tempFile.writeAsBytes(imageData, flush: true);
    return tempFile;
  }

  Future<void> shareNetworkImageWithTitle(String imageUrl, String title) async {
    final tempFile = await getTemporaryFileFromNetwork(imageUrl);
    controller.isSavedLoading.value = false;
    await Share.shareXFiles([XFile(tempFile.path)], text: title);
  }
}
