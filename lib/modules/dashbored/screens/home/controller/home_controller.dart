import 'dart:convert';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sp_showcaseview/showcaseview.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/diary/controller/diary_controller.dart';
import 'package:weight_loss_app/modules/progress_user/controller/progress_user_controller.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

// import 'package:weight_loss_app/widgets/payment_expiry_dialog.dart';
// import 'package:weight_loss_app/widgets/submit_review_dialog.dart';
// import 'package:weight_loss_app/widgets/trial_expiry_dialog.dart';
import '../screens/home_inner_diet/home_inner_diet_page/home_inner_diet_page.dart';
import '../screens/home_inner_exercise/home_inner_exercise_page/home_inner_exercise_page.dart';
import '../screens/home_inner_mind/home_inner_mind_page/home_inner_mind_page.dart';
import '../screens/home_inner_today/home_inner_today_page/home_screen.dart';

final GlobalKey todayKey = GlobalKey();
final GlobalKey dietkey = GlobalKey();
final GlobalKey exerciseksy = GlobalKey();
final GlobalKey mindksy = GlobalKey();

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  bool? isCallShowcase = false;
  late List<Widget> tabViewScreens;
  var tabItemIndex = 0.obs;
  // @override
  // void onReady() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     Get.dialog(
  //       const PaymentExpiryDialog(),
  //       barrierDismissible: false,
  //     );
  //   });
  //   super.onReady();
  // }

  @override
  void onInit() {
    tabController = TabController(
      length: 4,
      vsync: this,
    );
    tabViewScreens = [
      HomeInnerTodayPage(tabController: tabController),
      const HomeInnerDietPage(),
      const HomeInnerExercisePage(),
      const HomeInnerMindPage(),
    ];
    tabController.addListener(() {
      tabItemIndex.value = tabController.index;
    });
    super.onInit();
  }

  var homePageTabsList = [
    Showcase(
      key: todayKey,
      description: "Get insight of your today's task here.",
      disableDefaultTargetGestures: false,
      onBarrierClick: () => debugPrint('Barrier clicked'),
      child: const Tab(
        child: Text(
          'Today',
        ),
      ),
    ),
    Showcase(
      key: dietkey,
      description: 'Tap here to see and select your diet.',
      disableDefaultTargetGestures: false,
      onBarrierClick: () => debugPrint('Barrier clicked'),
      child: const Tab(
        child: Text(
          'Diet',
        ),
      ),
    ),
    Showcase(
      key: exerciseksy,
      description: 'Tap here to select and access your exercise.',
      disableDefaultTargetGestures: false,
      onBarrierClick: () => debugPrint('Barrier clicked'),
      child: const Tab(
        child: AutoSizeText(
          'Exercise',
          minFontSize: 10,
          maxFontSize: 16,
          maxLines: 1,
        ),
      ),
    ),
    Showcase(
      key: mindksy,
      description: 'Get your daily meditation lesson here.',
      disableDefaultTargetGestures: false,
      onBarrierClick: () => debugPrint('Barrier clicked'),
      child: const Tab(
        child: Text(
          'Mind',
        ),
      ),
    ),
  ];

  final TextEditingController intakeController = TextEditingController();

  @override
  void dispose() {
    intakeController.dispose();
    tabController.dispose();
    super.dispose();
  }

  final ApiService apiService = ApiService();
  var isToadayWaterLoading = false.obs;
  Future<void> saveUserTodayWater({
    required int numberOfGlass,
  }) async {
    // log(todayDietModel.mealType!.toLowerCase());
    Map<String, dynamic> bodyData = {
      "FoodType": "water",
      "WaterServing": numberOfGlass,
    };
    intakeController.clear();
    try {
      isToadayWaterLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.post(
        ApiUrls.saveTodayDiet,
        jsonEncode(bodyData),
        authToken: token,
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        customSnackbar(
            title: AppTexts.success,
            message: "$numberOfGlass glass of water added");
        Get.find<ProgressUserController>().getUserStats();
        Get.find<DiaryController>()
            .getDiaryDetail(DateTime.now())
            .then((value) {
          isToadayWaterLoading.value = false;
        }).onError((error, stackTrace) {
          isToadayWaterLoading.value = false;
        });
      } else {
        log(jsonDecode(response.body).toString());
        isToadayWaterLoading.value = false;
        customSnackbar(title: AppTexts.success, message: 'Diet not taken');
      }
    } catch (e) {
      isToadayWaterLoading.value = false;
      log(e.toString());
    }
  }
}
