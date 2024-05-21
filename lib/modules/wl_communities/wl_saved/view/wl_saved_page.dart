import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/modules/wl_communities/wl_community/model/wl_community_model.dart';
import 'package:weight_loss_app/modules/wl_communities/wl_community/widgets/video_thumbnail_widget2.dart';
import 'package:weight_loss_app/modules/wl_communities/wl_saved/controller/wl_saved_controller.dart';
import 'package:weight_loss_app/modules/wl_communities/wl_status_detail/binding/wl_status_detail_binding.dart';
import 'package:weight_loss_app/modules/wl_communities/wl_status_detail/view/wl_status_detail_page.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';

class WlSavedPage extends GetView<WlSavedController> {
  const WlSavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          AppTexts.savedText,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
      ),
      body: InternetCheckWidget<ConnectivityService>(
        child: Obx(
          () => SafeArea(
            child: controller.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.buttonColor,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(top: height * 0.025),
                    child: controller.communitySavedPostsList.isEmpty
                        ? Center(
                            child: Text(
                              "No Saved Post Found",
                              style: AppTextStyles.formalTextStyle(
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .titleMedium!
                                    .color!,
                              ),
                            ),
                          )
                        : GridView.builder(
                            itemCount:
                                controller.communitySavedPostsList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, index) {
                              CommunityAllPostsModel communitySavedPostsModel =
                                  controller.communitySavedPostsList[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => const WlStatusDetailPage(),
                                      binding: WlStatusDetailBinding(
                                          saveChatId: communitySavedPostsModel
                                              .chatPoster!.chatId!));
                                },
                                child: SizedBox(
                                  width: width * 0.3,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: width * 0.3,
                                        height: height * 0.15,
                                        decoration: const BoxDecoration(
                                          color: AppColors.containerShadowColor,
                                        ),
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            communitySavedPostsModel
                                                    .chatPoster!.filename![0]
                                                    .toLowerCase()
                                                    .endsWith('.mp4')
                                                ? VideoThumbnailWidget(
                                                    videoUrl: ApiUrls
                                                            .videoBaseUrl +
                                                        communitySavedPostsModel
                                                            .chatPoster!
                                                            .filename![0],
                                                  )
                                                : LoadingImage(
                                                    imageUrl:
                                                        communitySavedPostsModel
                                                            .chatPoster!
                                                            .filename![0],
                                                    fit: BoxFit.cover,
                                                  ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: SizedBox(
                                                width: width * 0.1,
                                                height: height * 0.03,
                                                child: PopupMenuButton<String>(
                                                  onSelected: (value) {},
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  constraints: BoxConstraints(
                                                    minWidth: width * 0.22,
                                                    maxWidth: width * 0.22,
                                                  ),
                                                  splashRadius: 20,
                                                  itemBuilder:
                                                      (BuildContext context) {
                                                    return [
                                                      PopupMenuItem<String>(
                                                        onTap: () {
                                                          controller.unSavePost(
                                                              chatId:
                                                                  communitySavedPostsModel
                                                                      .chatPoster!
                                                                      .chatId!,
                                                              id: communitySavedPostsModel
                                                                  .chatPoster!
                                                                  .savedId!);
                                                        },
                                                        child: Center(
                                                          child: Text(
                                                            'Unsaved',
                                                            style: AppTextStyles
                                                                .formalTextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ];
                                                  },
                                                  icon: const Icon(
                                                    Icons.more_horiz,
                                                    color: AppColors.white,
                                                    shadows: [
                                                      BoxShadow(
                                                          offset: Offset(2, 2),
                                                          blurRadius: 5),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      SizedBox(
                                        width: width * 0.3,
                                        child: Text(
                                          communitySavedPostsModel
                                                      .chatPoster!.text ==
                                                  null
                                              ? ""
                                              : communitySavedPostsModel
                                                  .chatPoster!.text!,
                                          style: const TextStyle(
                                            color: AppColors.iconTextColor,
                                            fontSize: 10.77,
                                            fontFamily:
                                                AppTextStyles.fontFamily,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
          ),
        ),
      ),
    );
  }
}
