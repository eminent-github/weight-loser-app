import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/modules/favourite/screens/diet_favourite/diet_favourite_page/diet_favourite_page.dart';
import 'package:weight_loss_app/modules/favourite/screens/exercise_favourite/exercise_favourite_page/exercise_favourite_page.dart';

class FavouriteController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  List<Widget> tabViewScreens = [
    // const MindFavouritePage(),
    const ExerciseFavouritePage(),
    const DietFavouritePage(),
  ];
  @override
  void onInit() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.onInit();
  }

  var favouriteTabsList = [
    // const Tab(
    //   child: Text(
    //     'Mind',
    //   ),
    // ),
    const Tab(
      child: Text(
        'Exercise',
      ),
    ),
    const Tab(
      child: Text(
        'Diet',
      ),
    ),
  ];
}
