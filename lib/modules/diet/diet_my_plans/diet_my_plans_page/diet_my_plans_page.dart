import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

import '../../../../common/app_text_styles.dart';
import '../cintroller/diet_my_plans_controller.dart';
import '../widgets/my_plan_items.dart';

class DietMyPlansPage extends GetView<DietMyPlansController> {
  const DietMyPlansPage({super.key});

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
                    expandedHeight: height * 0.22,
                    centerTitle: true,
                    backgroundColor: AppColors.buttonColor,
                    title: Text(
                      'My Plans',
                      style: AppTextStyles.formalTextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    iconTheme: const IconThemeData(color: AppColors.white),
                    systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarIconBrightness: Brightness.light,
                    ),
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            AppAssets.dietImgUrl,
                            fit: BoxFit.fill,
                          ),
                          Container(
                            color: AppColors.black.withAlpha(130),
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: height * 0.05,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: width * 0.07,
                      ),
                      child: Text(
                        'Activated Plans',
                        style: AppTextStyles.formalTextStyle(
                          fontSize: 12,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .titleMedium!
                              .color!,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: height * 0.025,
                    ),
                  ),
                  controller.getDietActivePlans.value.activePlan == null
                      ? const SliverToBoxAdapter()
                      : DietMyPlansItems(
                          dietMyPlansList:
                              controller.getDietActivePlans.value.activePlan!,
                          type: "Active"),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: height * 0.025,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: width * 0.07,
                      ),
                      child: Text(
                        'Recent Plans',
                        style: AppTextStyles.formalTextStyle(
                          fontSize: 12,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .titleMedium!
                              .color!,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: height * 0.025,
                    ),
                  ),
                  controller.getDietActivePlans.value.prevActivePlan == null
                      ? const SliverToBoxAdapter()
                      : DietMyPlansItems(
                          dietMyPlansList: controller
                              .getDietActivePlans.value.prevActivePlan!,
                          type: "Recent"),
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
              controller.isLoading.value ? const OverlayWidget() : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
