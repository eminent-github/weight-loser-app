import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/wl_communities/wl_community/widgets/wl_community_create.dart';
import 'package:weight_loss_app/modules/wl_communities/wl_community/widgets/wl_community_item.dart';
import 'package:weight_loss_app/modules/wl_communities/wl_saved/binding/wl_saved_binding.dart';
import 'package:weight_loss_app/modules/wl_communities/wl_saved/view/wl_saved_page.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_texts.dart';
import '../controller/wl_community_controller.dart';
import 'dart:developer';

class WlCommunityPage extends GetView<WlCommunityController> {
  const WlCommunityPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        title: Text(
          AppTexts.wlCommunityText,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: width * 0.03),
            child: GestureDetector(
              onTap: () {
                Get.to(() => const WlSavedPage(), binding: WlSavedBinding());
              },
              child: Icon(
                Icons.bookmark,
                color: AppColors.buttonColor,
              ),
            ),
          )
        ],
      ),
      body: InternetCheckWidget<ConnectivityService>(
        child: Obx(
          () => Stack(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.02,
                    ),
                    CreatePostWidget(
                      controller: controller,
                      profileImageUrl: controller.profImage.value,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Expanded(
                      child:
                          //  controller.isLoading.value
                          //     ? Center(
                          //         child: CircularProgressIndicator(
                          //           color: AppColors.buttonColor,
                          //         ),
                          //       )
                          //     :
                          SizedBox(
                        child: controller.communityAllPostsList.isEmpty
                            ? Center(
                                child: Text(
                                  "No Posts Found",
                                  style: AppTextStyles.formalTextStyle(
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .titleMedium!
                                        .color!,
                                  ),
                                ),
                              )
                            : RefreshIndicator(
                                onRefresh: () => controller.getAllPostsApi(),
                                child: ListView.builder(
                                  itemCount:
                                      controller.communityAllPostsList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    log('this is length of posts = ${controller.communityAllPostsList.length}');
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.05),
                                      child: WlCommunityItem(
                                        controller: controller,
                                        communityPost: controller
                                            .communityAllPostsList[index],
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              controller.isSavedLoading.value
                  ? const OverlayWidget()
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
