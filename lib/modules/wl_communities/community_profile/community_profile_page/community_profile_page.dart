import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/wl_communities/community_profile/controller/community_profile_controller.dart';
import 'package:weight_loss_app/modules/wl_communities/community_profile/widgets/wlcommunity_user_item.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';

class CommunityProfilePage extends GetView<CommunityProfileController> {
  const CommunityProfilePage({
    super.key,
    required this.profileImageUrl,
  });
  final String profileImageUrl;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Scaffold(
      body: InternetCheckWidget<ConnectivityService>(
        child: Obx(
          () => Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor:
                        Theme.of(context).appBarTheme.backgroundColor,
                    iconTheme: Theme.of(context).iconTheme,
                    elevation: 0,
                    expandedHeight: height * 0.3,
                    title: Text(
                      controller.userName.value,
                      style: Theme.of(context).appBarTheme.titleTextStyle,
                    ),
                    centerTitle: true,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            width: width,
                            color: const Color(0xFFD9D9D9),
                            child: profileImageUrl.isNotEmpty
                                ? LoadingImage(
                                    imageUrl: profileImageUrl,
                                    fit: BoxFit.cover,
                                  )
                                : const Icon(
                                    Icons.person,
                                    color: AppColors.white,
                                    size: 50,
                                  ),
                          ),
                          Container(
                            color: AppColors.black.withAlpha(100),
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: height * 0.03,
                    ),
                  ),
                  controller.isLoading.value
                      ? SliverToBoxAdapter(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.buttonColor,
                            ),
                          ),
                        )
                      : controller.communityAllPostsByUserList.isEmpty
                          ? SliverToBoxAdapter(
                              child: SizedBox(
                                height: height * 0.6,
                                child: Center(
                                  child: Text(
                                    "No Post found",
                                    style: AppTextStyles.formalTextStyle(),
                                  ),
                                ),
                              ),
                            )
                          : SliverList.builder(
                              itemCount:
                                  controller.communityAllPostsByUserList.length,
                              itemBuilder: (context, index) {
                                var wlCommunityModel = controller
                                    .communityAllPostsByUserList[index];
                                return WlCommunityUserItem(
                                  controller: controller,
                                  communityPost: wlCommunityModel,
                                );
                              },
                            ),
                ],
              ),
              controller.isSavedLoading.value
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
