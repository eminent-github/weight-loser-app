import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/diet/add_your_food/add_your_food_page/add_your_food_page.dart';
import 'package:weight_loss_app/modules/diet/add_your_food/binding/add_your_food_binding.dart';
import 'package:weight_loss_app/modules/diet/add_your_food/model/rep_food_route_model.dart';
import 'package:weight_loss_app/modules/diet/diet_food_item_detial/binding/diet_food_item_detial_binding.dart';
import 'package:weight_loss_app/modules/diet/diet_food_item_detial/diet_food_item_detial_page/diet_food_item_detial_page.dart';
import 'package:weight_loss_app/modules/diet/diet_plan_detail/controller/diet_plan_detail_controller.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';
import '../../../../common/app_text_styles.dart';
import '../models/diet_plan_detail_model.dart';

class FoodItems extends StatelessWidget {
  FoodItems({
    super.key,
    required this.queryList,
    required this.type,
    this.isActivated = false,
    this.totalDays,
    required this.isCurrentDay,
  });
  final List<DietPlanDetialModel> queryList;
  final String type;
  final bool isActivated;
  final int? totalDays;
  final bool isCurrentDay;
  final controller = Get.find<DietPlanDetailController>();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return queryList.isEmpty
        ? SliverToBoxAdapter(
            child: Center(
              child: Text(
                "No $type Food Available",
              ),
            ),
          )
        : SliverList.builder(
            itemCount: queryList.length,
            itemBuilder: (context, index) {
              DietPlanDetialModel dietPlanDetialModel = queryList[index];
              print("Name : ${dietPlanDetialModel.fileName!.trimRight()}jj");
              return isActivated
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.05,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                width: 13.45,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      color: const Color(0xffECECEC),
                                      width: width * 0.005,
                                      height: height * 0.075,
                                    ),
                                    Container(
                                      width: 13.45,
                                      height: 13.45,
                                      decoration: BoxDecoration(
                                        color: AppColors.buttonColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Container(
                                          width: 6.72,
                                          height: 6.72,
                                          decoration: const BoxDecoration(
                                            color: AppColors.white,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 8,
                            child: Material(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                              elevation: 3,
                              child: InkWell(
                                onTap: () {
                                  Get.to(
                                    () => const DietFoodItemDetialPage(),
                                    binding: DietFoodItemDetialBinding(
                                        dietPlanDetialModel:
                                            dietPlanDetialModel,
                                        totalDays: totalDays!),
                                  );
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: height * 0.06,
                                      width: width * 0.14,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(7),
                                          bottomLeft: Radius.circular(7),
                                        ),
                                        child:
                                            dietPlanDetialModel.fileName == null
                                                ? const Center(
                                                    child: CircleAvatar())
                                                : S3LoadingImage(
                                                    imageUrl:
                                                        "${ApiUrls.s3ImageBaseUrl}Diet/${dietPlanDetialModel.fileName!.trimRight()}",
                                                    fit: BoxFit.cover,
                                                  ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.025,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: height * 0.005),
                                              child: AutoSizeText(
                                                dietPlanDetialModel.name!
                                                    .trimRight(),
                                                maxLines: 2,
                                                style: AppTextStyles
                                                    .formalTextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.005,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: height * 0.005),
                                              child: Text(
                                                '${dietPlanDetialModel.calories!} kcl',
                                                style: AppTextStyles
                                                    .formalTextStyle(
                                                  color:
                                                      const Color(0xFF6C6C6C),
                                                  fontSize: 8,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          isCurrentDay
                              ? Expanded(
                                  flex: 3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          Get.to(
                                            () => AddYourFoodPage(
                                              replaceFoodRouteModel:
                                                  ReplaceFoodRouteModel(
                                                planFoodId: dietPlanDetialModel
                                                        .foodId ??
                                                    "",
                                                planId: dietPlanDetialModel
                                                        .planId ??
                                                    1,
                                                day: dietPlanDetialModel.day,
                                                phase:
                                                    dietPlanDetialModel.phase,
                                                servingSize: int.parse(
                                                    dietPlanDetialModel
                                                            .servingSize ??
                                                        "1"),
                                              ),
                                            ),
                                            binding: AddYourFoodBinding(
                                              phaseId:
                                                  dietPlanDetialModel.phase!,
                                              mealType:
                                                  dietPlanDetialModel.mealType!,
                                            ),
                                          );
                                        },
                                        borderRadius: BorderRadius.circular(50),
                                        child: SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: Icon(
                                            Icons.add_circle_outline_outlined,
                                            color: AppColors.buttonColor,
                                            size: 28,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: dietPlanDetialModel.isFavourite!
                                            ? () {
                                                customSnackbar(
                                                    title: AppTexts.alert,
                                                    message:
                                                        "Already Favourite");
                                              }
                                            : () async {
                                                // print(
                                                //     dietPlanDetialModel.planId.toString());
                                                await controller
                                                    .addFavouriteFood(
                                                  foodId: dietPlanDetialModel
                                                      .foodId!,
                                                  planId: dietPlanDetialModel
                                                      .planId
                                                      .toString(),
                                                  dietType: type,
                                                );
                                              },
                                        borderRadius: BorderRadius.circular(50),
                                        child: SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: Icon(
                                            dietPlanDetialModel.isFavourite!
                                                ? Icons.favorite
                                                : Icons
                                                    .favorite_border_outlined,
                                            color: AppColors.buttonColor,
                                            size: 28,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Expanded(
                                  flex: 3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: Icon(
                                          dietPlanDetialModel.isFavourite!
                                              ? Icons.favorite
                                              : Icons.favorite_border_outlined,
                                          color: AppColors.buttonColor,
                                          size: 28,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.06,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                width: 13.45,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      color: const Color(0xffECECEC),
                                      width: width * 0.005,
                                      height: height * 0.075,
                                    ),
                                    Container(
                                      width: 13.45,
                                      height: 13.45,
                                      decoration: BoxDecoration(
                                        color: AppColors.buttonColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Container(
                                          width: 6.72,
                                          height: 6.72,
                                          decoration: const BoxDecoration(
                                            color: AppColors.white,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 8,
                            child: Material(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                              elevation: 3,
                              child: InkWell(
                                onTap: () {
                                  Get.to(
                                    () => const DietFoodItemDetialPage(),
                                    binding: DietFoodItemDetialBinding(
                                        dietPlanDetialModel:
                                            dietPlanDetialModel,
                                        totalDays: totalDays!),
                                  );
                                },
                                child: SizedBox(
                                  height: height * 0.06,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: height * 0.06,
                                        width: width * 0.14,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(7),
                                            bottomLeft: Radius.circular(7),
                                          ),
                                          child: dietPlanDetialModel.fileName ==
                                                  null
                                              ? Image.asset(
                                                  AppAssets.dietImgUrl,
                                                  fit: BoxFit.cover,
                                                )
                                              : S3LoadingImage(
                                                  imageUrl:
                                                      "${ApiUrls.s3ImageBaseUrl}Diet/${dietPlanDetialModel.fileName}",
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.025,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: SizedBox(
                                                      height: height * 0.02,
                                                      child: FittedBox(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          dietPlanDetialModel
                                                              .name!,
                                                          style: AppTextStyles
                                                              .formalTextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: height * 0.005,
                                              ),
                                              Text(
                                                '${dietPlanDetialModel.calories!} kcl',
                                                style: AppTextStyles
                                                    .formalTextStyle(
                                                  color:
                                                      const Color(0xFF6C6C6C),
                                                  fontSize: 8,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
            },
          );
  }
}
