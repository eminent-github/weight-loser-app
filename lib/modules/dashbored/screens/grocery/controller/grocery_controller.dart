import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

import '../models/user_grocery_model.dart';

class GroceryController extends GetxController {
  List<String> queryList = ["Today", "Weekly", "Monthly"];

  var currentIndex = 0.obs;

  var userGroceryModel = UserGroceryModel().obs;

  @override
  void onInit() {
    getGroceryApi(queryList[currentIndex.value]);
    super.onInit();
  }

  Future<void> getGroceryApi(String duration) async {
    try {
      // isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        "${ApiUrls.getGroceryEndPoint}?duration=$duration",
        authToken: token,
      );
      log("plandetial ${response.statusCode} body : ${response.body}");
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);

        userGroceryModel.value = UserGroceryModel.fromMap(dataObj);

        // isLoading.value = false;
      } else {
        // isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "No record found");
      }
    } catch (e) {
      // isLoading.value = false;
      log("exception ${e.toString()}");
    }
  }

  var isLoading = false.obs;
  var isPurchasedLoading = false.obs;
  final ApiService apiService = ApiService();

  Future<void> groceryPurchasedApi({
    required int listId,
    required bool isPurchased,
  }) async {
    Map<String, dynamic> bodyData = {
      "listId": listId,
    };
    try {
      isPurchasedLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.post(
        ApiUrls.groceryPurchasedEndPoint,
        jsonEncode(bodyData),
        authToken: token,
      );

      if (response.statusCode == 200) {
        // var dataObj = await jsonDecode(response.body);
        // print(dataObj);
        if (isPurchased) {
          customSnackbar(
              title: AppTexts.success,
              message:
                  'Item checked! Your physical purchases are now recorded.');
        }

        isPurchasedLoading.value = false;
        getGroceryApi(queryList[currentIndex.value]);
      } else {
        isPurchasedLoading.value = false;
        customSnackbar(title: AppTexts.success, message: 'Item not Checked');
      }
    } catch (e) {
      isPurchasedLoading.value = false;
      log(e.toString());
    }
  }
}
