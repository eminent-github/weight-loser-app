import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/modules/diet/diet_my_plans/models/diet_active_plans.dart';
import 'package:weight_loss_app/modules/diet/diet_plan_detail/controller/diet_plan_detail_controller.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';
import '../../../../common/app_text_styles.dart';
import '../../diet_plan_detail/binding/diet_plan_detail_binding.dart';
import '../../diet_plan_detail/diet_item_detail_page/diet_item_detail_page.dart';

class DietMyPlansItems extends StatelessWidget {
  const DietMyPlansItems(
      {super.key, required this.dietMyPlansList, required this.type});
  final List<ActivePlan> dietMyPlansList;
  final String type;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return dietMyPlansList.isEmpty
        ? SliverToBoxAdapter(
            child: Center(
              child: Text(
                "No $type Plan Available",
                style: AppTextStyles.formalTextStyle(),
              ),
            ),
          )
        : SliverList.builder(
            itemCount: dietMyPlansList.length,
            itemBuilder: (context, index) {
              ActivePlan activePlan = dietMyPlansList[index];
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.07, vertical: height * 0.015),
                child: GestureDetector(
                  onTap: type != "Active"
                      ? () {}
                      : () {
                          Get.to(
                            () => DietPlanDetailPage(
                              isActivated: true.obs,
                              planTitle: activePlan.title,
                              planImage: activePlan.fileName,
                            ),
                            binding: DietPlanDetailBinding(),
                            arguments: PlanIdAndDuration(
                                duration: activePlan.duration,
                                planId: activePlan.planId,
                                day: activePlan.day),
                          );
                        },
                  child: Container(
                    height: height * 0.07,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: height * 0.07,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(7),
                                bottomLeft: Radius.circular(7),
                              ),
                              child: activePlan.fileName == null
                                  ? const Center(child: Icon(Icons.image))
                                  : S3LoadingImage(
                                      imageUrl:
                                          "${ApiUrls.s3ImageBaseUrl}planImages/dietPlans/${activePlan.fileName}"),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.025,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  activePlan.title!,
                                  maxLines: 1,
                                  minFontSize: 8,
                                  style: AppTextStyles.formalTextStyle(),
                                ),
                                SizedBox(
                                  height: height * 0.005,
                                ),
                                Text(
                                  activePlan.description!,
                                  style: AppTextStyles.formalTextStyle(
                                    color: const Color(0xFFC4C4C4),
                                    fontSize: 9,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Center(
                            child: type == "Active"
                                ? Text(
                                    'Activated',
                                    style: AppTextStyles.formalTextStyle(
                                      color: AppColors.buttonColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                : Text(
                                    'Inactive',
                                    style: AppTextStyles.formalTextStyle(
                                      color: AppColors.buttonColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
