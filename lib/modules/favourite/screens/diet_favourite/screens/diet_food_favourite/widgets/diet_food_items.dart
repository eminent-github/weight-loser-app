import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/favourite/model/favourite_model.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';

import '../controller/diet_food_favourite_controller.dart';

class DietFoodMealTypeItems extends StatelessWidget {
  DietFoodMealTypeItems({super.key, required this.dietFoodFavouriteList});
  RxList<FavouriteModel> dietFoodFavouriteList;
  final controller = Get.find<DietFoodFavouriteController>();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Obx(
      () => dietFoodFavouriteList.isEmpty
          ? Center(
              child: Text(
                "No Food Found",
                style: AppTextStyles.formalTextStyle(
                  color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
                ),
              ),
            )
          : ListView.builder(
              itemCount: dietFoodFavouriteList.length,
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.07, vertical: height * 0.02),
              itemBuilder: (context, index) {
                FavouriteModel dietFavourite = dietFoodFavouriteList[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.01),
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
                                favouriteId: dietFavourite.favouriteId!);
                          },
                          backgroundColor: const Color(0xFFFF5C5C),
                          foregroundColor: Colors.white,
                          icon: Icons.delete_outline_outlined,
                        ),
                      ],
                    ),
                    child: Container(
                      // height: height * 0.1,
                      padding: EdgeInsets.symmetric(vertical: height * 0.01),
                      decoration: const ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(width: 0.50, color: Color(0xFFDADADA)),
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
                                  borderRadius: BorderRadius.circular(8),
                                  child: dietFavourite.filname == null
                                      ? Image.asset(
                                          AppAssets.dietRecipeImgUrl,
                                          fit: BoxFit.cover,
                                        )
                                      : S3LoadingImage(
                                          imageUrl:
                                              "${ApiUrls.s3ImageBaseUrl}Diet/${dietFavourite.filname}",
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 10,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.025,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dietFavourite.planName!.trimRight(),
                                    style: AppTextStyles.formalTextStyle(),
                                  ),
                                  SizedBox(
                                    height: height * 0.005,
                                  ),
                                  Text(
                                    "${dietFavourite.catagory}",
                                    style: AppTextStyles.formalTextStyle(
                                      color: AppColors.black.withOpacity(0.5),
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
