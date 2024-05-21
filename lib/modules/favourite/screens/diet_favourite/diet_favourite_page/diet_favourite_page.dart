import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/favourite/screens/diet_favourite/controller/diet_favourite_controller.dart';

class DietFavouritePage extends GetView<DietFavouriteController> {
  const DietFavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Column(
      children: [
        SizedBox(
          height: height * 0.04,
        ),
        TabBar(
          controller: controller.tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: AppColors.buttonColor,
          // labelPadding: const EdgeInsets.all(0),
          // padding:const EdgeInsets.all(0),
          indicatorPadding: EdgeInsets.symmetric(horizontal: width * 0.07),
          //dividerHeight: 0,
          labelColor: AppColors.buttonColor,
          indicatorWeight: 3,
          labelStyle: AppTextStyles.formalTextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        //  dividerHeight: 0,
          unselectedLabelColor:
              Theme.of(context).primaryTextTheme.titleMedium!.color!,
          unselectedLabelStyle: AppTextStyles.formalTextStyle(
            fontSize: 16,
          ),
          tabs: controller.dietFavouriteTabsList,
          // tabAlignment: TabAlignment.center,
        ),
        Expanded(
          child: TabBarView(
              controller: controller.tabController,
              children: controller.dietFavouriteScreensList),
        ),
      ],
    );
  }
}
