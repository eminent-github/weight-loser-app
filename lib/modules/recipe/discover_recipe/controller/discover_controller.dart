import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/recipe/discover_recipe/model/discover_recipe_model.dart';
import 'package:weight_loss_app/modules/recipe/discover_recipe/widgets/discover_list_widget.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class DiscoverController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  FocusNode searchFocusNode = FocusNode();
  late List<Widget> tabViewScreens;
  var tabItemIndex = 0.obs;
  var cousineIndex = RxInt(-1);
  @override
  void onInit() {
    tabController = TabController(
      length: 5,
      vsync: this,
    );
    tabViewScreens = [
      DiscoverListWidget(recipeDataList: filterRecipeDataList),
      DiscoverListWidget(recipeDataList: filterRecipeDataList),
      DiscoverListWidget(recipeDataList: filterRecipeDataList),
      DiscoverListWidget(recipeDataList: filterRecipeDataList),
      DiscoverListWidget(recipeDataList: filterRecipeDataList),
    ];
    recipeDataApi(type: "all");
    tabController.addListener(() {
      tabItemIndex.value = tabController.index;
      if (searchFocusNode.hasFocus) {
        searchFocusNode.unfocus();
      }
      if (tabController.index == 0) {
        recipeDataApi(type: "all");
      } else if (tabController.index == 1) {
        recipeDataApi(type: "breakfast");
      } else if (tabController.index == 2) {
        recipeDataApi(type: "lunch");
      } else if (tabController.index == 3) {
        recipeDataApi(type: "snacks");
      } else if (tabController.index == 4) {
        recipeDataApi(type: "dinner");
      }
    });
    super.onInit();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  var homePageTabsList = [
    const Tab(
      iconMargin: EdgeInsets.only(bottom: 5.0),
      text: "All",
    ),
    const Tab(
      iconMargin: EdgeInsets.only(bottom: 5.0),
      text: "Breakfast",
    ),
    const Tab(
      iconMargin: EdgeInsets.only(bottom: 5.0),
      text: "Lunch",
    ),
    const Tab(
      iconMargin: EdgeInsets.only(bottom: 5.0),
      text: "Snack",
    ),
    const Tab(
      iconMargin: EdgeInsets.only(bottom: 5.0),
      text: "Dinner",
    ),
  ];

  var isLoading = false.obs;
  final ApiService apiService = ApiService();
  var recipeDataList = <DiscoverRecipeModel>[].obs;
  var filterRecipeDataList = <DiscoverRecipeModel>[].obs;
  var cuisines = <String>[].obs;
  // @override
  // void onInit() {
  //   recipeDataApi();
  //   super.onInit();
  // }

  Future<void> recipeDataApi({required String type}) async {
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        "${ApiUrls.foodRecipiesEndPoint}?MealType=$type",
        authToken: token,
      );
      log(response.statusCode.toString());
      log(jsonDecode(response.body).toString());
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        var jsonList = dataObj["foods"] != null ? dataObj["foods"] as List : [];
        isLoading.value = false;
        cuisines.value = dataObj['cuisines'].cast<String>();
        recipeDataList.value =
            jsonList.map((e) => DiscoverRecipeModel.fromJson(e)).toList();
        // Set<String> uniqueCombinations = <String>{};
        // foodList.removeWhere(
        //     (food) => !uniqueCombinations.add('${food.name}_${food.calories}'));

        // recipeDataList.value = foodList;
        filterRecipeDataList.assignAll(recipeDataList);
      } else {
        customSnackbar(title: AppTexts.error, message: "No record found");
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }

  void filterFoods(String query) {
    if (query.isEmpty) {
      filterRecipeDataList.assignAll(recipeDataList);
    } else {
      final result = recipeDataList.where(
          (food) => food.name!.toLowerCase().contains(query.toLowerCase()));
      filterRecipeDataList.assignAll(result.toList());
    }
    update();
  }

  void filterCousine(String query) {
    if (query.isEmpty) {
      filterRecipeDataList.assignAll(recipeDataList);
    } else {
      final result = recipeDataList.where(
          (food) => food.cuisine!.toLowerCase().contains(query.toLowerCase()));
      filterRecipeDataList.assignAll(result.toList());
    }
    update();
  }
}
