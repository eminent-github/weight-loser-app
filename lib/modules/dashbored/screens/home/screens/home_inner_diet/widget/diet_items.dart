import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_diet/controller/home_inner_diet_controller.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_diet/models/diet_popular_plans.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';
import '../../../../../../../common/app_text_styles.dart';
import '../../../../../../diet/activate_diet_plan/activate_diet_plan_page/activate_diet_plan_page.dart';
import '../../../../../../diet/activate_diet_plan/binding/activate_diet_plan_binding.dart';

class DietItems extends StatelessWidget {
  DietItems({super.key, required this.getDietPopularPlans});
  final DietPopularPlans getDietPopularPlans;
  final controller = Get.find<HomeInnerDietController>();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    var height = screenSize.height;
    var width = screenSize.width;

    return getDietPopularPlans.favouritePlanList!.isEmpty
        ? Center(
            child: Text(
              "No Plan Avialable",
              style: AppTextStyles.formalTextStyle(
                color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
              ),
            ),
          )
        : GridView.builder(
            itemCount: getDietPopularPlans.favouritePlanList!.length,
            padding: EdgeInsets.symmetric(vertical: height * 0.015),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 18,
                childAspectRatio: 0.85,
                mainAxisSpacing: 10),
            itemBuilder: (context, index) {
              PlanData planData =
                  getDietPopularPlans.favouritePlanList![index].planData!;
              print(planData.fileName);
              return GestureDetector(
                onTap:
                    getDietPopularPlans.favouritePlanList![index].isPlanActive!
                        ? () {}
                        : () async {
                            await Get.to(
                                () => ActivateDietPlanPage(
                                      planData: planData,
                                      isFavourite: getDietPopularPlans
                                          .favouritePlanList![index]
                                          .isFavourte!,
                                    ),
                                binding: ActivateDietPlanBinding());
                            controller.getDietPlans();
                          },
                child: Container(
                  decoration: ShapeDecoration(
                    color: AppColors.dietItemColor.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.035),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: height * 0.16,
                              width: width,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: planData.fileName == null
                                  ? const Center(
                                      child: Icon(
                                        Icons.image,
                                        size: 50,
                                        color: Colors.black,
                                      ),
                                    )
                                  : Hero(
                                      key: UniqueKey(),
                                      tag:
                                          "${ApiUrls.s3ImageBaseUrl}planImages/dietPlans/${planData.fileName!}",
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: S3LoadingImage(
                                          imageUrl:
                                              "${ApiUrls.s3ImageBaseUrl}planImages/dietPlans/${planData.fileName!}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                            ),
                            Container(
                              width: getDietPopularPlans
                                      .favouritePlanList![index].isPlanActive!
                                  ? width * 0.17
                                  : width * 0.1,
                              height: height * 0.025,
                              margin: EdgeInsets.only(
                                  top: height * 0.005, left: width * 0.01),
                              decoration: ShapeDecoration(
                                color: AppColors.blue,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 1, color: Colors.white),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  getDietPopularPlans.favouritePlanList![index]
                                          .isPlanActive!
                                      ? 'Activated'
                                      : "New",
                                  style: AppTextStyles.formalTextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(
                          planData.category!,
                          style: AppTextStyles.formalTextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .titleSmall!
                                .color!,
                            fontSize: 10,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.023,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: FittedBox(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    planData.title!,
                                    style: AppTextStyles.formalTextStyle(
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .titleMedium!
                                          .color!,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  '${planData.duration} Days',
                                  textAlign: TextAlign.end,
                                  style: AppTextStyles.formalTextStyle(
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .titleMedium!
                                        .color!,
                                    fontSize: 10,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
