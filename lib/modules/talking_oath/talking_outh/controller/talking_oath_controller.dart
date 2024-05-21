import 'dart:developer';

import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/talking_oath/oath_taken/binding/oath_taken_binding.dart';
import 'package:weight_loss_app/modules/talking_oath/oath_taken/view/oath_taken_page.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class TalkingOathController extends GetxController {
  var userName = ''.obs;
  var targetWeight = 0.obs;
  var currentWeight = 0.obs;
  var weightUnit = "".obs;
  var gender = 'Gender'.obs;

  getUserName() async {
    userName.value = await StorageServivce.getUserName() ?? 'unknown';
    gender.value = await StorageServivce.getGender() ?? 'Gender';
  }

  var isLoading = false.obs;
  final ApiService apiService = ApiService();
  @override
  void onInit() {
    getUserName();
    getTargetAndCurrentWeight();
    super.onInit();
  }

  Future<void> takenOathApi() async {
    var body = {"isOath": "true"};
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.formDataPatch(
        ApiUrls.takingOathEndPoint,
        body,
        authToken: token,
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        // var dataObj = await jsonDecode(response.body);
        // print(dataObj);
        isLoading.value = false;
        Get.to(() => const OathTakenPage(), binding: OathTakenBinding());
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.success, message: 'Oath Failed');
      }
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }

  getTargetAndCurrentWeight() async {
    targetWeight.value = (await StorageServivce.getTargetWeight())??0;
    currentWeight.value = (await StorageServivce.getCurrentWeight())??0;
    weightUnit.value = (await StorageServivce.getWeightUnit())??"lbs";
  }

  int daysToLoseWeight(
      {required num goalWeight,
      required num currentWeight,
      required double weightPerWeek}) {
    log("cwe: $currentWeight gwe: $goalWeight perWeek: $weightPerWeek");
    double numbeOfWeeks = (currentWeight - goalWeight) / weightPerWeek;
    // print("numbeOfWeeks : $numbeOfWeeks");
    if (numbeOfWeeks <= 4) {
      return 1;
    }
    return ((numbeOfWeeks / 4.34524) * 30).round();
  }
}
