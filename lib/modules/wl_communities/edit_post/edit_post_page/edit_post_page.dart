import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/deep_sleep/screen/sleep_Video_screen/sleep_video_screen.dart';
import 'package:weight_loss_app/modules/wl_communities/edit_post/controller/edit_post_controller.dart';
import 'package:weight_loss_app/modules/wl_communities/wl_community/widgets/video_thumbnail_widget2.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';

class EditPostPage extends GetView<EditPostController> {
  const EditPostPage({
    super.key,
    required this.chatId,
    required this.fileId,
  });
  final int chatId;
  final int fileId;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          iconTheme: Theme.of(context).iconTheme,
          title: Text(
            "Edit Post",
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: height * 0.015),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: controller.imageApiIdsList.isEmpty &&
                          controller.postTextValue.isEmpty
                      ? MaterialStateProperty.all<Color>(
                          AppColors.containerShadowColor)
                      : MaterialStateProperty.all<Color>(
                          AppColors.buttonColor,
                        ), // Change to your desired color
                ),
                onPressed: controller.imageApiIdsList.isEmpty &&
                        controller.postTextValue.value.isEmpty
                    ? () {}
                    : () {
                        if (controller.postTextValue.value.isNotEmpty) {
                          if (!controller.isTextOnlySpaces(
                              controller.postTextValue.value)) {
                            controller.editPost(chatId, fileId);
                          }
                        } else {
                          controller.editPost(chatId, fileId);
                        }
                      },
                child: Center(
                  child: Text(
                    'POST',
                    style: AppTextStyles.formalTextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: InternetCheckWidget<ConnectivityService>(
          child: Stack(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      flex: 9,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.05,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              TextFormField(
                                controller: controller.postTextController.value,
                                maxLines: null,
                                onChanged: (value) {
                                  controller.postTextValue.value = value;
                                },
                                style: AppTextStyles.formalTextStyle(
                                    fontSize: controller.imageApiIdsList.isEmpty
                                        ? 25
                                        : 19,
                                    fontWeight: FontWeight.w200),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: controller.imageApiIdsList.isEmpty
                                      ? "What's on your mind?"
                                      : "Say something about this photo...",
                                  hintStyle: AppTextStyles.formalTextStyle(
                                      fontSize:
                                          controller.imageApiIdsList.isEmpty
                                              ? 25
                                              : 19,
                                      color: AppColors.gray,
                                      fontWeight: FontWeight.w200),
                                ),
                              ),
                              ListView.builder(
                                itemCount: controller.imageApiIdsList.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: controller.imageApiIdsList.isEmpty
                                        ? const SizedBox()
                                        : Stack(
                                            children: [
                                              controller.imageApiIdsList[index]
                                                      .contains(".mp4")
                                                  ? InkWell(
                                                      onTap: () {
                                                        Get.to(
                                                          () =>
                                                              CustomSleepVideoPlayer(
                                                            videoUrl: ApiUrls
                                                                    .videoBaseUrl +
                                                                controller
                                                                        .imageApiIdsList[
                                                                    index],
                                                            videoTitle: "Video",
                                                          ),
                                                        );
                                                      },
                                                      child:
                                                          VideoThumbnailWidget(
                                                        videoUrl: ApiUrls
                                                                .videoBaseUrl +
                                                            controller
                                                                    .imageApiIdsList[
                                                                index],
                                                      ),
                                                    )
                                                  : LoadingImage(
                                                      imageUrl: controller
                                                              .imageApiIdsList[
                                                          index],
                                                      fit: BoxFit.cover,
                                                    ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: IconButton(
                                                  onPressed: () {
                                                    controller.imageApiIdsList
                                                        .remove(controller
                                                                .imageApiIdsList[
                                                            index]);
                                                  },
                                                  icon: const Icon(
                                                    Icons.close,
                                                    color: AppColors.white,
                                                    size: 20,
                                                    shadows: [
                                                      BoxShadow(
                                                        color: Colors.black54,
                                                        spreadRadius: 5,
                                                        blurRadius: 7,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.05,
                        ),
                        child: Row(
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () async {
                                  await controller.getImage();
                                },
                                borderRadius: BorderRadius.circular(50),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add_photo_alternate_rounded,
                                      color: AppColors.buttonColor,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: width * 0.02,
                                    ),
                                    Text(
                                      'Photo/video',
                                      style: AppTextStyles.formalTextStyle(
                                        fontSize: 12,
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .titleMedium!
                                            .color!,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.04,
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () async {
                                  await controller
                                      .getCameraImage(ImageSource.camera);
                                },
                                borderRadius: BorderRadius.circular(50),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.photo_camera_outlined,
                                      color: AppColors.buttonColor,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: width * 0.02,
                                    ),
                                    Text(
                                      'Camera',
                                      style: AppTextStyles.formalTextStyle(
                                        fontSize: 12,
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .titleMedium!
                                            .color!,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              controller.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.buttonColor,
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
