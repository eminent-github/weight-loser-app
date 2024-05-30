import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weight_loss_app/modules/about/binding/about_binding.dart';
import 'package:weight_loss_app/modules/cbt/cbt_first/view/cbt_page.dart';
import 'package:weight_loss_app/modules/connected_device/health_data/binding/health_data_binding.dart';
import 'package:weight_loss_app/modules/connected_device/health_data/health_data_page/health_data_page.dart';
// import 'package:weight_loss_app/modules/group_exercise/challenge_space/binding/challenge_space_binding.dart';
// import 'package:weight_loss_app/modules/connected_device/connected_devices/binding/connected_device_binding.dart';
// import 'package:weight_loss_app/modules/connected_device/connected_devices/view/connected_device_page.dart';
import 'package:weight_loss_app/modules/dashbored/screens/drawer/controler/drawer_controler.dart';
import 'package:weight_loss_app/modules/dashbored/screens/grocery/grocery_page/grocery_page.dart';
import 'package:weight_loss_app/modules/deep_sleep/binding/deep_sleep_binding.dart';
import 'package:weight_loss_app/modules/deep_sleep/deep_sleep_page/deep_sleep_page.dart';
import 'package:weight_loss_app/modules/page_not_found/not_found_page.dart';
import 'package:weight_loss_app/modules/privacy_policy/binding/privacy_policy_binding.dart';
import 'package:weight_loss_app/modules/privacy_policy/view/privacy_policy_page.dart';
import 'package:weight_loss_app/modules/profile/view_profile/binding/view_profile_binding.dart';
import 'package:weight_loss_app/modules/profile/view_profile/view_profile_page/view_profile_page.dart';
import 'package:weight_loss_app/modules/recipe/discover_recipe/binding/discover_binding.dart';
import 'package:weight_loss_app/modules/recipe/discover_recipe/view/discover_page.dart';
import 'package:weight_loss_app/modules/refund/binding/refund_binding.dart';
import 'package:weight_loss_app/modules/refund/refund_page/refund_page.dart';
// import 'package:weight_loss_app/modules/refund/binding/refund_binding.dart';
// import 'package:weight_loss_app/modules/refund/refund_page/refund_page.dart';
// import 'package:weight_loss_app/modules/recipe/recipe_page/binding/recipe_binding.dart';
// import 'package:weight_loss_app/modules/recipe/recipe_page/view/recipe_page.dart';
import 'package:weight_loss_app/modules/setting/app_setting/binding/setting_binding.dart';
import 'package:weight_loss_app/modules/setting/app_setting/setting_page/setting_page.dart';
import 'package:weight_loss_app/modules/terms_conditions/binding/terms_condition_binding.dart';
import 'package:weight_loss_app/modules/terms_conditions/terms_condition_page/terms_condition_page.dart';
import 'package:weight_loss_app/modules/ultimate_selfie/binding/ultimate_selfie_binding.dart';
import 'package:weight_loss_app/modules/ultimate_selfie/ultimate_selfie_page/ultimate_selfie_page.dart';
import 'package:weight_loss_app/modules/water/binding/water_binding.dart';
import 'package:weight_loss_app/modules/water/view/water_page.dart';
import 'package:weight_loss_app/modules/wl_communities/wl_community/binding/wl_community_binding.dart';
import 'package:weight_loss_app/modules/wl_communities/wl_community/view/wl_community_page.dart';

import '../../../../../common/app_assets.dart';
import '../../../../../common/app_colors.dart';
import '../../../../../common/app_text_styles.dart';
import '../../../../../common/app_texts.dart';
import '../../../../about/view/about_page.dart';
import '../../../../cbt/cbt_first/binding/cbt_binding.dart';
// import '../../../../group_exercise/challenge_space/challenges_space_page/challenge_space_page.dart';
import '../widgets/drawer_container.dart';

class DrawerPage extends GetView<MyDrawerController> {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppTexts.homePageQuickAccessText,
                          style: TextStyle(
                              fontFamily: AppTextStyles.fontFamily,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.blue),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.clear,
                          size: 31,
                          color: AppColors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                SizedBox(
                  // height: height * 0.55,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.drwerContainersList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, childAspectRatio: 0.8),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CustomProfContainerShadow(
                        containerModalClass:
                            controller.drwerContainersList[index],
                        onPressed: () {
                          switch (index) {
                            case 0:
                              Get.to(
                                () => const ViewProfilePage(),
                                binding: ViewProfileBinding(),
                              );
                              break;
                            case 1:
                              Get.to(() => const WlCommunityPage(),
                                  binding: WlCommunityBinding());
                              break;
                            case 2:
                              Get.to(() => const CbtPage(),
                                  binding: CbtBinding());
                              break;
                            case 3:
                              Get.to(() => const DeepSleepPage(),
                                  binding: DeepSleepBinding());
                              break;
                            case 4:
                              Get.to(() => const WaterPage(),
                                  binding: WaterBinding());
                              break;
                            case 5:
                              Get.to(() => const DiscoverRecipePage(),
                                  binding: DiscoverBinding());
                              break;
                            case 6:
                              Get.to(
                                () => const UltimateSelfiePage(),
                                binding: UltimateSelfieBinding(),
                              );
                              break;
                            case 7:
                              Get.to(() => const HealthDataPage(),
                                  binding: HealthDataBinding());

                              break;
                            case 8:
                              Get.to(
                                () => GroceryPage(),
                              );
                              break;
                            default:
                              Get.to(
                                () => const NotFoundPage(),
                              );
                          }
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  height: height * 0.0005,
                  width: width * 0.85,
                  color: AppColors.buttonColor,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                const Text(
                  AppTexts.drawerContainerCoachesText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF146C94),
                    fontSize: 14,
                    fontFamily: AppTextStyles.fontFamily,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomContainerShadow(
                      onPressed: () {
                        // Get.to(
                        //   () => const TechnicalSupportChatPage(),
                        //   binding: TechnicalSupportBinding(isFromLogin: false),
                        // );
                        Get.to(() => const RefundPage(),
                            binding: RefundBinding());
                      },
                      iconPath: AppAssets.support,
                      textC: AppTexts.drawerContainerSupportText,
                    ),
                    // CustomContainerShadow(
                    //     onPressed: () {
                    //       Get.to(
                    //         () => const ExerciseCoachPage(),
                    //         binding: ExerciseCoachBinding(),
                    //       );
                    //     },
                    //     iconPath: AppAssets.exercise,
                    //     textC: AppTexts.drawerContainerExerciseText),
                    // CustomContainerShadow(
                    //   iconPath: AppAssets.opinion,
                    //   textC: AppTexts.drawerContainerOpinionText,
                    //   onPressed: () {
                    //     Get.to(() => const DoctorsListPage(),
                    //         binding: DoctorsListBinding());
                    //   },
                    // ),
                  ],
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Container(
                  height: height * 0.0005,
                  width: width * 0.85,
                  color: AppColors.buttonColor,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                const Text(
                  AppTexts.drawerContainerHelpText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF146C94),
                    fontSize: 14,
                    fontFamily: AppTextStyles.fontFamily,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                SizedBox(
                  height: height * 0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomContainerShadow(
                        iconPath: AppAssets.setting,
                        textC: AppTexts.drawerContainerSettingsText,
                        onPressed: () {
                          Get.to(() => const SettingPage(),
                              binding: SettingBinding());
                        },
                      ),
                      CustomContainerShadow(
                        onPressed: () {
                          Get.to(() => const PrivacyPolicyPage(),
                              binding: PrivacyPolicyBinding());
                        },
                        iconPath: AppAssets.privacy,
                        textC: AppTexts.drawerContainerPrivacyText,
                      ),
                      CustomContainerShadow(
                        iconPath: AppAssets.termsIconSvgUrl,
                        textC: "Terms &\nConditions",
                        onPressed: () {
                          Get.to(() => const TermsConditionPage(),
                              binding: TermsConditionBinding());
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                SizedBox(
                  height: height * 0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomContainerShadow(
                        onPressed: () async {
                          const androidUrl =
                              'https://play.google.com/store/apps/details?id=com.weightloser.app&pcampaignid=web_share';
                          const appleUrl =
                              'https://apps.apple.com/store/apps/details?id=com.weightloser.app';
                          try {
                            if (Platform.isAndroid) {
                              await launchUrl(Uri.parse(androidUrl));
                            } else {
                              await launchUrl(Uri.parse(appleUrl));
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        iconPath: AppAssets.submitIconSvgUrl,
                        textC: "Submit a\nReview",
                      ),
                      CustomContainerShadow(
                        onPressed: () {
                          Get.to(() => const AboutPage(),
                              binding: AboutBinding());
                        },
                        iconPath: AppAssets.about,
                        textC: "About",
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
