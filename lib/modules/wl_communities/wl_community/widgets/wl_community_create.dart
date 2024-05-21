import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/wl_communities/community_profile/binding/community_profile_binding.dart';
import 'package:weight_loss_app/modules/wl_communities/community_profile/community_profile_page/community_profile_page.dart';
import 'package:weight_loss_app/modules/wl_communities/create_post/binding/create_post_binding.dart';
import 'package:weight_loss_app/modules/wl_communities/create_post/create_post_page/create_post_page.dart';
import 'package:weight_loss_app/modules/wl_communities/wl_community/controller/wl_community_controller.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';

class CreatePostWidget extends StatelessWidget {
  const CreatePostWidget({
    super.key,
    required this.controller,
    required this.profileImageUrl,
  });
  final String profileImageUrl;
  final WlCommunityController controller;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Container(
      width: width * 0.9,
      height: height * 0.08,
      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [
          BoxShadow(
            color: Color(0x23000000),
            blurRadius: 4,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Get.to(
                  () => CommunityProfilePage(profileImageUrl: profileImageUrl),
                  binding: CommunityProfileBinding());
            },
            child: Container(
              width: width * 0.1,
              height: height * 0.05,
              decoration: const ShapeDecoration(
                color: AppColors.containerShadowColor,
                shape: OvalBorder(
                  side: BorderSide(
                      width: 0.25, color: AppColors.containerborderColor),
                ),
              ),
              child: profileImageUrl.isNotEmpty
                  ? ClipOval(child: LoadingImage(imageUrl: profileImageUrl))
                  : const Icon(
                      Icons.person,
                      color: AppColors.white,
                    ),
            ),
          ),
          Material(
            color: AppColors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 0.5, color: AppColors.gray1),
              borderRadius: BorderRadius.circular(50),
            ),
            child: InkWell(
              onTap: () async {
                await Get.to(
                  () => const CreatePostPage(),
                  binding: CreatePostBinding(),
                  arguments: "",
                );
              },
              borderRadius: BorderRadius.circular(50),
              child: Container(
                  width: width * 0.6,
                  height: height * 0.05,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: Row(
                    children: [
                      Text(
                        "What's on your mind?",
                        style: AppTextStyles.formalTextStyle(
                          color: AppColors.black,
                          fontSize: 12,
                        ),
                      )
                    ],
                  )),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                controller.getImage(ImageSource.gallery);
              },
              borderRadius: BorderRadius.circular(50),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: SvgPicture.asset(
                  AppAssets.wlGallerySvg,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
