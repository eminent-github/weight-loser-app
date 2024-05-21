import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_diet/models/diet_popular_plans.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_large_button.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';
import '../controller/activate_diet_plan_controller.dart';

class ActivateDietPlanPage extends GetView<ActivateDietPlanController> {
  const ActivateDietPlanPage(
      {super.key, required this.planData, required this.isFavourite});
  final PlanData planData;
  final bool isFavourite;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    // print(planData.fileName);
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
            child: IconButton(
              onPressed: isFavourite
                  ? () {
                      customSnackbar(
                          title: AppTexts.alert, message: "Already Favourite");
                    }
                  : () async {
                      await controller.addFavouriteFood(
                        planId: planData.id.toString(),
                      );
                    },
              icon: Icon(
                isFavourite ? Icons.favorite : Icons.favorite_border_outlined,
                color: Colors.red,
                size: 30,
                shadows: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
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
              Column(
                children: [
                  SizedBox(
                    width: width,
                    height: height * 0.35,
                    child: planData.fileName == null
                        ? Image.asset(
                            AppAssets.dietImgUrl,
                            fit: BoxFit.cover,
                          )
                        : Hero(
                            key: UniqueKey(),
                            tag:
                                "${ApiUrls.s3ImageBaseUrl}planImages/dietPlans/${planData.fileName!}",
                            child: S3LoadingImage(
                              imageUrl:
                                  "${ApiUrls.s3ImageBaseUrl}planImages/dietPlans/${planData.fileName}",
                            ),
                          ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: width * 0.01),
                            child: AutoSizeText(
                              planData.title!,
                              minFontSize: 15,
                              stepGranularity: 1,
                              maxLines: 2,
                              style: AppTextStyles.formalTextStyle(
                                color: AppColors.buttonColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 21,
                              ),
                            ),
                          ),
                        ),
                        Material(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .titleMedium!
                                    .color!,
                                width: 1),
                          ),
                          child: InkWell(
                            onTap: () => controller.viewPlan(planData),
                            child: SizedBox(
                              width: width * 0.25,
                              height: height * 0.04,
                              child: Center(
                                child: AutoSizeText(
                                  AppTexts.viewPlan,
                                  minFontSize: 10,
                                  stepGranularity: 1,
                                  style: AppTextStyles.formalTextStyle(
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .titleMedium!
                                          .color!,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: SizedBox(
                      height: height * 0.4,
                      child: SingleChildScrollView(
                        child: Html(
                          data: planData.details,
                          style: {
                            'body': Style(
                              fontFamily: AppTextStyles.fontFamily,
                              textAlign: TextAlign.justify,
                              fontSize: FontSize(17),
                            ),
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  CustomLargeButton(
                    height: height,
                    width: width * 0.6,
                    borderRadius: BorderRadius.circular(15),
                    text: "Activate",
                    onPressed: () {
                      int totalActivatedPlans = controller
                              .getDietActivePlans.value.activePlan!.length +
                          controller
                              .getDietActivePlans.value.prevActivePlan!.length;
                      if (totalActivatedPlans >= 3) {
                        customSnackbar(
                            title: AppTexts.error,
                            message: "You already Activated three plans");
                      } else {
                        controller.activatePlan(planData, false);
                      }
                    },
                  ),
                ],
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
                      height: height * 0.035,
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
