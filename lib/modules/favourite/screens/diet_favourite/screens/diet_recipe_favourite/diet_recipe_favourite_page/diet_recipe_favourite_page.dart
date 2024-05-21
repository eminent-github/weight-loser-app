import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/favourite/model/favourite_model.dart';
import 'package:weight_loss_app/modules/favourite/screens/diet_favourite/screens/diet_recipe_favourite/controller/diet_recipe_favourite_controller.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

class DietRecipeFavouritePage extends GetView<DietRecipeFavouriteController> {
  const DietRecipeFavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Obx(
      () => Stack(
        children: [
          controller.isRecipeFavouriteLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.buttonColor,
                  ),
                )
              : controller.recipeFavouriteList.isEmpty
                  ? Center(
                      child: Text(
                        "No Recipe Plan Found",
                        style: AppTextStyles.formalTextStyle(),
                      ),
                    )
                  : ListView.builder(
                      itemCount: controller.recipeFavouriteList.length,
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.07, vertical: height * 0.04),
                      itemBuilder: (context, index) {
                        FavouriteModel dietFavourite =
                            controller.recipeFavouriteList[index];
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
                                      child: Container(
                                        width: width * 0.2,
                                        height: height * 0.08,
                                        decoration: BoxDecoration(
                                          image: dietFavourite.filname == null
                                              ? const DecorationImage(
                                                  image: AssetImage(AppAssets
                                                      .dietRecipeImgUrl),
                                                  fit: BoxFit.fill,
                                                )
                                              : DecorationImage(
                                                  image:
                                                      CachedNetworkImageProvider(
                                                          ApiUrls.imageBaseUrl +
                                                              dietFavourite
                                                                  .filname!),
                                                  fit: BoxFit.fill,
                                                ),
                                          shape: BoxShape.circle,
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color(0x3F000000),
                                              blurRadius: 4,
                                              offset: Offset(0, 0),
                                              spreadRadius: 0,
                                            )
                                          ],
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
          controller.isLoading.value
              ? const Center(
                      child: OverlayWidget(),
                    )
              : const SizedBox()
        ],
      ),
    );
  }
}
