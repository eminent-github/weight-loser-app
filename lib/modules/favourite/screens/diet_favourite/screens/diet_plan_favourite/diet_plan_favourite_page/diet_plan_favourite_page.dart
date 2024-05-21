import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/favourite/model/favourite_model.dart';
import 'package:weight_loss_app/modules/favourite/screens/diet_favourite/screens/diet_plan_favourite/controller/diet_plan_favourite_controller.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

class DietPlanFvouritePage extends GetView<DietPlanFavouriteController> {
  const DietPlanFvouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Obx(
      () => Stack(
        children: [
          controller.isDietFavouriteLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.buttonColor,
                  ),
                )
              : controller.dietFavouriteList.isEmpty
                  ? Center(
                      child: Text(
                        "No Diet Plan Found",
                        style: AppTextStyles.formalTextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .titleMedium!
                              .color!,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: controller.dietFavouriteList.length,
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.07, vertical: height * 0.04),
                      itemBuilder: (context, index) {
                        FavouriteModel dietFavourite =
                            controller.dietFavouriteList[index];
                        print(dietFavourite.filname);
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: height * 0.01),
                          child: Slidable(
                            key: UniqueKey(),
                            endActionPane: ActionPane(
                              extentRatio: 0.2,
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(9),
                                    bottomRight: Radius.circular(9),
                                  ),
                                  onPressed: (context) {
                                    controller.deleteFavouriteApi(
                                        favouriteId:
                                            dietFavourite.favouriteId!);
                                  },
                                  backgroundColor: const Color(0xFFFF5C5C),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete_outline_outlined,
                                ),
                              ],
                            ),
                            child: Container(
                              height: height * 0.1,
                              decoration: const ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 0.50, color: Color(0xFFDADADA)),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(9),
                                    bottomLeft: Radius.circular(9),
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Center(
                                      child: SizedBox(
                                        width: width * 0.2,
                                        height: height * 0.08,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: dietFavourite.filname == null
                                              ? Image.asset(
                                                  AppAssets.dietRecipeImgUrl,
                                                  fit: BoxFit.cover,
                                                )
                                              : S3LoadingImage(
                                                  imageUrl:
                                                      "${ApiUrls.s3ImageBaseUrl}planImages/dietPlans/${dietFavourite.filname}",
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
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
                                          Text(
                                            "${dietFavourite.planName}",
                                            style:
                                                AppTextStyles.formalTextStyle(),
                                          ),
                                          SizedBox(
                                            height: height * 0.005,
                                          ),
                                          Text(
                                            "${dietFavourite.catagory}",
                                            style:
                                                AppTextStyles.formalTextStyle(
                                              color: AppColors.black
                                                  .withOpacity(0.5),
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: height * 0.01,
                                              right: width * 0.02),
                                          child: Text(
                                            'Plan: ${dietFavourite.duration} Days',
                                            style:
                                                AppTextStyles.formalTextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
          controller.isLoading.value ? const OverlayWidget() : const SizedBox()
        ],
      ),
    );
  }
}
