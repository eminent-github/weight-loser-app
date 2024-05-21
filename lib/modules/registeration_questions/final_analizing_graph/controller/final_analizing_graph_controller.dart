import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class FinalAnalizingGraphController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void onInit() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    super.onInit();
  }

  @override
  void onReady() {
    animationController.forward();
    super.onReady();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
