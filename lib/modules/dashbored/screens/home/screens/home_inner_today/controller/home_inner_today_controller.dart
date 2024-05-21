import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:app_tutorial/app_tutorial.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_keys.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_today/models/today_budget_model.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_today/models/today_diet_model.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_today/models/today_mdeitation.dart';
import 'package:weight_loss_app/modules/diary/controller/diary_controller.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_page/model/payment_success_detail.dart';
import 'package:weight_loss_app/modules/progress_user/controller/progress_user_controller.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';
import 'package:weight_loss_app/widgets/membership_end_dialog.dart';
import 'package:weight_loss_app/widgets/payment_expiry_dialog.dart';
// import 'package:weight_loss_app/widgets/submit_review_dialog.dart';
import 'package:weight_loss_app/widgets/trial_expiry_dialog.dart';

class HomeInnerTodayController extends GetxController
    with GetSingleTickerProviderStateMixin {
//late BuildContext context;
  @override
  void onReady() {
    hasInternet.value ? allHomePageApis() : allOfflineHomePageApis();
    super.onReady();
  }

  final InAppPurchase iap = InAppPurchase.instance;

  late StreamSubscription<List<PurchaseDetails>> _purchasesSubscription;

  Future<void> initialize() async {
    log("@@@@@@@@@@@@@@@@@@ not avialable:");
    if (!(await iap.isAvailable())) return;
    log("@@@@@@@@@@@@@@@@@@ avialable");

    ///catch all purchase updates
    _purchasesSubscription = InAppPurchase.instance.purchaseStream.listen(
      (List<PurchaseDetails> purchaseDetailsList) {
        log("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^${purchaseDetailsList.length}");
        handlePurchaseUpdates(purchaseDetailsList);
      },
      onDone: () {
        log("%%%%%%%%%%%% DOne");

        _purchasesSubscription.cancel();
      },
      onError: (error) {
        log("@@@@@@@@@@@@@@@@@@ error:$error");
        _purchasesSubscription.resume();
      },
    );
  }

  void handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) async {
    PurchaseDetails purchaseDetails = purchaseDetailsList.first;
    var purchaseStatus = purchaseDetails.status;
    log("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^${purchaseDetailsList.length}");
    switch (purchaseDetails.status) {
      case PurchaseStatus.pending:
        Get.dialog(
          const PaymentExpiryDialog(),
          barrierDismissible: false,
        );
        print(' purchase is in pending');

      case PurchaseStatus.error:
        print(' purchase error ');

        break;
      case PurchaseStatus.canceled:
        print(' purchase cancel ');
        break;
      case PurchaseStatus.purchased:
        print("_____________________${purchaseDetails.transactionDate}");
        break;
      case PurchaseStatus.restored:
        print(' purchase restore ');
        break;
      default:
        print(
            'this is purchase status not purchased ${purchaseDetails.status}');
    }

    if (purchaseDetails.pendingCompletePurchase) {
      await iap.completePurchase(purchaseDetails).then((value) {
        if (purchaseStatus == PurchaseStatus.purchased) {
          // customSnackbar(
          //   title: AppTexts.success,
          //   message: "Payment Successful!",
          //   icon: const Icon(
          //     Icons.check_circle,
          //     color: Colors.green,
          //   ),
          // );
          // paymentPostApi(
          //   PostPaymentModel(
          //       packageId: monthlyPackage!.id!,
          //       amount: purchaseDetails.,
          //       discount: monthlyPackage!.discountPercent ?? 0,
          //       discountPrice: monthlyPackage!.discountPrice ?? 0,
          //       totalAmount: monthlyPackage!.price!,
          //       status: "paid",
          //       duration: monthlyPackage!.duration ?? 0),
          //   "Apple",
          // );
        }
      });
    }
  }

  allOfflineHomePageApis() async {
    getOfflineTodayCbt();
    getOfflineTodayBudget();
    getOfflineTodayTodos();
    getOfflineTodayExercise();
    getOfflineTodayMeditation();
    getOfflineTodayFood();
  }

  allHomePageApis() async {
    getTodayCBTApi();
    getTodayBudgetApi();
    getTodayTodosApi();
    getTodayExerciseApi();
    getTodayMeditationApi();
    getTodayFoodApi();
  }

  void expiryCheck() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (getTodayBudget.value.customerPackageStatus!.trim() == "paid" &&
          getTodayBudget.value.customerPackageExpired == true) {
        Get.dialog(
          const PaymentExpiryDialog(),
          barrierDismissible: false,
        );
      } else if (getTodayBudget.value.customerPackageStatus == "trial" &&
          getTodayBudget.value.customerPackageExpired == true) {
        Get.dialog(
          const TrialExpiryDialog(),
          barrierDismissible: false,
        );
      } else if (getTodayBudget.value.customerPackageStatus == "cancelled" &&
          getTodayBudget.value.customerPackageExpired == true) {
        Get.dialog(
          const MembershipEndDialog(),
          barrierDismissible: false,
        );
      }
    });
  }

  late TabController tabController;
  int currentTutorialIndex = 0;
  final ApiService apiService = ApiService();
  var isTodayItemSelected = false.obs;
  String isShowCase = 'isShowCase';
  // late StreamSubscription<ConnectivityResult> subscription;
  late StreamSubscription subscription;
  final GetStorage storage = GetStorage();
  var hasInternet = true.obs;
  final incrementKey = GlobalKey();
  final avatarKey = GlobalKey();
  final breakFastKey = GlobalKey();
  final cheatFoodKey = GlobalKey();
  final todayWorkOutKey = GlobalKey();
  final todosTextKey = GlobalKey();
  final insighKey = GlobalKey();
  String cheatFood = '';
  String workout = '';
  List<TutorialItem> items = [];
  @override
  void onInit() async {
    tabController = TabController(
      length: 4,
      vsync: this,
    );
    tabController.addListener(() {
      selectedFoodTabIndex.value = tabController.index;
    });
    checkTimeAndUpdateTab();
    await checkInternetConnectivity();
    listenToConnectivityChanges();
    initialize();
    super.onInit();
  }

  var selectedFoodTabIndex = 0.obs;
  void checkTimeAndUpdateTab() {
    final now = DateTime.now();
    int newIndex;
    if (now.hour >= 5 && now.hour < 10) {
      newIndex = 0;
    } else if (now.hour >= 10 && now.hour < 15) {
      newIndex = 1;
    } else if (now.hour >= 15 && now.hour < 17) {
      newIndex = 2;
    } else if (now.hour >= 17 && now.hour < 20) {
      newIndex = 3;
    } else if (now.hour >= 20 && now.hour < 5) {
      newIndex = 2;
    } else {
      return;
    }

    if (newIndex != selectedFoodTabIndex.value) {
      selectedFoodTabIndex.value = newIndex;
      tabController.animateTo(newIndex);
    }
  }

  ScrollController scrollController = ScrollController();

  @override
  dispose() {
    subscription.cancel();
    scrollController.dispose();
    tabController.dispose();
    super.dispose();
  }

  Future<void> checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    hasInternet.value = (connectivityResult != ConnectivityResult.none);
  }

  ///
  /* -------------------------------------------------------------------------- */
  /*                      update connectivity_plus: ^6.0.3                      */
  /* -------------------------------------------------------------------------- */
  ///

  void listenToConnectivityChanges() {
    subscription = Connectivity().onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        hasInternet.value = (result != ConnectivityResult.none);
      }
    });
  }

  ///
  ///
  ///

  // void listenToConnectivityChanges() {
  //   subscription = Connectivity()
  //       .onConnectivityChanged
  //       .listen((ConnectivityResult result) {
  //     hasInternet.value = (result != ConnectivityResult.none);
  //   });
  // }

  var innerHomeScreenTabsList = [
    const Tab(
      child: Text(
        'Breakfast',
      ),
    ),
    const Tab(
      child: FittedBox(
        child: Text(
          'Lunch',
        ),
      ),
    ),
    const Tab(
      child: FittedBox(
        child: Text(
          'Snacks',
        ),
      ),
    ),
    const Tab(
      child: FittedBox(
        child: Text(
          'Dinner',
        ),
      ),
    ),
  ];

  var isLoading = false.obs;
  var isFoodLoading = false.obs;
  var loaderOverlayLoading = false.obs;
  // Rx<UserTodayQuotaModel> getTodayQuota = UserTodayQuotaModel().obs;
  Rx<TodayBudgetModel> getTodayBudget = TodayBudgetModel().obs;
  Rx<TodayMeditationModel> getTodayMeditation = TodayMeditationModel().obs;
  var getTodayTodosList = <Todos>[].obs;
  var getTodayExerciseList = <ActiveExercisePlanVM>[].obs;
  var getTodayFoodList = <ActiveFoodPlanVM>[].obs;
  var getTodayCBTTitle = "How to fall asleep without efforts".obs;

  void getOfflineTodayBudget() {
    var dataObj = storage.read(
      AppKeys.offlineHomePageBudget,
    );
    getTodayBudget.value = TodayBudgetModel.fromJson(dataObj);
    // expiryCheck();
  }

  void getOfflineTodayTodos() {
    var dataObj = storage.read(
      AppKeys.offlineHomePageTodo,
    );
    var list = dataObj != null ? dataObj as List : [];
    getTodayTodosList.value = list.map((e) => Todos.fromJson(e)).toList();
  }

  void getOfflineTodayExercise() {
    var dataObj = storage.read(
      AppKeys.offlineHomePageExercise,
    );
    var list = dataObj != null ? dataObj as List : [];
    getTodayExerciseList.value =
        list.map((e) => ActiveExercisePlanVM.fromJson(e)).toList();
  }

  void getOfflineTodayFood() {
    var dataObj = storage.read(
      AppKeys.offlineHomePageFood,
    );
    var list = dataObj != null ? dataObj as List : [];
    getTodayFoodList.value =
        list.map((e) => ActiveFoodPlanVM.fromJson(e)).toList();
  }

  void getOfflineTodayMeditation() {
    var dataObj = storage.read(
      AppKeys.offlineHomePageMeditation,
    );
    getTodayMeditation.value = TodayMeditationModel.fromJson(dataObj);
  }

  void getOfflineTodayCbt() {
    var dataObj = storage.read(
      AppKeys.offlineHomePageCBT,
    );
    getTodayCBTTitle.value = dataObj.toString();
  }

  Future<void> getTodayBudgetApi() async {
    try {
      // isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        ApiUrls.homePageTodayBudget,
        authToken: token,
      );
      log("home code: ${response.statusCode} homebody: ${response.body}");

      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);

        getTodayBudget.value = TodayBudgetModel.fromJson(dataObj);
        // expiryCheck();
        await storage.write(AppKeys.offlineHomePageBudget, dataObj);
        // isLoading.value = false;
      } else {
        // isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "No record found");
      }
    } catch (e) {
      // isLoading.value = false;
      log(e.toString());
    }
  }

  Future<void> getTodayCBTApi() async {
    try {
      // isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        ApiUrls.homePageTodayCBT,
        authToken: token,
      );
      log("home code: ${response.statusCode} homebody: ${response.body}");

      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);

        getTodayCBTTitle.value =
            dataObj["cbtTitle"] ?? "How to fall asleep without efforts";

        await storage.write(AppKeys.offlineHomePageCBT,
            dataObj["cbtTitle"] ?? "How to fall asleep without efforts");
        // isLoading.value = false;
      } else {
        // isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "No record found");
      }
    } catch (e) {
      // isLoading.value = false;
      log(e.toString());
    }
  }

  Future<void> getTodayMeditationApi() async {
    try {
      // isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        ApiUrls.homePageTodayMeditation,
        authToken: token,
      );
      log("home code: ${response.statusCode} homebody: ${response.body}");

      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);

        getTodayMeditation.value = TodayMeditationModel.fromJson(dataObj);

        await storage.write(AppKeys.offlineHomePageMeditation, dataObj);
        // isLoading.value = false;
      } else {
        // isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "No record found");
      }
    } catch (e) {
      // isLoading.value = false;
      log(e.toString());
    }
  }

  Future<void> getTodayTodosApi() async {
    try {
      // isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        ApiUrls.homePageTodayTodo,
        authToken: token,
      );
      log("home code: ${response.statusCode} homebody: ${response.body}");

      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        var list = dataObj != null ? dataObj as List : [];
        getTodayTodosList.value = list.map((e) => Todos.fromJson(e)).toList();

        await storage.write(AppKeys.offlineHomePageTodo, dataObj);
        // isLoading.value = false;
      } else {
        // isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "No record found");
      }
    } catch (e) {
      // isLoading.value = false;
      log(e.toString());
    }
  }

  Future<void> getTodayExerciseApi() async {
    try {
      // isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        ApiUrls.homePageTodayExercise,
        authToken: token,
      );
      log("home code: ${response.statusCode} homebody: ${response.body}");

      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        var list = dataObj["activeExercisePlanVM"] != null
            ? dataObj["activeExercisePlanVM"] as List
            : [];
        getTodayExerciseList.value =
            list.map((e) => ActiveExercisePlanVM.fromJson(e)).toList();

        await storage.write(
            AppKeys.offlineHomePageExercise, dataObj["activeExercisePlanVM"]);
        // isLoading.value = false;
      } else {
        // isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "No record found");
      }
    } catch (e) {
      // isLoading.value = false;
      log(e.toString());
    }
  }

  Future<void> getTodayFoodApi() async {
    try {
      isFoodLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        ApiUrls.homePageTodayFood,
        authToken: token,
      );
      log("home code: ${response.statusCode} homebody: ${response.body}");

      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        var list = dataObj["activeFoodPlanVM"] != null
            ? dataObj["activeFoodPlanVM"] as List
            : [];
        getTodayFoodList.value =
            list.map((e) => ActiveFoodPlanVM.fromJson(e)).toList();
        isFoodLoading.value = false;
        await storage.write(
            AppKeys.offlineHomePageFood, dataObj["activeFoodPlanVM"]);
      } else {
        isFoodLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "No record found");
      }
    } catch (e) {
      isFoodLoading.value = false;
      log(e.toString());
    }
  }

  Future<void> saveUserTodayDiet(
    BuildContext context, {
    required ActiveFoodPlanVM todayDietModel,
    required String mealType,
  }) async {
    // log(todayDietModel.mealType!.toLowerCase());
    Map<String, dynamic> bodyData = {
      "FoodType": mealType,
      "FoodId": todayDietModel.foodId,
      "Cons_Cal": todayDietModel.calories!.toInt(),
      "ServingSize": todayDietModel.servingSize,
      "fat": todayDietModel.fat,
      "Protein": todayDietModel.protein,
      "Carbs": todayDietModel.carbs
    };
    try {
      loaderOverlayLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.post(
        ApiUrls.saveTodayDiet,
        jsonEncode(bodyData),
        authToken: token,
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        // var dataObj = await jsonDecode(response.body);
        // log(DateTime.now().toString());
        // log(dataObj.toString());
        customSnackbar(
            title: AppTexts.success,
            message: "You have taken your Today's ${todayDietModel.mealType}");
        Get.find<DiaryController>()
            .getDiaryDetail(DateTime.now())
            .then((value) async {
          await Get.find<ProgressUserController>().getUserStats();
          loaderOverlayLoading.value = false;
          getTodayBudgetApi();
          getTodayFoodApi();
        }).onError((error, stackTrace) {
          loaderOverlayLoading.value = false;
          getTodayBudgetApi();
          getTodayFoodApi();
        });
      } else {
        log(jsonDecode(response.body).toString());
        loaderOverlayLoading.value = false;
        customSnackbar(title: AppTexts.error, message: 'Diet not taken');
      }
    } catch (e) {
      loaderOverlayLoading.value = false;
      log(e.toString());
    }
  }

  Future<void> saveTodosApi(BuildContext context,
      {required int todosId,
      required bool completed,
      required String titile}) async {
    log("id$todosId isCompleted$completed");
    Map<String, dynamic> bodyData = {
      "todosId": todosId,
      "completed": completed,
    };
    try {
      loaderOverlayLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.post(
        ApiUrls.saveUserTodoEndPoint,
        jsonEncode(bodyData),
        authToken: token,
      );
      log(response.statusCode.toString());
      log(jsonDecode(response.body).toString());
      if (response.statusCode == 200) {
        if (completed) {
          customSnackbar(
              title: AppTexts.success,
              message: "Your $titile task is completed");
        }
        loaderOverlayLoading.value = false;
        getTodayTodosApi();
      } else {
        loaderOverlayLoading.value = false;
        customSnackbar(title: AppTexts.success, message: 'Task not Completed');
      }
    } catch (e) {
      loaderOverlayLoading.value = false;
      log(e.toString());
    }
  }

  Future<ActiveExercisePlanVM> replaceExercise(int index) async {
    try {
      loaderOverlayLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        ApiUrls.homePageExerciseReplacement,
        authToken: token,
      );

      log("status code ${response.statusCode}body ${jsonDecode(response.body)}");
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        var jsonList =
            dataObj["foodList"] != null ? dataObj["foodList"] as List : [];
        loaderOverlayLoading.value = false;
        var repFoodList =
            jsonList.map((e) => ActiveExercisePlanVM.fromJson(e)).toList();
        if (repFoodList.length > index) {
          return repFoodList[index];
        }

        throw ClientException("No record found");
      } else {
        loaderOverlayLoading.value = false;
        throw ClientException("No record found");
      }
    } catch (e) {
      loaderOverlayLoading.value = false;
      log(e.toString());
      throw ClientException("No record found");
    }
  }

  Future<void> addReplacedFood({
    required String planFoodId,
    required String repFoodId,
    required int planId,
  }) async {
    Map<String, dynamic> bodyData = {
      "planFoodId": planFoodId,
      "repFoodId": repFoodId,
      "planId": planId
    };
    try {
      loaderOverlayLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.post(
        ApiUrls.foodReplacementEndPoint,
        jsonEncode(bodyData),
        authToken: token,
      );
      log("code${response.statusCode} : body${response.body}");
      if (response.statusCode == 200) {
        var dataObj = await jsonDecode(response.body);
        log(dataObj.toString());
        // customSnackbar(
        //     title: AppTexts.success, message: 'Food added successfully');
        loaderOverlayLoading.value = false;
        getTodayFoodApi();
      } else {
        loaderOverlayLoading.value = false;
        customSnackbar(title: AppTexts.success, message: 'Meal not added');
      }
    } catch (e) {
      loaderOverlayLoading.value = false;
      log(e.toString());
    }
  }

  Future<List<ActiveFoodPlanVM>> replaceDiet(
    BuildContext context, {
    required int phaseId,
    required String mealType,
  }) async {
    try {
      loaderOverlayLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        "${ApiUrls.homePageDietReplacement}/$mealType",
        authToken: token,
      );
      log(response.statusCode.toString());
      log(jsonDecode(response.body).toString());
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        var jsonList = dataObj["foods"] != null ? dataObj["foods"] as List : [];

        var foodList =
            jsonList.map((e) => ActiveFoodPlanVM.fromJson(e)).toList();
        Set<String> uniqueCombinations = <String>{};
        foodList.removeWhere(
            (food) => !uniqueCombinations.add('${food.name}_${food.calories}'));
        loaderOverlayLoading.value = false;
        return foodList;
      } else {
        loaderOverlayLoading.value = false;

        throw ClientException("No record found");
      }
    } catch (e) {
      loaderOverlayLoading.value = false;
      log(e.toString());
      throw ClientException("No record found");
    }
  }

  void showAlertDialog(BuildContext context,
      {required int todosId, required bool completed, required String titile}) {
    showDialog(
      context: context,
      builder: (mcontext) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text(
            'Do you want?',
            style: AppTextStyles.formalTextStyle(
              color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
            ),
          ),
          content: Text(
            'if you really wants to add, click on add button; otherwise you can cancel it.',
            style: AppTextStyles.formalTextStyle(
              color: Theme.of(context).primaryTextTheme.titleSmall!.color!,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(mcontext).pop();
              },
              child: Text(
                'Cancel',
                style: AppTextStyles.formalTextStyle(
                  color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(mcontext).pop();
              },
              child: Text(
                'Add',
                style: AppTextStyles.formalTextStyle(
                  color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<List<ActiveFoodPlanVM>> dietFoodSuggession({
    required String mealType,
  }) async {
    try {
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        "${ApiUrls.homePageDietSuggessions}?mealType=$mealType",
        authToken: token,
      );

      log("+++++++${response.statusCode} --------------${response.body}");
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        var jsonList = dataObj["foods"] != null ? dataObj["foods"] as List : [];

        var foodList =
            jsonList.map((e) => ActiveFoodPlanVM.fromJson(e)).toList();
        print("@@@@@@@${foodList.length}");
        return foodList;
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<void> paymentPostApi(
      PostPaymentModel postPaymentModel, String type) async {
    Map<String, dynamic> bodyData = {
      "packageId": postPaymentModel.packageId,
      "amount": postPaymentModel.amount.toStringAsFixed(2),
      "Discount": postPaymentModel.discount,
      "DiscountPrice": postPaymentModel.discountPrice,
      "TotalAmount": postPaymentModel.totalAmount,
      "type": type,
      "status": postPaymentModel.status, //trial,pending,paid
      "duration": postPaymentModel.duration
    };
    try {
      log("beforeResponse");
      var response = await apiService.post(
        ApiUrls.postPaymentEndPoint,
        jsonEncode(bodyData),
        authToken: await StorageServivce.getToken(),
      );
      log("afterrResponse");
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        // var dateObj = jsonDecode(response.body);
      } else {}
    } catch (e) {
      customSnackbar(title: AppTexts.error, message: "Api Exception");
    }
  }
}
