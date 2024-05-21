import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/favourite/screens/diet_favourite/screens/diet_food_favourite/controller/diet_food_favourite_controller.dart';
import 'package:weight_loss_app/modules/favourite/screens/diet_favourite/screens/diet_food_favourite/widgets/diet_food_Items.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

class DietFoodFavouritePage extends GetView<DietFoodFavouriteController> {
  const DietFoodFavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          height: height * 0.02,
        ),
        SizedBox(
          height: height * 0.05,
          child: Center(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.menuItems.length,
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              itemBuilder: (context, index) {
                return GetBuilder(
                  init: controller,
                  builder: (_) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Material(
                        color: controller.favouriteIndex.value == index
                            ? AppColors.buttonColor
                            : const Color(0xffF3F3F3),
                        borderRadius: BorderRadius.circular(50),
                        child: InkWell(
                          onTap: () {
                            controller.favouriteIndex.value = index;
                            controller
                                .filterCousine(controller.menuItems[index]);
                          },
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.04),
                            child: Center(
                              child: AutoSizeText(
                                controller.menuItems[index],
                                maxLines: 1,
                                style: AppTextStyles.formalTextStyle(
                                  color:
                                      controller.favouriteIndex.value == index
                                          ? AppColors.white
                                          : AppColors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
        Expanded(
          child: Obx(
            () => Stack(
              children: [
                controller.isDietFoodFavouriteLoading.value
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.buttonColor,
                        ),
                      )
                    : DietFoodMealTypeItems(
                        dietFoodFavouriteList:
                            controller.filterFoodFavouriteList,
                      ),
                controller.isLoading.value
                    ? const OverlayWidget()
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ],
    );
  }
}
