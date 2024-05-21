import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_exercise/model/home_inner_exercises_model.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';
import '../../../../common/app_assets.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../widgets/custom_large_button.dart';
import '../controller/activate_exercise_plan_controller.dart';

class ActivateExercisePlanPage extends GetView<ActivateExercisePlanController> {
  final PlanData planData;
  final bool isFavourite;
  const ActivateExercisePlanPage({
    super.key,
    required this.planData,
    required this.isFavourite,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.white),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: width * 0.04),
            child: GestureDetector(
              onTap: isFavourite
                  ? () {
                      customSnackbar(
                          title: AppTexts.alert, message: 'Already Favourite');
                    }
                  : () async {
                      await controller.addFavouriteFood(
                        planId: planData.id.toString(),
                      );
                    },
              child: Icon(
                isFavourite ? Icons.favorite : Icons.favorite_border_outlined,
                color: isFavourite ? Colors.red : AppColors.gray,
                size: 30,
                shadows: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(3, 3), // changes position of shadow
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: InternetCheckWidget<ConnectivityService>(
        child: Obx(
          () => Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: width,
                      height: height * 0.35,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          planData.fileName == null
                              ? Image.asset(
                                  AppAssets.exerciseImgUrl,
                                  fit: BoxFit.cover,
                                )
                              : S3LoadingImage(
                                  imageUrl:
                                      "${ApiUrls.s3ImageBaseUrl}planImages/exercisePlan/${planData.fileName!}",
                                  fit: BoxFit.cover,
                                ),
                          Container(
                            color: AppColors.black.withOpacity(0.2),
                          )
                        ],
                      ),
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
                              planData.title!,
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
                            '${planData.duration} Days',
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
                          planData.details ?? "Description",
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
                      width: width * 0.6,
                      text: "Activate",
                      onPressed: () {
                        int totalActivatedPlans = controller
                                .exerciseActivePlansModel
                                .value
                                .activePlan!
                                .length +
                            controller.exerciseActivePlansModel.value
                                .prevActivePlan!.length;
                        if (totalActivatedPlans >= 3) {
                          customSnackbar(
                              title: AppTexts.error,
                              message: "You already Activated three plans");
                        } else {
                          controller.activatePlan(planData);
                        }
                      },
                    )
                  ],
                ),
              ),
              // Positioned(
              //   top: 0,
              //   left: 0,
              //   right: 0,
              //   child: ClipRect(
              //     child: BackdropFilter(
              //       filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              //       child: Container(
              //         color: Colors.transparent,
              //         height: height * 0.035,
              //         width: width,
              //       ),
              //     ),
              //   ),
              // ),
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
