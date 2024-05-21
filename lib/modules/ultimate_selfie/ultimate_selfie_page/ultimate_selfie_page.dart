import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/ultimate_selfie/controller/ultimate_selfie_controller.dart';
import 'package:weight_loss_app/modules/ultimate_selfie/screen/comparision/binding/comparision_binding.dart';
import 'package:weight_loss_app/modules/ultimate_selfie/screen/comparision/comparision_page/comparision_page.dart';
import 'package:weight_loss_app/modules/ultimate_selfie/widgets/selfie_content_widget.dart';
import 'package:weight_loss_app/modules/ultimate_selfie/widgets/user_data_bottomsheet.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

class UltimateSelfiePage extends GetView<UltimateSelfieController> {
  const UltimateSelfiePage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double screenHeight = screenSize.height;
    double height = screenSize.height - kToolbarHeight;
    double width = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        toolbarHeight: screenHeight * 0.08,
        title: Text(
          'Ultimate Selfie',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: InternetCheckWidget<ConnectivityService>(
        child: Obx(
          () => Stack(
            children: [
              SafeArea(
                child: controller.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.buttonColor,
                        ),
                      )
                    : controller.userSelfieData.value.selfieList == null
                        ? Center(
                            child: Text(
                            "No record found",
                            style: AppTextStyles.formalTextStyle(),
                          ))
                        : CustomScrollView(
                            slivers: [
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.055),
                                  child: SizedBox(
                                    height: height * 0.1,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            await dialogForImagePicker(
                                                context,
                                                width,
                                                height,
                                                controller.userSelfieData.value
                                                    .userDto!.weightUnit!);
                                          },
                                          icon: Icon(
                                            Icons.camera_alt_rounded,
                                            size: 30,
                                            color: AppColors.buttonColor,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            if (controller.userSelfieData.value
                                                    .selfieList!.length >
                                                1) {
                                              Get.to(
                                                  () => ComparisionPage(
                                                      firtstUltimateSelfieModel:
                                                          controller
                                                              .userSelfieData
                                                              .value
                                                              .selfieList![0],
                                                      lastUltimateSelfieModel:
                                                          controller
                                                              .userSelfieData
                                                              .value
                                                              .selfieList![controller
                                                                  .userSelfieData
                                                                  .value
                                                                  .selfieList!
                                                                  .length -
                                                              1],
                                                      weightUnit: controller
                                                          .userSelfieData
                                                          .value
                                                          .userDto!
                                                          .weightUnit!),
                                                  binding:
                                                      ComparisionBinding());
                                            } else {
                                              customSnackbar(
                                                  title: AppTexts.error,
                                                  message:
                                                      "There is no Selfie to Compare.");
                                            }
                                          },
                                          icon: Icon(
                                            Icons.compare,
                                            size: 30,
                                            color: AppColors.buttonColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              controller
                                      .userSelfieData.value.selfieList!.isEmpty
                                  ? SliverToBoxAdapter(
                                      child: SizedBox(
                                        height: height * 0.1,
                                        child: Center(
                                          child: Text(
                                            "No Selfie Uploaded Yet",
                                            style:
                                                AppTextStyles.formalTextStyle(),
                                          ),
                                        ),
                                      ),
                                    )
                                  : SliverList.builder(
                                      itemCount: controller.userSelfieData.value
                                          .selfieList!.length,
                                      itemBuilder: (context, index) {
                                        print(controller.userSelfieData.value
                                            .selfieList!.length);
                                        if (index.isEven) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width * 0.02),
                                            child: TimelineTile(
                                              alignment: TimelineAlign.manual,
                                              lineXY: 0.5,
                                              endChild: Padding(
                                                padding: EdgeInsets.only(
                                                    left: width * 0.02),
                                                child: SelfieContentWidget(
                                                    ultimateSelfieModel:
                                                        controller
                                                            .userSelfieData
                                                            .value
                                                            .selfieList![index],
                                                    weightUnit: controller
                                                        .userSelfieData
                                                        .value
                                                        .userDto!
                                                        .weightUnit!,
                                                    controller: controller,
                                                    onTap: () {
                                                      if (index != 0) {
                                                        Get.to(
                                                            () => ComparisionPage(
                                                                lastUltimateSelfieModel:
                                                                    controller
                                                                            .userSelfieData
                                                                            .value
                                                                            .selfieList![
                                                                        index],
                                                                firtstUltimateSelfieModel:
                                                                    controller
                                                                            .userSelfieData
                                                                            .value
                                                                            .selfieList![
                                                                        index -
                                                                            1],
                                                                weightUnit: controller
                                                                    .userSelfieData
                                                                    .value
                                                                    .userDto!
                                                                    .weightUnit!),
                                                            binding:
                                                                ComparisionBinding());
                                                      } else {
                                                        customSnackbar(
                                                            title:
                                                                AppTexts.error,
                                                            message:
                                                                "There is no Selfie to Compare.");
                                                      }
                                                    }),
                                              ),
                                              beforeLineStyle: LineStyle(
                                                  color: AppColors.buttonColor,
                                                  thickness: 2),
                                              indicatorStyle: IndicatorStyle(
                                                color: AppColors.buttonColor,
                                                height: 20,
                                                width: 20,
                                              ),
                                            ),
                                          );
                                        } else {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width * 0.02),
                                            child: TimelineTile(
                                              alignment: TimelineAlign.manual,
                                              lineXY: 0.5,
                                              startChild: SelfieContentWidget(
                                                ultimateSelfieModel: controller
                                                    .userSelfieData
                                                    .value
                                                    .selfieList![index],
                                                controller: controller,
                                                weightUnit: controller
                                                    .userSelfieData
                                                    .value
                                                    .userDto!
                                                    .weightUnit!,
                                                onTap: () {
                                                  Get.to(
                                                      () => ComparisionPage(
                                                          lastUltimateSelfieModel:
                                                              controller
                                                                      .userSelfieData
                                                                      .value
                                                                      .selfieList![
                                                                  index],
                                                          firtstUltimateSelfieModel:
                                                              controller
                                                                      .userSelfieData
                                                                      .value
                                                                      .selfieList![
                                                                  index - 1],
                                                          weightUnit: controller
                                                              .userSelfieData
                                                              .value
                                                              .userDto!
                                                              .weightUnit!),
                                                      binding:
                                                          ComparisionBinding());
                                                },
                                              ),
                                              beforeLineStyle: LineStyle(
                                                  color: AppColors.buttonColor,
                                                  thickness: 2),
                                              indicatorStyle: IndicatorStyle(
                                                height: 20,
                                                width: 20,
                                                color: AppColors.buttonColor,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                              SliverToBoxAdapter(
                                child: Center(
                                  child: Container(
                                    width: 90,
                                    height: 90,
                                    decoration: ShapeDecoration(
                                      shape: OvalBorder(
                                        side: BorderSide(
                                          width: 1,
                                          color: AppColors.buttonColor,
                                        ),
                                      ),
                                    ),
                                    child: Center(
                                      child: Container(
                                        width: 80,
                                        height: 80,
                                        decoration: ShapeDecoration(
                                          color: AppColors.buttonColor,
                                          shape: const OvalBorder(),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Goal Weight',
                                              style:
                                                  AppTextStyles.formalTextStyle(
                                                color: AppColors.white,
                                                fontSize: 10,
                                              ),
                                            ),
                                            Text(
                                              '${controller.userSelfieData.value.userDto!.targetWeight!.toInt()} ${controller.userSelfieData.value.userDto!.weightUnit}',
                                              style:
                                                  AppTextStyles.formalTextStyle(
                                                color: AppColors.white,
                                                fontSize: 10,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.055),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Selfie Tales',
                                        style: AppTextStyles.formalTextStyle(
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .titleMedium!
                                              .color!,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Your selfies tell a powerful story of progress and dedication. Keep capturing moments and witness your inspiring transformation',
                                        textAlign: TextAlign.justify,
                                        style: AppTextStyles.formalTextStyle(
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .titleMedium!
                                              .color!,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
              ),
              controller.isSelfieUploadLoading.value
                  ? const OverlayWidget()
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Future<void> dialogForImagePicker(BuildContext context, double width,
      double height, String weightUnit) async {
    await showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      context: context,
      pageBuilder: (dialogContext, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            child: SizedBox(
              width: width * 0.75,
              height: height * 0.28,
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    "Choose an Action",
                    style: AppTextStyles.formalTextStyle(
                      color: AppColors.buttonColor,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Divider(
                    color: AppColors.buttonColor,
                    thickness: 2,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: height * 0.07,
                            child: ListTile(
                              onTap: () async {
                                Navigator.pop(dialogContext);
                                bool isImageSelected = await controller
                                    .getImage(ImageSource.gallery);
                                if (isImageSelected) {
                                  await showBottomSheet(context, weightUnit);
                                }
                              },
                              leading: Icon(
                                Icons.photo_library_rounded,
                                color: AppColors.buttonColor,
                                size: 30,
                              ),
                              title: AutoSizeText(
                                "Choose from Gallery",
                                maxLines: 1,
                                minFontSize: 10,
                                style: AppTextStyles.formalTextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.07,
                            child: ListTile(
                              onTap: () async {
                                Navigator.pop(dialogContext);
                                bool isImageSelected = await controller
                                    .getImage(ImageSource.camera);
                                if (isImageSelected) {
                                  await showBottomSheet(context, weightUnit);
                                }
                              },
                              leading: Icon(
                                Icons.camera_alt_rounded,
                                color: AppColors.buttonColor,
                                size: 30,
                              ),
                              title: AutoSizeText(
                                "Capture from Camera",
                                maxLines: 1,
                                minFontSize: 10,
                                style: AppTextStyles.formalTextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(anim),
          child: child,
        );
      },
    );
  }

  Future<void> showBottomSheet(BuildContext context, String weightUnit) async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return UserDateBottomsheet(
          controller: controller,
          weightUnit: weightUnit,
        );
      },
    );
  }
}
