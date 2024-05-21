import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_mind/controller/home_inner_mind_controller.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_mind/models/home_inner_mind_model.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';

import '../../../../../../../common/app_assets.dart';
import '../../../../../../../common/app_text_styles.dart';
import '../../../../../../mind/activate_mind_plan/activate_mind_plan_page/activate_mind_plan_page.dart';
import '../../../../../../mind/activate_mind_plan/binding/activate_mind_plan_binding.dart';

class MindItems extends StatelessWidget {
  MindItems({super.key, required this.mindPlans});
  final HomeInnerMindModel mindPlans;
  final controller = Get.find<HomeInnerMindController>();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    var height = screenSize.height;
    var width = screenSize.width;
    return mindPlans.favouritePlanList!.isEmpty
        ? Center(
            child: Text(
              "No Plan Available",
              style: AppTextStyles.formalTextStyle(
                color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
              ),
            ),
          )
        : GridView.builder(
            itemCount: mindPlans.favouritePlanList!.length,
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.1, vertical: height * 0.02),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: width * 0.1,
                // childAspectRatio: 0.8,
                mainAxisSpacing: 10),
            itemBuilder: (context, index) {
              PlanData mindPlanData =
                  mindPlans.favouritePlanList![index].planData!;
              // print(
              //     "${ApiUrls.s3ImageBaseUrl}planImages/Mindplan/${mindPlanData.fileName!}");
              return Material(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                elevation: 3,
                child: InkWell(
                  onTap: mindPlans.favouritePlanList![index].isPlanActive!
                      ? () {}
                      : () async {
                          await Get.to(
                              () => ActivateMindPlanPage(
                                    mindPlanData: mindPlanData,
                                    isFavourite: mindPlans
                                        .favouritePlanList![index].isFavourte!,
                                  ),
                              binding: ActivateMindPlanBinding());
                          controller.getMindPlans();
                        },
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: height * 0.09,
                            width: width * 0.19,
                            decoration: const ShapeDecoration(
                              color: AppColors.white,
                              shape: OvalBorder(
                                side: BorderSide(width: 1, color: Colors.white),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 1),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            // child: ClipOval(
                            //   child: Image.asset(
                            //     AppAssets.mindImgUrl,
                            //     fit: BoxFit.cover,
                            //   ),
                            // )
                            child: mindPlanData.fileName != null
                                ? ClipOval(
                                    child: S3LoadingImage(
                                    imageUrl:
                                        "${ApiUrls.s3ImageBaseUrl}planImages/MindPlan/${mindPlanData.fileName!}",
                                    fit: BoxFit.cover,
                                  ))
                                : ClipOval(
                                    child: Image.asset(
                                      AppAssets.mindImgUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                          Text(
                            mindPlanData.title!,
                            style: AppTextStyles.formalTextStyle(
                              color: AppColors.buttonColor,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            '${mindPlanData.duration} Days',
                            style: AppTextStyles.formalTextStyle(
                              color: AppColors.exerciseItemDistanceColor,
                              fontSize: 8,
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width:
                              mindPlans.favouritePlanList![index].isPlanActive!
                                  ? width * 0.17
                                  : width * 0.1,
                          height: height * 0.025,
                          margin: EdgeInsets.only(
                              top: height * 0.005, left: width * 0.01),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF146C94),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              mindPlans.favouritePlanList![index].isPlanActive!
                                  ? 'Activated'
                                  : "New",
                              style: AppTextStyles.formalTextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
  }
}
