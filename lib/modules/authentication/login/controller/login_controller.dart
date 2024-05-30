import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:sp_showcaseview/showcaseview.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_keys.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/common/questions_page_name.dart';
import 'package:weight_loss_app/local_db/notification_db.dart';
import 'package:weight_loss_app/modules/authentication/login/model/login_model.dart';
import 'package:weight_loss_app/modules/authentication/otp/binding/otp_binding.dart';
import 'package:weight_loss_app/modules/authentication/otp/view/otp_page.dart';
import 'package:weight_loss_app/modules/authentication/social_login/social_login_model.dart';
import 'package:weight_loss_app/modules/dashbored/binding/dashboared_binding.dart';
import 'package:weight_loss_app/modules/dashbored/dashboared_page/dashboared_page.dart';
// import 'package:weight_loss_app/modules/payment_integration/payment_page_discount/binding/payment_discount_binding.dart';
// import 'package:weight_loss_app/modules/payment_integration/payment_page_discount/view/payment_discount_page.dart';
import 'package:weight_loss_app/modules/refund/binding/refund_binding.dart';
import 'package:weight_loss_app/modules/refund/refund_page/refund_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/active_diagnose/active_diagnose_page/active_diagnose_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/active_diagnose/binding/active_diagnose_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/age/age_page/age_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/age/binding/age_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/boredom_eating/binding/boredom_eating_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/boredom_eating/boredom_eating_page/boredom_eating_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/compliance/compliance_page/compliance_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/cuisine_prefrence/binding/cuisine_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/cuisine_prefrence/view/cuisine_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/deit_goal/binding/goal_diet_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/deit_goal/goal_diet_page/goal_diet_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/eating_habits/binding/eating_habits_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/eating_habits/eating_habits_page/eating_habits_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/exercise/binding/exercise_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/exercise/view/exercise_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/favourite_Rasturants/binding/fav_rasturants_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/favourite_Rasturants/view/fav_rasturants_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/favourite_exercise/binding/favourite_exercise_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/favourite_exercise/favourite_exercise_page/favourite_exercise_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/food_opinion/binding/food_opinion_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/food_opinion/food_opinion_page/food_opinion_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/gender/binding/gender_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/gender/gender_page/gender_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/gym_routine/binding/gym_routine_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/gym_routine/gym_routine_page/gym_routine_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/height/binding/height_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/height/height_page/height_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/mobility/binding/mobility_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/mobility/mobility_page/mobility_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/models/get_question_with_answer_model.dart';
import 'package:weight_loss_app/modules/registeration_questions/pregnnnt/binding/pregnant_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/pregnnnt/pregnant_page/pregnant_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/present_medical/binding/present_medical_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/present_medical/present_medical_page/present_medical_page.dart';
// import 'package:weight_loss_app/modules/registeration_questions/reason_screen/binding/reason_screen_binding.dart';
// import 'package:weight_loss_app/modules/registeration_questions/reason_screen/reason_screen_page/reason_screen_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/religious_diet/binding/religious_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/religious_diet/view/religious_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/sleep_hours/binding/sleep_hours_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/sleep_hours/sleep_hours_page/sleep_hours_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/stress_eating/binding/stress_eating_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/stress_eating/stress_eating_page/stress_eating_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/stress_response_for_eating/binding/stress_response_for_eating_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/stress_response_for_eating/stress_response_for_eating/stress_response_for_eating_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/uncomfortable_exercise/binding/uncomfortable_exercise_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/uncomfortable_exercise/uncomfortable_exercise_page/uncomfortable_exercise_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/water_intake/binding/water_intake_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/water_intake/water_intake_page/water_intake_page.dart';
import 'package:weight_loss_app/modules/registeration_questions/weight/binding/weight_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/weight/weight_page/weight_page.dart';
import 'package:weight_loss_app/modules/splash/model/question_history_model.dart';
// import 'package:weight_loss_app/modules/technical_support_chat/binding/technical_support_binding.dart';
// import 'package:weight_loss_app/modules/technical_support_chat/view/technical_support_page.dart';
import 'package:weight_loss_app/modules/ultimate_selfie/screen/comparision/binding/comparision_binding.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class LoginController extends GetxController {
  final ApiService apiService = ApiService();
  late RemNotifyDBProvider remNotifyDBProvider;
  FocusNode emailFocusNode = FocusNode();
  Rx<TextEditingController> emailTextEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> emailAppleTextEditingController =
      TextEditingController().obs;

  var isLoading = false.obs;
  FocusNode passwordFocusNode = FocusNode();
  Rx<TextEditingController> passwordTextEditingController =
      TextEditingController().obs;
  final GetStorage storage = GetStorage();
  @override
  void onInit() {
    remNotifyDBProvider = RemNotifyDBProvider();
    super.onInit();
  }

  var passwordVisible = true.obs;

  void validateAndCallLoginApi(BuildContext context) {
    if (emailTextEditingController.value.text.isEmpty) {
      customSnackbar(title: AppTexts.error, message: "Fields can not be empty");
    } else if (!emailTextEditingController.value.text.isEmail) {
      customSnackbar(title: AppTexts.error, message: AppTexts.emailFormat);
    } else if (passwordTextEditingController.value.text.isEmpty) {
      customSnackbar(title: AppTexts.error, message: "Fields can not be empty");
    } else {
      logIn(context);
    }
  }

  Future<void> logIn(BuildContext context) async {
    Map<String, dynamic> bodyData = {
      "userName": emailTextEditingController.value.text,
      "password": passwordTextEditingController.value.text,
    };
    try {
      isLoading.value = true;
      log("beforeResponse 9");
      var response =
          await apiService.post(ApiUrls.logInEndPoint, json.encode(bodyData));
      log("Response: ${response.statusCode} body: ${jsonDecode(response.body)}");
      var dateObj = jsonDecode(response.body);

      if (response.statusCode == 200) {
        log("beforeResponse 10");
        var result = LoginModel.fromJson(dateObj);

        if (result.userTokens!.token == null) {
          isLoading.value = false;
          customSnackbar(title: AppTexts.error, message: "No record found");
        } else {
          if (Platform.isAndroid) {
            insertNotifications();
          }
          if (!result.isAccountActive!) {
            await StorageServivce.saveToken(result.userTokens!.token!);
            isLoading.value = false;
            Get.offAll(
                () => OtpPage(
                      email: emailTextEditingController.value.text,
                      isSignup: false,
                    ),
                binding: OtpBinding());
          } else {
            await StorageServivce.saveUserName(result.userTokens!.userName!);
            log(result.userTokens!.userName!);
            try {
              QuestionHistoryModel questionHistoryModel =
                  await getQuestionHistoryApi(result.userTokens!.token!);

              // log('questionare model = ${result.userDto!.targetDate ?? 0}');
              if (questionHistoryModel.isCompleted! &&
                  questionHistoryModel.packageValid!) {
                isLoading.value = false;
                if (await StorageServivce.saveToken(
                    result.userTokens!.token!)) {
                  Get.offAll(
                      () => ShowCaseWidget(builder: Builder(
                            builder: (context) {
                              return const DashboaredPage();
                            },
                          )),
                      binding: DashboaredBinding());
                }
              } else if (questionHistoryModel.packageValid ?? false) {
                await StorageServivce.saveToken(result.userTokens!.token!);

                await StorageServivce.saveCurrentWeight(
                    result.userDto!.weight == null
                        ? 0
                        : result.userDto!.weight!.toInt());
                await StorageServivce.saveGender(result.userDto!.gender == null
                    ? ""
                    : result.userDto!.gender!);
                await StorageServivce.saveGoalDate(
                    result.userDto!.targetDate == null
                        ? DateTime.now().toString()
                        : result.userDto!.targetDate!);
                await StorageServivce.saveWeightUnit(
                    result.userDto!.weightUnit == null
                        ? ""
                        : result.userDto!.weightUnit!);
                await StorageServivce.saveTargetWeight(
                    result.userDto!.targetWeight == null
                        ? 0
                        : result.userDto!.targetWeight!.toInt());
                isLoading.value = false;
                Get.off(
                  () => const EatingHabitsPage(),
                  binding: EatingHabitsBinding(),
                );

                if (questionHistoryModel.pageName != null) {
                  GetQuestionWithAnswerModel getQuestionWithAnswerModel =
                      await qusApi(questionHistoryModel.userQuestionOrder!,
                          result.userTokens!.token!);
                  isLoading.value = false;
                  switch (questionHistoryModel.pageName) {
                    case QuestionPageNames.eatingHabitsPageName:
                      Get.off(
                        () => const EatingHabitsPage(),
                        binding: EatingHabitsBinding(),
                      );
                    case QuestionPageNames.cuisinePrefPageName:
                      Get.off(
                        () => const CuisinePage(),
                        binding: CuisineBinding(),
                        arguments: getQuestionWithAnswerModel,
                      );
                    case QuestionPageNames.religiousDietPageName:
                      Get.off(
                        () => const ReligiousDietPage(),
                        binding: ReligiousDietBinding(),
                        arguments: getQuestionWithAnswerModel,
                      );
                    case QuestionPageNames.favRestuarantsPageName:
                      Get.off(
                        () => const FavRestuarantsPage(),
                        binding: FavRestaurantsBinding(),
                      );
                    case QuestionPageNames.waterIntakePageName:
                      Get.off(
                        () => const WaterIntakePage(),
                        binding: WaterIntakeBinding(),
                        arguments: getQuestionWithAnswerModel,
                      );
                    case QuestionPageNames.exercisePageName:
                      Get.off(
                        () => const ExercisePage(),
                        binding: ExerciseBinding(),
                      );
                    case QuestionPageNames.favouriteExercisePageName:
                      Get.off(
                        () => const FavouriteExercisePage(),
                        binding: FavouriteExerciseBinding(),
                        arguments: getQuestionWithAnswerModel,
                      );
                    case QuestionPageNames.unComfortableExercisePageName:
                      Get.off(
                        () => const UnComfortableExercisePage(),
                        binding: UnComfortableExerciseBinding(),
                        arguments: getQuestionWithAnswerModel,
                      );
                    case QuestionPageNames.gymRoutinePageName:
                      Get.off(
                        () => const GymRoutinePage(),
                        binding: GymRoutineBinding(),
                        arguments: getQuestionWithAnswerModel,
                      );
                    case QuestionPageNames.mobilityPageName:
                      Get.off(
                        () => const MobilityPage(),
                        binding: MobilityBinding(),
                        arguments: getQuestionWithAnswerModel,
                      );
                    case QuestionPageNames.sleepHoursPageName:
                      Get.off(
                        () => const SleepHoursPage(),
                        binding: SleepHoursBinding(),
                      );
                    case QuestionPageNames.stressReponseForEatingPageName:
                      Get.off(
                        () => const StressReponseForEatingPage(),
                        binding: StressResponseForEatingBinding(),
                        arguments: getQuestionWithAnswerModel,
                      );
                    case QuestionPageNames.boredomEatingPageName:
                      Get.off(
                        () => const BoredomEatingPage(),
                        binding: BoredomEatingBinding(),
                        arguments: getQuestionWithAnswerModel,
                      );
                    case QuestionPageNames.foodOpinionPageName:
                      Get.off(
                        () => const FoodOpinionPage(),
                        binding: FoodOpinionBinding(),
                      );
                    case QuestionPageNames.compliancePageName:
                      Get.off(
                        () => const CompliancePage(),
                        binding: ComparisionBinding(),
                        arguments: getQuestionWithAnswerModel,
                      );
                    case QuestionPageNames.stressEatingPageName:
                      Get.off(
                        () => const StressEatingPage(),
                        binding: StressEatingBinding(),
                        arguments: getQuestionWithAnswerModel,
                      );

                    default:
                      Get.off(
                        () => const EatingHabitsPage(),
                        binding: EatingHabitsBinding(),
                      );
                  }
                } else {
                  Get.off(
                    () => const EatingHabitsPage(),
                    binding: EatingHabitsBinding(),
                  );
                }
              } else {
                await StorageServivce.saveToken(result.userTokens!.token!);
                Get.off(
                  () => const GenderPage(),
                  binding: GenderBinding(),
                );

                // if (questionHistoryModel.pageName != null) {
                //   await StorageServivce.saveCurrentWeight(
                //       (result.userDto!.weight ?? 0).toInt());
                //   await StorageServivce.saveGender(
                //       result.userDto!.gender == null
                //           ? ""
                //           : result.userDto!.gender!);
                //   await StorageServivce.saveGoalDate(
                //       result.userDto!.targetDate ?? DateTime.now().toString());
                //   await StorageServivce.saveWeightUnit(
                //       result.userDto!.weightUnit == null
                //           ? ""
                //           : result.userDto!.weightUnit!);
                //   await StorageServivce.saveTargetWeight(
                //       (result.userDto!.targetWeight ?? 0).toInt());
                //   GetQuestionWithAnswerModel getQuestionWithAnswerModel =
                //       await qusApi(questionHistoryModel.userQuestionOrder!,
                //           result.userTokens!.token!);
                //   isLoading.value = false;
                //   switch (questionHistoryModel.pageName) {
                //     case QuestionPageNames.activeDiagnosePageName:
                //       Get.off(
                //         () => ActiveDiagnosePage(
                //           getQuestionWithAnswerModel:
                //               getQuestionWithAnswerModel,
                //         ),
                //         binding: ActiveDiagnoseBinding(),
                //       );
                //     case QuestionPageNames.presentMedicalPageName:
                //       Get.off(
                //         () => const PresentMedicalPage(),
                //         binding: PresentMedicalBinding(),
                //         arguments: getQuestionWithAnswerModel,
                //       );
                //     case QuestionPageNames.genderPageName:
                //       Get.off(
                //         () => const GenderPage(),
                //         binding: GenderBinding(),
                //       );
                //     case QuestionPageNames.pregnantPageName:
                //       Get.off(
                //         () => const PregnantPage(),
                //         binding: PregnantBinding(),
                //       );
                //     case QuestionPageNames.agePageName:
                //       Get.off(
                //         () => const AgePage(),
                //         binding: AgeBinding(),
                //       );
                //     case QuestionPageNames.heightPageName:
                //       Get.off(
                //         () => const HeightPage(),
                //         binding: HeightBinding(),
                //       );
                //     case QuestionPageNames.weightPageName:
                //       Get.off(
                //         () => const HeightPage(),
                //         binding: HeightBinding(),
                //       );
                //     case QuestionPageNames.targetWeightPageName:
                //       Get.off(
                //         () => WeightPage(userHeight: result.userDto!.height),
                //         binding: WeightBinding(),
                //       );
                //     case QuestionPageNames.goalDietPageName:
                //       Get.off(
                //         () => const GoalDietPage(),
                //         binding: GoalDietBinding(),
                //       );
                //     default:
                //       Get.off(
                //         () => const GenderPage(),
                //         binding: GenderBinding(),
                //       );
                //   }
                // } else {
                //   isLoading.value = false;
                //   Get.off(
                //     () => const GenderPage(),
                //     binding: GenderBinding(),
                //   );
                // }
              }
            } catch (e) {
              isLoading.value = false;
              customSnackbar(title: AppTexts.error, message: "$e");
            }
          }
        }
      } else if (response.statusCode == 404) {
        isLoading.value = false;
        if (dateObj["response"]["message"].toString() == "Account is Deleted") {
          _showAlertDialog(context, dateObj["response"]["token"].toString());
        } else {
          customSnackbar(
              title: AppTexts.error,
              message: dateObj["response"]["message"].toString());
        }
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "No record found");
      }
    } catch (e) {
      isLoading.value = false;
      log("Exception $e");
    }
  }

  void googleSign(BuildContext context) async {
    GoogleSignIn googleSignIn = GoogleSignIn(
        // clientId:
        //     "509631727697-f74qbmhj2se28o5a2a42asko58nl0s16.apps.googleusercontent.com",
        );

    try {
      var googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        log("${googleUser.email}:${googleUser.displayName}");
        socialLogIn(googleUser.email, context);
      } else {
        customSnackbar(
            title: AppTexts.error,
            message: "Please Select Google Account To Continue");
      }
    } catch (e) {
      log(e.toString());
      // customSnackbar(title: AppTexts.error, message: e.toString());
      customSnackbar(
          title: AppTexts.error,
          message: "Error occurred using Google Sign In. Try again.");
    }
  }

  void appleSignIn(BuildContext context) async {
    if (await SignInWithApple.isAvailable()) {
      try {
        if (storage.hasData(AppKeys.offlineAppleEmail)) {
          var appleEmail = storage.read(AppKeys.offlineAppleEmail);
          socialLogIn(appleEmail, context);
        } else {
          final credential = await SignInWithApple.getAppleIDCredential(
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
          );

          var user = await loginUserWithApple(
              authorizationCredentialAppleID: credential);
          log("-----------${user!.email}");
          await storage.write(AppKeys.offlineAppleEmail, user.email);
          socialLogIn(user.email!, context);
        }
      } catch (e) {
        print(e);
        customSnackbar(
            title: AppTexts.error,
            message: "Error occurred using Apple Sign In. Try again.");
      }
    } else {
      customSnackbar(
          title: AppTexts.alert,
          message: "Apple login is not avialable for this device.");
    }
  }

  Future<void> socialLogIn(String email, BuildContext context) async {
    Map<String, dynamic> bodyData = {
      "Email": email,
    };
    try {
      isLoading.value = true;
      log("beforeResponse 9");
      var response =
          await apiService.formDataPost(ApiUrls.socialLoginEndPoint, bodyData);
      log("afterrResponse 10+${response.statusCode} body ${response.body}");

      var dateObj = jsonDecode(response.body);

      if (response.statusCode == 200) {
        log("beforeResponse 10");
        log('check my login user response is $dateObj');
        var result = LoginModel.fromJson(dateObj);
        log("beforeResponse 11 $result");
        log("signUpResponse --------------------------------\n${result.responseDto}");
        if (result.responseDto!.status == false) {
          isLoading.value = false;
          GoogleSignIn().signOut();
          customSnackbar(
              title: AppTexts.error,
              message: "First, you have to sign up with Google account");
        } else if (result.userTokens!.token == null) {
          isLoading.value = false;
          GoogleSignIn().signOut();
          customSnackbar(title: AppTexts.error, message: "No record found");
        } else {
          if (Platform.isAndroid) {
            insertNotifications();
          }
          log(result.userTokens!.userName.toString());
          await StorageServivce.saveUserName(
              result.userTokens!.userName.toString());
          try {
            QuestionHistoryModel questionHistoryModel =
                await getQuestionHistoryApi(result.userTokens!.token!);
            isLoading.value = false;
            log('questionare model = ${questionHistoryModel.isCompleted}');
            if (questionHistoryModel.isCompleted! &&
                questionHistoryModel.packageValid!) {
              print(
                  "------------------------------------questionHistoryModel.isCompleted!:${questionHistoryModel.isCompleted!} questionHistoryModel.packageValid!:${questionHistoryModel.packageValid!}");
              if (await StorageServivce.saveToken(result.userTokens!.token!)) {
                Get.offAll(
                    () => ShowCaseWidget(builder: Builder(
                          builder: (context) {
                            return const DashboaredPage();
                          },
                        )),
                    binding: DashboaredBinding());
              }
            } else if (questionHistoryModel.packageValid ?? false) {
              await StorageServivce.saveToken(result.userTokens!.token!);

              await StorageServivce.saveCurrentWeight(
                  result.userDto!.weight!.toInt());
              await StorageServivce.saveGender(result.userDto!.gender == null
                  ? ""
                  : result.userDto!.gender!);
              await StorageServivce.saveGoalDate(result.userDto!.targetDate!);
              await StorageServivce.saveWeightUnit(
                  result.userDto!.weightUnit == null
                      ? ""
                      : result.userDto!.weightUnit!);
              await StorageServivce.saveTargetWeight(
                  result.userDto!.targetWeight!.toInt());
              if (questionHistoryModel.pageName != null) {
                GetQuestionWithAnswerModel getQuestionWithAnswerModel =
                    await qusApi(questionHistoryModel.userQuestionOrder!,
                        result.userTokens!.token!);
                isLoading.value = false;
                switch (questionHistoryModel.pageName) {
                  case QuestionPageNames.eatingHabitsPageName:
                    Get.off(
                      () => const EatingHabitsPage(),
                      binding: EatingHabitsBinding(),
                    );
                  case QuestionPageNames.cuisinePrefPageName:
                    Get.off(
                      () => const CuisinePage(),
                      binding: CuisineBinding(),
                      arguments: getQuestionWithAnswerModel,
                    );
                  case QuestionPageNames.religiousDietPageName:
                    Get.off(
                      () => const ReligiousDietPage(),
                      binding: ReligiousDietBinding(),
                      arguments: getQuestionWithAnswerModel,
                    );
                  case QuestionPageNames.favRestuarantsPageName:
                    Get.off(
                      () => const FavRestuarantsPage(),
                      binding: FavRestaurantsBinding(),
                    );
                  case QuestionPageNames.waterIntakePageName:
                    Get.off(
                      () => const WaterIntakePage(),
                      binding: WaterIntakeBinding(),
                      arguments: getQuestionWithAnswerModel,
                    );
                  case QuestionPageNames.exercisePageName:
                    Get.off(
                      () => const ExercisePage(),
                      binding: ExerciseBinding(),
                    );
                  case QuestionPageNames.favouriteExercisePageName:
                    Get.off(
                      () => const FavouriteExercisePage(),
                      binding: FavouriteExerciseBinding(),
                      arguments: getQuestionWithAnswerModel,
                    );
                  case QuestionPageNames.unComfortableExercisePageName:
                    Get.off(
                      () => const UnComfortableExercisePage(),
                      binding: UnComfortableExerciseBinding(),
                      arguments: getQuestionWithAnswerModel,
                    );
                  case QuestionPageNames.gymRoutinePageName:
                    Get.off(
                      () => const GymRoutinePage(),
                      binding: GymRoutineBinding(),
                      arguments: getQuestionWithAnswerModel,
                    );
                  case QuestionPageNames.mobilityPageName:
                    Get.off(
                      () => const MobilityPage(),
                      binding: MobilityBinding(),
                      arguments: getQuestionWithAnswerModel,
                    );
                  case QuestionPageNames.sleepHoursPageName:
                    Get.off(
                      () => const SleepHoursPage(),
                      binding: SleepHoursBinding(),
                    );
                  case QuestionPageNames.stressReponseForEatingPageName:
                    Get.off(
                      () => const StressReponseForEatingPage(),
                      binding: StressResponseForEatingBinding(),
                      arguments: getQuestionWithAnswerModel,
                    );
                  case QuestionPageNames.boredomEatingPageName:
                    Get.off(
                      () => const BoredomEatingPage(),
                      binding: BoredomEatingBinding(),
                      arguments: getQuestionWithAnswerModel,
                    );
                  case QuestionPageNames.foodOpinionPageName:
                    Get.off(
                      () => const FoodOpinionPage(),
                      binding: FoodOpinionBinding(),
                    );
                  case QuestionPageNames.compliancePageName:
                    Get.off(
                      () => const CompliancePage(),
                      binding: ComparisionBinding(),
                      arguments: getQuestionWithAnswerModel,
                    );
                  case QuestionPageNames.stressEatingPageName:
                    Get.off(
                      () => const StressEatingPage(),
                      binding: StressEatingBinding(),
                      arguments: getQuestionWithAnswerModel,
                    );

                  default:
                    Get.off(
                      () => const EatingHabitsPage(),
                      binding: EatingHabitsBinding(),
                    );
                }
              } else {
                Get.off(
                  () => const EatingHabitsPage(),
                  binding: EatingHabitsBinding(),
                );
              }
            } else {
              await StorageServivce.saveToken(result.userTokens!.token!);
              if (questionHistoryModel.pageName != null) {
                await StorageServivce.saveCurrentWeight(
                    result.userDto!.weight!.toInt());
                await StorageServivce.saveGender(result.userDto!.gender == null
                    ? ""
                    : result.userDto!.gender!);
                await StorageServivce.saveGoalDate(result.userDto!.targetDate!);
                await StorageServivce.saveWeightUnit(
                    result.userDto!.weightUnit == null
                        ? ""
                        : result.userDto!.weightUnit!);
                await StorageServivce.saveTargetWeight(
                    result.userDto!.targetWeight!.toInt());
                GetQuestionWithAnswerModel getQuestionWithAnswerModel =
                    await qusApi(questionHistoryModel.userQuestionOrder!,
                        result.userTokens!.token!);
                switch (questionHistoryModel.pageName) {
                  case QuestionPageNames.activeDiagnosePageName:
                    Get.off(
                      () => ActiveDiagnosePage(
                        getQuestionWithAnswerModel: getQuestionWithAnswerModel,
                      ),
                      binding: ActiveDiagnoseBinding(),
                    );
                  case QuestionPageNames.presentMedicalPageName:
                    Get.off(
                      () => const PresentMedicalPage(),
                      binding: PresentMedicalBinding(),
                      arguments: getQuestionWithAnswerModel,
                    );
                  case QuestionPageNames.genderPageName:
                    Get.off(
                      () => const GenderPage(),
                      binding: GenderBinding(),
                    );
                  case QuestionPageNames.pregnantPageName:
                    Get.off(
                      () => const PregnantPage(),
                      binding: PregnantBinding(),
                    );
                  case QuestionPageNames.agePageName:
                    Get.off(
                      () => const AgePage(),
                      binding: AgeBinding(),
                    );
                  case QuestionPageNames.heightPageName:
                    Get.off(
                      () => const HeightPage(),
                      binding: HeightBinding(),
                    );
                  case QuestionPageNames.weightPageName:
                    Get.off(
                      () => const HeightPage(),
                      binding: HeightBinding(),
                    );
                  case QuestionPageNames.targetWeightPageName:
                    Get.off(
                      () => WeightPage(userHeight: result.userDto!.height),
                      binding: WeightBinding(),
                    );
                  case QuestionPageNames.goalDietPageName:
                    Get.off(
                      () => const GoalDietPage(),
                      binding: GoalDietBinding(),
                    );
                  default:
                    customSnackbar(
                        title: AppTexts.error, message: "No record found");
                }
              } else {
                Get.off(
                  () => const GenderPage(),
                  binding: GenderBinding(),
                );
              }
            }
          } catch (e) {
            isLoading.value = false;
            customSnackbar(title: AppTexts.error, message: "$e");
          }
        }
      } else if (response.statusCode == 404) {
        isLoading.value = false;
        if (dateObj["response"]["message"].toString() == "Account is Deleted") {
          if (dateObj["response"]["token"] != null) {
            _showAlertDialog(context, dateObj["response"]["token"].toString());
          }
        } else {
          customSnackbar(
              title: AppTexts.error,
              message: dateObj["response"]["message"].toString());
        }
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "No Record Found");
      }
    } catch (e) {
      isLoading.value = false;
      print(e);
    }
  }

  void facebookSignIn(BuildContext context) async {
    FacebookAuth facebookInstance = FacebookAuth.instance;
    try {
      final result = await facebookInstance
          .login(permissions: ['email', 'public_profile']);
      if (result.status == LoginStatus.success) {
        var userData = await facebookInstance.getUserData();
        FacebookLoginModel facebookLoginModel =
            FacebookLoginModel.fromJson(jsonEncode(userData));
        await socialLogIn(facebookLoginModel.email ?? "skdjhjkj", context);
      } else if (result.status == LoginStatus.failed) {
        customSnackbar(title: AppTexts.error, message: result.message);
      } else if (result.status == LoginStatus.cancelled) {
        customSnackbar(title: AppTexts.error, message: result.message);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<QuestionHistoryModel> getQuestionHistoryApi(String token) async {
    var response = await apiService.get(
      ApiUrls.getPreviousQusEndPoint,
      authToken: token,
    );
    log("status code ${response.statusCode} body--- ${response.body}");
    if (response.statusCode == 200) {
      var dataObj = jsonDecode(response.body);
      // log("history $dataObj");
      return QuestionHistoryModel.fromJson(dataObj);
    } else {
      throw ClientException("Api Exception");
    }
  }

  Future<GetQuestionWithAnswerModel> qusApi(int order, String token) async {
    try {
      log("beforeResponse");
      var response = await apiService.get(
          "${ApiUrls.getQuestionWithAnswer}?order=$order",
          authToken: token);
      log("status code ${response.statusCode} body ${response.body}");
      if (response.statusCode == 200) {
        var dateObj = jsonDecode(response.body);
        return GetQuestionWithAnswerModel.fromJson(dateObj);
      } else {
        customSnackbar(
            title: AppTexts.error, message: AppTexts.userAPiExceptionResponse);
        return GetQuestionWithAnswerModel();
      }
    } catch (e) {
      // print(e);
      // customSnackbar(title: AppTexts.error, message: "Api Exception");
      return GetQuestionWithAnswerModel();
    }
  }

  void _showAlertDialog(BuildContext context, String token) {
    // Create the AlertDialog
    AlertDialog alert = AlertDialog(
      icon: Icon(
        Icons.support_agent_rounded,
        size: 45,
        color: AppColors.buttonColor,
      ),
      title: Text(
        'Account Activation',
        style: AppTextStyles.formalTextStyle(
          fontWeight: FontWeight.w700,
          color: AppColors.buttonColor,
        ),
      ),
      content: Text(
        'You already deleted this account. Do you want to Activate this Account.',
        textAlign: TextAlign.justify,
        style: AppTextStyles.formalTextStyle(),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the alert dialog
          },
          child: Text(
            'Cancel',
            style: AppTextStyles.formalTextStyle(
              color: AppColors.abstractionTextColor,
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            // await StorageServivce.saveToken(token);
            Get.to(() => const RefundPage(), binding: RefundBinding());
          },
          child: Text(
            'Contact',
            style: AppTextStyles.formalTextStyle(
              color: AppColors.buttonColor,
            ),
          ),
        ),
      ],
    );

    // Show the AlertDialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void insertNotifications() async {
    try {
      for (var element in remNotifyDBProvider.remNotilist) {
        await remNotifyDBProvider.insertReminder(element);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<User?> loginUserWithApple({
    required AuthorizationCredentialAppleID authorizationCredentialAppleID,
  }) async {
    try {
      // To prevent replay attacks with the credential returned from Apple, we
      // include a nonce in the credential request. When signing in with
      // Firebase, the nonce in the id token returned by Apple, is expected to
      // match the sha256 hash of rawNonce.
      final rawNonce = generateNonce();

      // Create a new credential using apple
      final credential = OAuthProvider('apple.com').credential(
        idToken: authorizationCredentialAppleID.identityToken,
        rawNonce: rawNonce,
      );

      // Signing user with apple
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Once signed in, return the user
      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }
}
