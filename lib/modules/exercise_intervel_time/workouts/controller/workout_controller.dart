import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/app_assets.dart';
import '../model/workout_model.dart';

class WorkoutController extends GetxController {
  PageController pageController = PageController();
  var currentPage = 0.obs;

  var workoutList = <WorkoutModel>[
    WorkoutModel(
        duration: 16,
        imageUrl: AppAssets.cbtImageSvg,
        isDuration: false,
        title: "Push Ups"),
    WorkoutModel(
        duration: 16,
        imageUrl: AppAssets.cbtImageSvg,
        isDuration: false,
        title: "Push Ups"),
    WorkoutModel(
        duration: 20,
        imageUrl: AppAssets.exerciseSvgUrl,
        isDuration: true,
        title: "Jumping Jacks"),
    WorkoutModel(
        duration: 16,
        imageUrl: AppAssets.cbtImageSvg,
        isDuration: false,
        title: "Push Ups"),
    WorkoutModel(
        duration: 16,
        imageUrl: AppAssets.cbtImageSvg,
        isDuration: false,
        title: "Push Ups"),
    WorkoutModel(
        duration: 20,
        imageUrl: AppAssets.exerciseSvgUrl,
        isDuration: true,
        title: "Jumping Jacks"),
  ];
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
