import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import '../../../../../../../common/app_assets.dart';
import '../../../../../../../common/app_colors.dart';
import '../../../../../../../common/app_text_styles.dart';
import '../../../../../../mind/mind_my_plans/binding/mind_my_plans_binding.dart';
import '../../../../../../mind/mind_my_plans/mind_my_plans_page/mind_my_plans_page.dart';
import '../controller/home_inner_mind_controller.dart';
import '../widgets/mind_item.dart';

class HomeInnerMindPage extends GetView<HomeInnerMindController> {
  const HomeInnerMindPage({super.key});
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
                  image: AssetImage(AppAssets.mindImgUrl),
                  fit: BoxFit.cover,
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
                  Material(
                    color: AppColors.buttonColor,
                    borderRadius: BorderRadius.circular(3),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => const MindMyPlansPage(),
                            binding: MindMyPlansBinding());
                      },
                      borderRadius: BorderRadius.circular(3),
                      child: SizedBox(
                        width: width * 0.23,
                        height: height * 0.04,
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
            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.buttonColor,
                        ),
                      )
                    : controller.homeInnerMindPlans.value.favouritePlanList !=
                            null
                        ? MindItems(
                            mindPlans: controller.homeInnerMindPlans.value,
                          )
                        : Center(
                            child: Text(
                              "No Plan Available",
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
          ],
        ),
      ),
    );
  }
}
