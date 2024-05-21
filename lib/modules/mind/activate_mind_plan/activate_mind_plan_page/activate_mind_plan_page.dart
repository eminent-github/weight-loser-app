import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_mind/models/home_inner_mind_model.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

import '../../../../common/app_assets.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../widgets/custom_large_button.dart';
import '../controller/activate_mind_plan_controller.dart';

class ActivateMindPlanPage extends GetView<ActivateMindPlanController> {
  const ActivateMindPlanPage({
    super.key,
    required this.mindPlanData,
    required this.isFavourite,
  });
  final PlanData mindPlanData;
  final bool isFavourite;
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
              SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: width,
                          height: height * 0.35,
                          child: mindPlanData.fileName == null
                              ? Image.asset(
                                  AppAssets.mindImgUrl,
                                  fit: BoxFit.cover,
                                )
                              : S3LoadingImage(
                                  imageUrl:
                                      "${ApiUrls.s3ImageBaseUrl}planImages/MindPlan/${mindPlanData.fileName!}",
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Positioned(
                          top: height * 0.05,
                          right: 0,
                          left: 0,
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: const Icon(
                                    Icons.arrow_back,
                                    color: AppColors.white,
                                    size: 30,
                                  ),
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: isFavourite
                                        ? () {
                                            customSnackbar(
                                                title: AppTexts.alert,
                                                message: 'Already Favourite');
                                          }
                                        : () async {
                                            await controller
                                                .addFavouriteMindPlan(
                                              planId:
                                                  mindPlanData.id.toString(),
                                            );
                                          },
                                    borderRadius: BorderRadius.circular(50),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: Icon(
                                        isFavourite
                                            ? Icons.favorite
                                            : Icons.favorite_border_outlined,
                                        color: Colors.red,
                                        size: 30,
                                        shadows: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
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
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.07),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: width * 0.57,
                            child: AutoSizeText(
                              mindPlanData.title!,
                              minFontSize: 15,
                              stepGranularity: 1,
                              style: AppTextStyles.formalTextStyle(
                                color: AppColors.buttonColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 21,
                              ),
                            ),
                          ),
                          Text(
                            '${mindPlanData.duration} Days',
                            style: AppTextStyles.formalTextStyle(
                              fontSize: 21,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium!
                                  .color!,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.12),
                      child: SizedBox(
                        height: height * 0.35,
                        child: AutoSizeText(
                          "Description",
                          textAlign: TextAlign.justify,
                          minFontSize: 5,
                          stepGranularity: 1,
                          style: AppTextStyles.formalTextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .titleMedium!
                                .color!,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    CustomLargeButton(
                      height: height,
                      width: width * 0.5,
                      text: "Activate",
                      onPressed: () {
                        int totalActivatedPlans = controller
                                .mindActivePlansModel.value.activePlan!.length +
                            controller.mindActivePlansModel.value
                                .prevActivePlan!.length;
                        if (totalActivatedPlans >= 3) {
                          customSnackbar(
                              title: AppTexts.error,
                              message: "You already Activated three plans");
                        } else {
                          controller.activateMindPlan(mindPlanData);
                        }
                      },
                    )
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      color: Colors.transparent,
                      height: height * 0.05,
                      width: width,
                    ),
                  ),
                ),
              ),
              controller.isLoading.value
                  ? const OverlayWidget()
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
