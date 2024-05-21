import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_exercise/controller/home_inner_exercise_controller.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_exercise/model/home_inner_exercises_model.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';
import '../../../../../../../common/app_text_styles.dart';
import '../../../../../../exercise/activate_exercise_plan/activate_exercise_plan_page/activate_exercise_plan_page.dart';
import '../../../../../../exercise/activate_exercise_plan/binding/activate_exercise_plan_binding.dart';

class ExerciseItems extends StatelessWidget {
  final HomeInnerExercisesModel exercisePlans;
  ExerciseItems({super.key, required this.exercisePlans});
  final controller = Get.find<HomeInnerExerciseController>();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    var height = screenSize.height;
    var width = screenSize.width;
    return exercisePlans.favouritePlanList!.isEmpty
        ? Center(
            child: Text(
              "No Plan Available",
              style: AppTextStyles.formalTextStyle(
                color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
              ),
            ),
          )
        : GridView.builder(
            itemCount: exercisePlans.favouritePlanList!.length,
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.1, vertical: height * 0.02),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: width * 0.1,
                childAspectRatio: 0.8,
                mainAxisSpacing: 10),
            itemBuilder: (context, index) {
              PlanData planData =
                  exercisePlans.favouritePlanList![index].planData!;
              print("${planData.fileName!}:");
              return GestureDetector(
                onTap: exercisePlans.favouritePlanList![index].isPlanActive!
                    ? () {}
                    : () async {
                        await Get.to(
                            () => ActivateExercisePlanPage(
                                  planData: planData,
                                  isFavourite: exercisePlans
                                      .favouritePlanList![index].isFavourte!,
                                ),
                            binding: ActivateExercisePlanBinding());
                        controller.getDietPlans();
                      },
                child: Container(
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 1),
                      )
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: height * 0.006),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: height * 0.14,
                              width: width * 0.23,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                border:
                                    Border.all(width: 1, color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 1),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: planData.fileName == null
                                  ? Image.asset(
                                      AppAssets.exerciseItemImgUrl,
                                      fit: BoxFit.cover,
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: S3LoadingImage(
                                        imageUrl:
                                            "${ApiUrls.s3ImageBaseUrl}planImages/exercisePlan/${planData.fileName!}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.01),
                              child: Text(
                                planData.title!,
                                textAlign: TextAlign.center,
                                softWrap: true,
                                style: AppTextStyles.formalTextStyle(
                                  color: AppColors.buttonColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Text(
                              '${planData.duration} Days',
                              style: AppTextStyles.formalTextStyle(
                                color: AppColors.exerciseItemDistanceColor,
                                fontSize: 8,
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width: exercisePlans
                                  .favouritePlanList![index].isPlanActive!
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
                              exercisePlans
                                      .favouritePlanList![index].isPlanActive!
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
