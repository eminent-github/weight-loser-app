import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/favourite/controller/favourite_controller.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';

class FavouritePage extends GetView<FavouriteController> {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.1,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        title: Text(
          "Favorite ",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: controller.tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: AppColors.white,
          //  dividerHeight: 0,
          indicator: BoxDecoration(
              color: AppColors.buttonColor,
              borderRadius: BorderRadius.circular(50)),
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
          ),
         // dividerHeight: 0,
          splashBorderRadius: BorderRadius.circular(50),
          labelStyle: AppTextStyles.formalTextStyle(
            fontWeight: FontWeight.w700,
          ),
          unselectedLabelColor:
              Theme.of(context).primaryTextTheme.titleMedium!.color!,
          unselectedLabelStyle: AppTextStyles.formalTextStyle(
            fontWeight: FontWeight.w700,
          ),
          tabs: controller.favouriteTabsList,
        ),
      ),
      body: InternetCheckWidget<ConnectivityService>(
        child: TabBarView(
          controller: controller.tabController,
          children: controller.tabViewScreens,
        ),
      ),
    );
  }
}
