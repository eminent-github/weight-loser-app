import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/modules/diet/diet_plan_detail/controller/diet_plan_detail_controller.dart';
import 'package:weight_loss_app/modules/mind/mind_my_plans/models/mind_active_plans_model.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';

import '../../../../common/app_assets.dart';
import '../../../../common/app_text_styles.dart';
import '../../mind_plan_detail/binding/mind_paln_detial_binding.dart';
import '../../mind_plan_detail/mind_paln_detail_page/mind_paln_detail_page.dart';

class MindMyPlanItems extends StatelessWidget {
  const MindMyPlanItems(
      {super.key, required this.mindMyPlansList, required this.type});
  final List<ActivePlan> mindMyPlansList;
  final String type;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return mindMyPlansList.isEmpty
        ? SliverToBoxAdapter(
            child: Center(
              child: Text(
                "No $type Plan Available",
              ),
            ),
          )
        : SliverList.builder(
            itemCount: mindMyPlansList.length,
            itemBuilder: (context, index) {
              ActivePlan activePlan = mindMyPlansList[index];
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.07, vertical: height * 0.015),
                child: GestureDetector(
                  onTap: type == "Active"
                      ? () {
                          Get.to(
                            () => MindPalnDetailPage(
                              planTitle: activePlan.title!,
                              planImage: activePlan.fileName,
                            ),
                            binding: MindPalnDetailBinding(),
                            arguments: PlanIdAndDuration(
                              duration: activePlan.duration,
                              planId: activePlan.planId,
                              day: activePlan.day,
                            ),
                          );
                        }
                      : null,
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
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(7),
                              bottomLeft: Radius.circular(7),
                            ),
                            child: activePlan.fileName == null
                                ? Image.asset(
                                    AppAssets.mindImgUrl,
                                    height: height * 0.07,
                                    fit: BoxFit.cover,
                                  )
                                : SizedBox(
                                    height: height * 0.07,
                                    child: S3LoadingImage(
                                      imageUrl:
                                          "${ApiUrls.s3ImageBaseUrl}planImages/MindPlan/${activePlan.fileName!}",
                                      fit: BoxFit.cover,
                                    ),
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
                                  activePlan.title!.replaceAll(" ", ""),
                                  maxLines: 1,
                                  minFontSize: 8,
                                  style: AppTextStyles.formalTextStyle(),
                                ),
                                SizedBox(
                                  height: height * 0.005,
                                ),
                                Text(
                                  "Day ${activePlan.day!}",
                                  style: AppTextStyles.formalTextStyle(
                                    color: AppColors.gray,
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
