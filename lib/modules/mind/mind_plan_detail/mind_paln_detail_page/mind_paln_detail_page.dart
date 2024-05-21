import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/modules/diet/diet_plan_detail/controller/diet_plan_detail_controller.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';

import '../../../../common/app_assets.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../controller/mind_paln_detail_controller.dart';
import '../widgets/mind_plan_items.dart';

class MindPalnDetailPage extends GetView<MindPalnDetailController> {
  const MindPalnDetailPage({
    super.key,
    required this.planTitle,
    required this.planImage,
  });
  final String planTitle;
  final String? planImage;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          planTitle,
          style: AppTextStyles.formalTextStyle(
              fontSize: height * 0.024,
              fontWeight: FontWeight.w600,
              color: AppColors.white),
        ),
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
        ),
        iconTheme: const IconThemeData(color: AppColors.white),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: InternetCheckWidget<ConnectivityService>(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  planImage == null
                      ? Image.asset(
                          AppAssets.mindImgUrl,
                          fit: BoxFit.cover,
                        )
                      : S3LoadingImage(
                          imageUrl:
                              "${ApiUrls.s3ImageBaseUrl}planImages/MindPlan/$planImage",
                          fit: BoxFit.cover),
                  Container(
                    color: AppColors.black.withAlpha(120),
                  ),
                ],
              ),
            ),
            Container(
              height: height * 0.065,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2)),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 1),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                controller: controller.scrollController,
                itemCount: controller.planIdAndDuration.value.duration,
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02,
                  vertical: height * 0.014,
                ),
                itemBuilder: (context, index) {
                  bool isClickable =
                      controller.planIdAndDuration.value.day!>7?
                            index < controller.planIdAndDuration.value.day!:
                            index<controller.planIdAndDuration.value.day!+6;
                  return Obx(
                    () => Material(
                      color: controller.selectedIndex.value == index
                          ? AppColors.buttonColor
                          : AppColors.white,
                      borderRadius: BorderRadius.circular(4),
                      child: InkWell(
                        onTap: isClickable
                            ? () {
                                controller.selectedIndex.value = index;
                                controller.getMindPlanDetail(
                                    controller.planIdAndDuration.value.planId!,
                                    index + 1);
                              }
                            : null,
                        borderRadius: BorderRadius.circular(4),
                        child: SizedBox(
                          width: width * 0.15,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Day ${index + 1}".toString(),
                                  style: AppTextStyles.formalTextStyle(
                                      color: controller.selectedIndex.value ==
                                              index
                                          ? Colors.white
                                          : controller.planIdAndDuration.value
                                                      .day ==
                                                  (index + 1)
                                              ? AppColors.buttonColor
                                              : const Color(0xFFB1B1B1),
                                      fontWeight: controller.planIdAndDuration
                                                  .value.day ==
                                              (index + 1)
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(
                        color: AppColors.buttonColor,
                      ))
                    : MindPlanItem(
                        getActivePlanDetailList:
                            controller.getActivePlanDetailList,
                        isCurrentDay: controller.selectedIndex.value + 1 ==
                            controller.planIdAndDuration.value.day,
                        planIdAndDuration: PlanIdAndDuration(
                            planId: controller.planIdAndDuration.value.planId!,
                            duration: controller.selectedIndex.value + 1),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
