import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/modules/wl_communities/wl_community/model/wl_community_model.dart';
import 'package:weight_loss_app/modules/wl_communities/wl_community/screen/post_detial_screen.dart';
import 'package:weight_loss_app/modules/wl_communities/wl_community/widgets/video_thumbnail_widget2.dart';
import 'package:weight_loss_app/modules/wl_communities/wl_status_detail/controller/wl_status_detail_controller.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';
import '../../../../common/app_assets.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class WlStatusDetailPage extends GetView<WlStatusDetailController> {
  const WlStatusDetailPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Theme(
      data: Theme.of(context).copyWith(
        dividerTheme: const DividerThemeData(
          color: Colors.transparent,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          iconTheme: Theme.of(context).iconTheme,
          title: Text(
            AppTexts.statusDetailText,
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          centerTitle: true,
        ),
        body: InternetCheckWidget<ConnectivityService>(
          child: Obx(
            () => Stack(
              children: [
                controller.isSavedDetialLoading.value
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.buttonColor,
                        ),
                      )
                    : SafeArea(
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.06),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      Row(
                                        children: [
                                          Stack(
                                            children: [
                                              controller
                                                          .communitySavedPostsModel
                                                          .value
                                                          .chatPoster!
                                                          .imgPath ==
                                                      null
                                                  ? const CircleAvatar(
                                                      backgroundColor:
                                                          Color(0xffE5E7EB),
                                                      child: Icon(
                                                        Icons.person,
                                                        color: AppColors.white,
                                                      ),
                                                    )
                                                  : CircleAvatar(
                                                      backgroundColor:
                                                          const Color(
                                                              0xffE5E7EB),
                                                      backgroundImage:
                                                          NetworkImage(
                                                        ApiUrls.imageBaseUrl +
                                                            controller
                                                                .communitySavedPostsModel
                                                                .value
                                                                .chatPoster!
                                                                .imgPath!,
                                                      ),
                                                    ),
                                              Positioned(
                                                right: 0,
                                                bottom: 0,
                                                child: Container(
                                                  width: 9.23,
                                                  height: 9.23,
                                                  decoration: ShapeDecoration(
                                                    color: controller
                                                            .communitySavedPostsModel
                                                            .value
                                                            .chatPoster!
                                                            .isActive!
                                                        ? const Color(
                                                            0xFF44B461)
                                                        : const Color(
                                                            0xffE5E7EB),
                                                    shape: const OvalBorder(
                                                      side: BorderSide(
                                                          width: 1.54,
                                                          color: Colors.white),
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
                                            controller.communitySavedPostsModel
                                                .value.chatPoster!.name
                                                .toString(),
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryTextTheme
                                                  .titleMedium!
                                                  .color!,
                                              fontSize: 12,
                                              fontFamily:
                                                  AppTextStyles.fontFamily,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: -0.12,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      Text(
                                        controller.communitySavedPostsModel
                                                    .value.chatPoster!.text ==
                                                null
                                            ? ""
                                            : controller
                                                .communitySavedPostsModel
                                                .value
                                                .chatPoster!
                                                .text!,
                                        style: AppTextStyles.formalTextStyle(
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .titleMedium!
                                              .color!,
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      Card(
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        color: Colors.transparent,
                                        child: controller
                                                    .communitySavedPostsModel
                                                    .value
                                                    .chatPoster!
                                                    .filename!
                                                    .length ==
                                                1
                                            ? InkWell(
                                                onTap: () {
                                                  Get.to(
                                                    () => PostDetailScreen(
                                                      fileUrlList: controller
                                                          .communitySavedPostsModel
                                                          .value
                                                          .chatPoster!
                                                          .filename!,
                                                    ),
                                                  );
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: SizedBox(
                                                    height: height * 0.25,
                                                    child: controller
                                                            .communitySavedPostsModel
                                                            .value
                                                            .chatPoster!
                                                            .filename![0]
                                                            .toLowerCase()
                                                            .endsWith('.mp4')
                                                        ? VideoThumbnailWidget(
                                                            videoUrl: ApiUrls
                                                                    .videoBaseUrl +
                                                                controller
                                                                    .communitySavedPostsModel
                                                                    .value
                                                                    .chatPoster!
                                                                    .filename![0],
                                                          )
                                                        : Center(
                                                            child: LoadingImage(
                                                              imageUrl: controller
                                                                  .communitySavedPostsModel
                                                                  .value
                                                                  .chatPoster!
                                                                  .filename![0],
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                  ),
                                                ),
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  Get.to(
                                                    () => PostDetailScreen(
                                                      fileUrlList: controller
                                                          .communitySavedPostsModel
                                                          .value
                                                          .chatPoster!
                                                          .filename!,
                                                    ),
                                                  );
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: GridView.builder(
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      crossAxisSpacing: 3,
                                                      mainAxisSpacing: 3,
                                                      childAspectRatio: 1.3,
                                                    ),
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemCount: controller
                                                                .communitySavedPostsModel
                                                                .value
                                                                .chatPoster!
                                                                .filename!
                                                                .length >
                                                            4
                                                        ? 4
                                                        : controller
                                                            .communitySavedPostsModel
                                                            .value
                                                            .chatPoster!
                                                            .filename!
                                                            .length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      String mediaFile = controller
                                                          .communitySavedPostsModel
                                                          .value
                                                          .chatPoster!
                                                          .filename![index];
                                                      bool isVideo = mediaFile
                                                          .toLowerCase()
                                                          .endsWith('.mp4');
                                                      if (index == 3 &&
                                                          controller
                                                                  .communitySavedPostsModel
                                                                  .value
                                                                  .chatPoster!
                                                                  .filename!
                                                                  .length >
                                                              4) {
                                                        return Stack(
                                                          children: [
                                                            isVideo
                                                                ? VideoThumbnailWidget(
                                                                    videoUrl: ApiUrls
                                                                            .videoBaseUrl +
                                                                        mediaFile,
                                                                  )
                                                                : LoadingImage(
                                                                    imageUrl:
                                                                        mediaFile,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                            Positioned.fill(
                                                              child: Container(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.6),
                                                                child: Center(
                                                                  child: Text(
                                                                    "+${controller.communitySavedPostsModel.value.chatPoster!.filename!.length - 3}",
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          24,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
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
                                                                videoUrl: ApiUrls
                                                                        .videoBaseUrl +
                                                                    mediaFile)
                                                            : LoadingImage(
                                                                imageUrl:
                                                                    mediaFile,
                                                                fit: BoxFit
                                                                    .cover,
                                                              );
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: width * 0.32,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        controller.likePost(
                                                            chatId: controller
                                                                .communitySavedPostsModel
                                                                .value
                                                                .chatPoster!
                                                                .chatId!,
                                                            isliked: controller
                                                                        .communitySavedPostsModel
                                                                        .value
                                                                        .isLikedByUser ==
                                                                    true
                                                                ? false
                                                                : true);
                                                      },
                                                      child: SvgPicture.asset(
                                                        AppAssets.favouriteSvg,
                                                        color: controller
                                                                    .communitySavedPostsModel
                                                                    .value
                                                                    .isLikedByUser ==
                                                                true
                                                            ? AppColors
                                                                .buttonColor
                                                            : AppColors
                                                                .iconColor,
                                                      ),
                                                    ),
                                                    Text(
                                                      " ${controller.communitySavedPostsModel.value.totalLikes}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                        color: AppColors
                                                            .iconTextColor,
                                                        fontSize: 12.95,
                                                        fontFamily:
                                                            AppTextStyles
                                                                .fontFamily,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      AppAssets.chatBubbleSvg,
                                                      color:
                                                          AppColors.iconColor,
                                                    ),
                                                    Text(
                                                      " ${controller.communitySavedPostsModel.value.totlalComments}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                        color: AppColors
                                                            .iconTextColor,
                                                        fontSize: 12.95,
                                                        fontFamily:
                                                            AppTextStyles
                                                                .fontFamily,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 1.50,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    try {
                                                      await shareNetworkImageWithTitle(
                                                          "${ApiUrls.imageBaseUrl}${controller.communitySavedPostsModel.value.chatPoster!.filename![0]}",
                                                          controller
                                                                  .communitySavedPostsModel
                                                                  .value
                                                                  .chatPoster!
                                                                  .text ??
                                                              "");
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
                                        ],
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      Text(
                                        AppTexts.commentsText,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .titleMedium!
                                              .color!,
                                          fontSize: 16,
                                          fontFamily: AppTextStyles.fontFamily,
                                          fontWeight: FontWeight.w600,
                                          height: 1.38,
                                          letterSpacing: -0.16,
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      controller.isCommentsLoading.value
                                          ? Center(
                                              child: CircularProgressIndicator(
                                                color: AppColors.buttonColor,
                                              ),
                                            )
                                          : controller.userCommentsList.isEmpty
                                              ? Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Icon(
                                                        Icons.forum_outlined,
                                                        color:
                                                            Color(0xffE5E7EB),
                                                        size: 70,
                                                      ),
                                                      Text(
                                                        "No Comments Yet",
                                                        style: AppTextStyles
                                                            .formalTextStyle(
                                                          color: const Color(
                                                              0xff929193),
                                                        ),
                                                      ),
                                                      Text(
                                                        "Be the first to comment",
                                                        style: AppTextStyles
                                                            .formalTextStyle(
                                                          fontSize: 12,
                                                          color: const Color(
                                                              0xff929193),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : ListView.builder(
                                                  itemCount: controller
                                                      .userCommentsList.length,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  reverse: true,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var list = controller
                                                        .userCommentsList
                                                        .reversed
                                                        .toList();
                                                    var comment = list[index];
                                                    return comment.comment ==
                                                            null
                                                        ? const SizedBox()
                                                        : Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        height *
                                                                            0.01,
                                                                    horizontal:
                                                                        width *
                                                                            0.05),
                                                            child: Container(
                                                              padding: EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      width *
                                                                          0.05,
                                                                  vertical:
                                                                      height *
                                                                          0.01),
                                                              clipBehavior: Clip
                                                                  .antiAlias,
                                                              decoration:
                                                                  const ShapeDecoration(
                                                                color: Colors
                                                                    .white,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            12),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            12),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            4),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            12),
                                                                  ),
                                                                ),
                                                                shadows: [
                                                                  BoxShadow(
                                                                    color: Color(
                                                                        0x0C515151),
                                                                    blurRadius:
                                                                        120,
                                                                    offset:
                                                                        Offset(
                                                                            0,
                                                                            0),
                                                                    spreadRadius:
                                                                        0,
                                                                  )
                                                                ],
                                                              ),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Stack(
                                                                        children: [
                                                                          comment.imgPath == null
                                                                              ? const CircleAvatar(
                                                                                  backgroundColor: Color(0xffE5E7EB),
                                                                                  child: Icon(
                                                                                    Icons.person,
                                                                                    color: AppColors.white,
                                                                                  ),
                                                                                )
                                                                              : CircleAvatar(
                                                                                  backgroundColor: const Color(0xffE5E7EB),
                                                                                  backgroundImage: NetworkImage(ApiUrls.imageBaseUrl + comment.imgPath!),
                                                                                ),
                                                                          Positioned(
                                                                            right:
                                                                                0,
                                                                            bottom:
                                                                                0,
                                                                            child:
                                                                                Container(
                                                                              width: 9.23,
                                                                              height: 9.23,
                                                                              decoration: ShapeDecoration(
                                                                                color: comment.isActive! ? const Color(0xFF44B461) : const Color(0xffE5E7EB),
                                                                                shape: const OvalBorder(
                                                                                  side: BorderSide(width: 1.54, color: Colors.white),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        width: width *
                                                                            0.03,
                                                                      ),
                                                                      Text(
                                                                        comment
                                                                            .name
                                                                            .toString(),
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              AppColors.profileWlColorText,
                                                                          fontSize:
                                                                              12,
                                                                          fontFamily:
                                                                              AppTextStyles.fontFamily,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          letterSpacing:
                                                                              -0.12,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 8,
                                                                  ),
                                                                  Text(
                                                                    comment
                                                                        .comment
                                                                        .toString(),
                                                                    style:
                                                                        const TextStyle(
                                                                      color: AppColors
                                                                          .profileWlColorText,
                                                                      fontSize:
                                                                          12,
                                                                      fontFamily:
                                                                          AppTextStyles
                                                                              .fontFamily,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                  },
                                                ),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            AddCommentWidget(
                              height: height,
                              width: width,
                              communitySavedPostsModel:
                                  controller.communitySavedPostsModel.value,
                              controller: controller,
                            ),
                            SizedBox(
                              height: height * 0.015,
                            )
                          ],
                        ),
                      ),
                controller.isSavedCommentLoading.value
                    ? const OverlayWidget()
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Uint8List> downloadImage(String imageUrl) async {
    controller.isSavedCommentLoading.value = true;
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      controller.isSavedCommentLoading.value = false;
      throw Exception('Failed to download image');
    }
  }

  Future<File> getTemporaryFileFromNetwork(String imageUrl) async {
    final imageData = await downloadImage(imageUrl);
    final tempDir = await getTemporaryDirectory();
    final tempFile =
        await File('${tempDir.path}/${DateTime.now()}.png').create();
    await tempFile.writeAsBytes(imageData, flush: true);
    return tempFile;
  }

  Future<void> shareNetworkImageWithTitle(String imageUrl, String title) async {
    final tempFile = await getTemporaryFileFromNetwork(imageUrl);
    controller.isSavedCommentLoading.value = false;
    await Share.shareXFiles([XFile(tempFile.path)], text: title);
  }
}

class AddCommentWidget extends StatelessWidget {
  const AddCommentWidget({
    super.key,
    required this.height,
    required this.width,
    required this.communitySavedPostsModel,
    required this.controller,
  });

  final double height;
  final double width;
  final CommunityAllPostsModel communitySavedPostsModel;
  final WlStatusDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.07,
      width: width * 0.9,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: AppColors.borderColor,
          width: width * 0.0005,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: width * 0.08,
            height: height * 0.04,
            decoration: const ShapeDecoration(
              color: AppColors.containerShadowColor,
              shape: OvalBorder(),
            ),
            child: communitySavedPostsModel.chatPoster!.imgPath == null
                ? const Icon(
                    Icons.person,
                    color: AppColors.white,
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: LoadingImage(
                        imageUrl:
                            communitySavedPostsModel.chatPoster!.imgPath!),
                  ),
          ),
          SizedBox(
            width: width * 0.5,
            child: TextFormField(
              controller: controller.commentController,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.black,
                fontFamily: AppTextStyles.fontFamily,
                fontWeight: FontWeight.w400,
              ),
              decoration: const InputDecoration(
                  hintStyle: TextStyle(
                    color: AppColors.containerShadowColor,
                    fontSize: 12,
                    fontFamily: AppTextStyles.fontFamily,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  hintText: AppTexts.writeCommentText),
            ),
          ),
          TextButton(
            child: Text(
              AppTexts.postText,
              style: TextStyle(
                color: AppColors.buttonColor,
                fontSize: 14,
                fontFamily: AppTextStyles.fontFamily,
                fontWeight: FontWeight.w400,
              ),
            ),
            onPressed: () {
              FocusScope.of(context).unfocus();
              if (controller.commentController.text.isNotEmpty) {
                controller.postComment(
                    chatId: communitySavedPostsModel.chatPoster!.chatId!,
                    comment: controller.commentController.text);
                controller.commentController.clear();
              } else {}
            },
          )
        ],
      ),
    );
  }
}
