import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';

final GlobalKey bottomKey = GlobalKey();
final GlobalKey progressKey = GlobalKey();
final GlobalKey diaryKey = GlobalKey();

class DashboaredController extends GetxController {
  RxBool isDrawerHide = false.obs;
  late List<Widget> tabItems;
  RxString userName = ''.obs;
  RxBool doubleTap = false.obs;
  bool isCallShowcase = false;
  getUserName() async {
    userName.value = await StorageServivce.getUserName() ?? 'unknown';
  }

  @override
  void onInit() {
    getUserName();
    super.onInit();
  }
}
