import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';

import '../../../../../../diet/diet_my_plans/binding/diet_my_plans_binding.dart';
import '../../../../../../diet/diet_my_plans/diet_my_plans_page/diet_my_plans_page.dart';
import '../controller/home_inner_diet_controller.dart';
import '../widget/diet_items.dart';

class HomeInnerDietPage extends GetView<HomeInnerDietController> {
  const HomeInnerDietPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    var height =
        screenSize.height - kBottomNavigationBarHeight - kToolbarHeight;
    var width = screenSize.width;
    return SafeArea(
      child: InternetCheckWidget<ConnectivityService>(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              width: width * 0.84,
              height: height * 0.22,
              decoration: ShapeDecoration(
                image: const DecorationImage(
                  image: AssetImage(AppAssets.dietImgUrl),
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1),
                ),
                shadows: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 1),
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * 0.025,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.08),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const DietMyPlansPage(),
                          binding: DietMyPlansBinding());
                    },
                    child: Container(
                      width: width * 0.23,
                      height: height * 0.04,
                      decoration: ShapeDecoration(
                        color: AppColors.buttonColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3)),
                      ),
                      child: Center(
                        child: Text(
                          'My Plans',
                          style: AppTextStyles.formalTextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.015,
            ),
            Container(
              width: width,
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 0.50,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Color(0xFFEAEAEA),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: width * 0.07, bottom: height * 0.005),
                  child: Text(
                    'Popular Diets',
                    style: AppTextStyles.formalTextStyle(
                      color: AppColors.buttonColor,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Obx(
                () => Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04,
                  ),
                  child: controller.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(
                          color: AppColors.buttonColor,
                        ))
                      : controller.getDietPopularPlans.value
                                  .favouritePlanList !=
                              null
                          ? DietItems(
                              getDietPopularPlans:
                                  controller.getDietPopularPlans.value,
                            )
                          : Center(
                              child: Text(
                                "No Plan Avialable",
                                style: AppTextStyles.formalTextStyle(
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .titleMedium!
                                      .color!,
                                ),
                              ),
                            ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
