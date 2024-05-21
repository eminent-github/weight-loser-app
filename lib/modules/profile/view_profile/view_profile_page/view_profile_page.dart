import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/modules/profile/edit_profile/binding/edit_profile_binding.dart';
import 'package:weight_loss_app/modules/profile/edit_profile/view/edit_profile_page.dart';
import 'package:weight_loss_app/modules/wl_communities/wl_community/widgets/image_post_detail.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';
import '../controller/view_profile_controller.dart';

class ViewProfilePage extends GetView<ViewProfileController> {
  const ViewProfilePage({super.key});

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
        centerTitle: true,
        title: Text(
          'Profile',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: InternetCheckWidget<ConnectivityService>(
        child: Obx(
          () => SafeArea(
            child: controller.isLoading.value
                ? const Center(
                    child: OverlayWidget(),
                  )
                : controller.userProfileData.value.id == null
                    ? Center(
                        child: Text(
                          "No Profile Record Found",
                          style: AppTextStyles.formalTextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .titleMedium!
                                .color!,
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Center(
                              child: Container(
                                width: width * 0.45,
                                height: height * 0.22,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child:
                                    controller.userProfileData.value.imgPah ==
                                            null
                                        ? const Center(
                                            child: Icon(
                                              Icons.person,
                                              size: 50,
                                            ),
                                          )
                                        : ClipOval(
                                            child: MyImageDetial(
                                              id: UniqueKey().toString(),
                                              image: LoadingImage(
                                                imageUrl: controller
                                                    .userProfileData
                                                    .value
                                                    .imgPah!,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.015,
                            ),
                            Text(
                              controller.userProfileData.value.name == null
                                  ? "UnKnown"
                                  : controller.userProfileData.value.name!,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.formalTextStyle(
                                fontSize: 25,
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .titleMedium!
                                    .color!,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.05),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      "Location",
                                      style: AppTextStyles.formalTextStyle(
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .titleMedium!
                                            .color!,
                                      ),
                                    ),
                                    leading: const Icon(
                                      Icons.location_on,
                                      color: AppColors.blue,
                                    ),
                                    subtitle: Text(
                                      controller.userProfileData.value
                                                  .location ==
                                              null
                                          ? "Location"
                                          : controller
                                              .userProfileData.value.location!,
                                      style: AppTextStyles.formalTextStyle(
                                        color: AppColors.gray,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  ListTile(
                                    title: Text(
                                      "Email",
                                      style: AppTextStyles.formalTextStyle(
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .titleMedium!
                                            .color!,
                                      ),
                                    ),
                                    leading: const Icon(
                                      Icons.email,
                                      color: AppColors.blue,
                                    ),
                                    subtitle: Text(
                                      controller.userProfileData.value.email ==
                                              null
                                          ? "Email"
                                          : controller
                                              .userProfileData.value.email!,
                                      style: AppTextStyles.formalTextStyle(
                                        color: AppColors.gray,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  ListTile(
                                    title: Text(
                                      "Phone",
                                      style: AppTextStyles.formalTextStyle(
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .titleMedium!
                                            .color!,
                                      ),
                                    ),
                                    leading: const Icon(
                                      Icons.call,
                                      color: AppColors.blue,
                                    ),
                                    subtitle: Text(
                                      controller.userProfileData.value.mobile ==
                                              null
                                          ? "Number"
                                          : controller
                                              .userProfileData.value.mobile!,
                                      style: AppTextStyles.formalTextStyle(
                                        color: AppColors.gray,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.07,
                            ),
                            Material(
                              color: AppColors.blue,
                              borderRadius: BorderRadius.circular(18),
                              elevation: 3,
                              shadowColor: AppColors.backgroundColor,
                              child: InkWell(
                                onTap: () async {
                                  await Get.to(
                                      () => EditProfilePage(
                                          profId: controller
                                              .userProfileData.value.id!),
                                      binding: EditProfileBinding(),
                                      arguments:
                                          controller.userProfileData.value);
                                  controller.getUserProfileApi();
                                },
                                borderRadius: BorderRadius.circular(18),
                                child: SizedBox(
                                  width: width * 0.26,
                                  height: height * 0.065,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.border_color,
                                        size: 16,
                                        color: AppColors.white,
                                      ),
                                      SizedBox(
                                        width: width * 0.01,
                                      ),
                                      Text(
                                        AppTexts.profileEdit,
                                        style: AppTextStyles.formalTextStyle(
                                            color: AppColors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
          ),
        ),
      ),
    );
  }
}
