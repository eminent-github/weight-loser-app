import 'dart:io';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:weight_loss_app/modules/registeration_questions/complete_profile/complete_profile_page.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';
import '../../../../common/app_assets.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';
import '../controller/oath_taken_controller.dart';

class OathTakenPage extends GetView<OathTakenController> {
  const OathTakenPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height - kToolbarHeight;
    double width = screenSize.width;
    return Scaffold(
      body: InternetCheckWidget<ConnectivityService>(
        child: Obx(
          () => Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                  ),
                                ),
                                Text(
                                  'My pledge',
                                  style: AppTextStyles.formalTextStyle(
                                    color: Colors.black
                                        .withOpacity(0.6899999976158142),
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                controller.takenOathApi();
                              },
                              child: Text(
                                AppTexts.revokeText,
                                style: TextStyle(
                                  color: AppColors.buttonColor,
                                  fontSize: 12,
                                  fontFamily: AppTextStyles.fontFamily,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.46,
                        child: Image.asset(
                          controller.gender.value == "Male"
                              ? AppAssets.maleOathImgUrl
                              : controller.gender.value == "Female"
                                  ? AppAssets.femaleOathImgUrl
                                  : AppAssets.transgenderOathImgUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Text(
                        AppTexts.oathTakenText,
                        style: TextStyle(
                          color: AppColors.buttonColor,
                          fontSize: 24,
                          fontFamily: AppTextStyles.fontFamily,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                        child: AutoSizeText(
                          "Congratulations ${controller.userName.value.split(" ")[0]}! \n\nWith solemn resolve, now you have taken the oath. Through this sacred pledge, begin your tranformative journey towards health. May your determination guide you as you commence your quest.",
                          textAlign: TextAlign.justify,
                          minFontSize: 10,
                          maxLines: 7,
                          style: const TextStyle(
                            color: AppColors.black,
                            fontSize: 15,
                            fontFamily: AppTextStyles.fontFamily,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      InkWell(
                        onTap: () {
                          // Get.offAll(
                          //     () => ShowCaseWidget(builder: Builder(
                          //           builder: (context) {
                          //             return const DashboaredPage();
                          //           },
                          //         )),
                          //     binding: DashboaredBinding());
                          Get.to(
                            () => const CompleteProfilePage(),
                          );
                        },
                        child: Container(
                          height: height * 0.06,
                          width: width * 0.6,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppColors.buttonColor),
                          child: const Center(
                            child: Text(
                              AppTexts.oathTakenText,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: AppTextStyles.fontFamily,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      SizedBox(
                        width: width * 0.35,
                        child: ElevatedButton(
                          onPressed: () async {
                            await shareImageWithTitle(
                                controller.gender.value == "Male"
                                    ? AppAssets.maleOathImgUrl
                                    : controller.gender.value == "Female"
                                        ? AppAssets.femaleOathImgUrl
                                        : AppAssets.transgenderOathImgUrl,
                                "Congratulations ${controller.userName.value.split(" ")[0]}! \n\nWith solemn resolve, now you have taken the oath. Through this sacred pledge, begin your tranformative journey towards health. May your determination guide you as you commence your quest.");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: width * 0.01),
                                child: Icon(
                                  Icons.share,
                                  color: Colors.black.withOpacity(0.6),
                                  size: min(width, height) * 0.03,
                                ),
                              ),
                              Text(
                                AppTexts.shareOnText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.6),
                                  fontSize: 12,
                                  fontFamily: AppTextStyles.fontFamily,
                                  fontWeight: FontWeight.w400,
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
              controller.isLoading.value
                  ? const OverlayWidget()
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Future<File> getTemporaryFile(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);
    final buffer = byteData.buffer;
    final tempDir = await getTemporaryDirectory();
    final tempFile =
        await File('${tempDir.path}/${DateTime.now()}.png').create();
    await tempFile.writeAsBytes(buffer.asUint8List(), flush: true);
    return tempFile;
  }

  Future<void> shareImageWithTitle(String assetPath, String title) async {
    final tempFile = await getTemporaryFile(assetPath);
    await Share.shareXFiles(
      [XFile(tempFile.path)],
      text: title,
    );
  }
}
