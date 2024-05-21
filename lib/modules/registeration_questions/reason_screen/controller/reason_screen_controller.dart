import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/common/questions_page_name.dart';
import 'package:weight_loss_app/modules/registeration_questions/models/user_info_response_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';
import '../../deit_goal/binding/goal_diet_binding.dart';
import '../../deit_goal/goal_diet_page/goal_diet_page.dart';
import '../../user_goal_category/binding/user_goal_category_binding.dart';
import '../../user_goal_category/user_goal_category_page/user_goal_category_page.dart';

class ReasonScreenController extends GetxController {
  RxString selected = "Select your motivation".obs;
  var currentWeight = 0.obs;
  var targetWeight = 0.obs;
  var weightUnit = "".obs;
  List<String> purposeTypeList = [
    "Select your motivation",
    'Marriage',
    'Birthday',
    'Travelling',
    'Other',
  ];
  final ApiService apiService = ApiService();
  var isLoading = false.obs;
  Future<void> lossReasonApi() async {
    Map<String, dynamic> bodyData = {
      "value": selected.value,
      "PageName": QuestionPageNames.reasonScreenPageName,
    };
    print(selected.value);
    try {
      isLoading.value = true;
      var token = await StorageServivce.getToken();
      currentWeight.value = (await StorageServivce.getCurrentWeight())!;
      targetWeight.value = (await StorageServivce.getTargetWeight())!;
      weightUnit.value = (await StorageServivce.getWeightUnit()) == null
          ? "lb"
          : (await StorageServivce.getWeightUnit())!;
      log("beforeResponse");
      var response = await apiService.formDataPatch(
          ApiUrls.reasonLossWeightEndPoint, bodyData,
          authToken: token);
      log("afterrResponse");
      if (response.statusCode == 200) {
        var dateObj = jsonDecode(response.body);
        var result = UserInfoResponseModel.fromJson(dateObj);
        log("heightResponse --------------------------------\n$dateObj and result is $result");
        isLoading.value = false;
        if (result.responseDto!.message == AppTexts.userSuccessResponse) {
          if (selected.value == "Marriage") {
            String? gender = await StorageServivce.getGender();
            if (gender == "Male") {
              Get.to(
                () => UserGoalCategoryPage(
                  imgUrl: AppAssets.userGoalWeddingImgUrl,
                  subTitle:
                      "Congratulations on your upcoming wedding! Lets achieve your weight loss goals together and make sure you feel confident and amazing on your special day. Start now and let the transformation begin!",
                  title: "Wedding-Ready Weight Loss",
                  currentWeight: currentWeight.value,
                  targetWeight: targetWeight.value,
                  weightUnit: weightUnit.value,
                ),
                binding: UserGoalCategoryBinding(),
              );
            } else {
              Get.to(
                () => UserGoalCategoryPage(
                  imgUrl: AppAssets.userGoalWeddingImgUrl,
                  subTitle:
                      "Thank you for letting us be part of your emotional weight loss journey. We're thrilled to bring your radiant bridal transformation to life. Rest assured, you'll feel stunning and exude confidence as you walk down the aisle, making your dream come true!",
                  title: "A bride's dream unfolds",
                  currentWeight: currentWeight.value,
                  targetWeight: targetWeight.value,
                  weightUnit: weightUnit.value,
                ),
                binding: UserGoalCategoryBinding(),
              );
            }
          } else if (selected.value == "Birthday") {
            Get.to(
              () => UserGoalCategoryPage(
                imgUrl: AppAssets.userGoalBirthdayImgUrl,
                subTitle:
                    "Celebrate your special day with confidence! Let's achieve your birthday body goals together, so you feel amazing and look your best as you blow out the candles!",
                title: "Birthday Body Goals",
                currentWeight: currentWeight.value,
                targetWeight: targetWeight.value,
                weightUnit: weightUnit.value,
              ),
              binding: UserGoalCategoryBinding(),
            );
          } else if (selected.value == "Travelling") {
            Get.to(
              () => UserGoalCategoryPage(
                imgUrl: AppAssets.userGoalTravelingImgUrl,
                subTitle:
                    "Embarking on your travel adventures? Let's make your weight loss journey a ticket to the destination of your dreams. Together, we'll ensure you feel energized, confident, and ready to explore the world!",
                title: "Travel-Ready Transformation",
                currentWeight: currentWeight.value,
                targetWeight: targetWeight.value,
                weightUnit: weightUnit.value,
              ),
              binding: UserGoalCategoryBinding(),
            );
          } else if (selected.value == "Other") {
            Get.to(
              () => const GoalDietPage(),
              binding: GoalDietBinding(),
            );
          }
        } else {
          customSnackbar(
              title: AppTexts.error, message: result.responseDto!.message);
        }
      } else {
        isLoading.value = false;
        customSnackbar(
            title: AppTexts.error, message: AppTexts.userAPiExceptionResponse);
      }
    } catch (e) {
      isLoading.value = false;
      // print(e);
      customSnackbar(title: AppTexts.error, message: "Api Exception");
    }
  }
}
