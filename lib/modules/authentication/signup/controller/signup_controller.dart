import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_keys.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/local_db/notification_db.dart';
import 'package:weight_loss_app/modules/authentication/otp/binding/otp_binding.dart';
import 'package:weight_loss_app/modules/authentication/otp/view/otp_page.dart';
import 'package:weight_loss_app/modules/authentication/signup/models/signup_success_response.dart';
import 'package:weight_loss_app/modules/authentication/social_login/social_login_model.dart';
import 'package:weight_loss_app/modules/authentication/widgets/custom_textformfield.dart';
import 'package:weight_loss_app/modules/registeration_questions/gender/binding/gender_binding.dart';
import 'package:weight_loss_app/modules/registeration_questions/gender/gender_page/gender_page.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_large_button.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class SignUpController extends GetxController {
  var isLoading = false.obs;
  late RemNotifyDBProvider remNotifyDBProvider;
  final ApiService apiService = ApiService();
  Rx<TextEditingController> emailTextEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> nameTextEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> passwordTextEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> emailAppleTextEditingController =
      TextEditingController().obs;
  final GetStorage storage = GetStorage();

  FocusNode nameFocusNode = FocusNode();

  FocusNode emailFocusNode = FocusNode();

  FocusNode passwordFocusNode = FocusNode();
  @override
  void onInit() {
    remNotifyDBProvider = RemNotifyDBProvider();
    super.onInit();
  }

  var passwordVisible = true.obs;
  GoogleSignIn googleSignIn = GoogleSignIn(
      // clientId:
      //     "509631727697-f74qbmhj2se28o5a2a42asko58nl0s16.apps.googleusercontent.com",
      );

  void validateAndCallSignUpApi() {
    if (nameTextEditingController.value.text.isEmpty) {
      customSnackbar(title: AppTexts.alert, message: AppTexts.emptyUserName);
    } else if (!RegExp(r'^[a-zA-Z]+(?: [a-zA-Z]+)*$')
        .hasMatch(nameTextEditingController.value.text)) {
      customSnackbar(
          title: AppTexts.alert,
          message:
              "This name contains certain charecters that aren't allowed.");
    } else if (emailTextEditingController.value.text.isEmpty) {
      customSnackbar(title: AppTexts.alert, message: AppTexts.emptyEmail);
    } else if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(emailTextEditingController.value.text)) {
      customSnackbar(title: AppTexts.alert, message: AppTexts.emailFormat);
    } else if (emailTextEditingController.value.text.endsWith("yopmail.com") ||
        emailTextEditingController.value.text.endsWith("mailinator.com")) {
      customSnackbar(
          title: AppTexts.alert,
          message: "Temporary email addresses are not allowed");
    }
    //  else if (passwordTextEditingController.value.text.isEmpty) {
    //   customSnackbar(title: AppTexts.alert, message: AppTexts.emptyPassword);
    // }
    //  else if (!isPasswordValid(passwordTextEditingController.value.text)) {
    //   customSnackbar(title: AppTexts.alert, message: "Password is invalid");
    // }
    else {
      signUp();
    }
  }

  final formkey = GlobalKey<FormState>();

  bool isPasswordValid(String password) {
    // Define regex patterns for each requirement
    RegExp capitalLetterRegex = RegExp(r'[A-Z]');
    RegExp specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    RegExp numericRegex = RegExp(r'[0-9]');
    RegExp alphabetRegex = RegExp(r'[a-zA-Z]');

    // Check if all requirements are met
    bool hasCapitalLetter = capitalLetterRegex.hasMatch(password);
    bool hasSpecialChar = specialCharRegex.hasMatch(password);
    bool hasNumericDigit = numericRegex.hasMatch(password);
    bool hasAlphabet = alphabetRegex.hasMatch(password);

    // Check if all conditions are satisfied
    return hasCapitalLetter &&
        hasSpecialChar &&
        hasNumericDigit &&
        hasAlphabet; // You can also enforce minimum length
  }

  Future<void> signUp() async {
    Map<String, dynamic> bodyData = {
      "email": emailTextEditingController.value.text,
      "password": passwordTextEditingController.value.text,
      "username": nameTextEditingController.value.text,
    };
    try {
      isLoading.value = true;
      log("beforeResponse 9");
      var response =
          await apiService.post(ApiUrls.signUpEndPoint, json.encode(bodyData));
      log("Response: ${response.statusCode} body: ${jsonDecode(response.body)}");
      var dateObj = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var result = SinUpSuccessResponse.fromJson(dateObj);

        isLoading.value = false;
        if (result.responseDto!.message == "Data saved successfully") {
          insertNotifications();
          await StorageServivce.saveUserName(result.userTokens!.userName!);
          if (await StorageServivce.saveToken(result.userTokens!.token!)) {
            Get.to(
                () => OtpPage(
                    email: emailTextEditingController.value.text,
                    isSignup: true),
                binding: OtpBinding());
          }
        } else if (result.responseDto!.message ==
            " Username/Email is already exist ") {
          customSnackbar(
              title: AppTexts.error,
              message: "Email already exist. Please Login!");
        } else {
          customSnackbar(
              title: AppTexts.error, message: result.responseDto!.message);
        }
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "Api response failed");
      }
    } catch (e) {
      isLoading.value = false;
      log("catch 15 $e");
      // print(e);
    }
  }

  void googleSign() async {
    try {
      var googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        log("${googleUser.email}:${googleUser.displayName}");
        socialSignUp(googleUser.email, googleUser.displayName ?? "unKnown");
      } else {
        customSnackbar(
            title: AppTexts.error,
            message: "Please Select Google Account To Continue");
      }
    } catch (e) {
      log(e.toString());
      customSnackbar(title: AppTexts.error, message: e.toString());
      // customSnackbar(
      //     title: AppTexts.error,
      //     message: "Error occurred using Google Sign In. Try again.");
    }
  }

  void appleSignUp(BuildContext context) async {
    if (await SignInWithApple.isAvailable()) {
      try {
        final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );
        var user = await loginUserWithApple(
            authorizationCredentialAppleID: credential);
        log("${user!.email}:${user.displayName}");
        if (user.email != null) {
          await storage.write(AppKeys.offlineAppleEmail, user.email);
          socialSignUp(user.email!, user.displayName ?? "unKnown");
        } else {
          await showModalBottomSheet(
            context: context,
            showDragHandle: true,
            builder: (BuildContext context) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.32,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Enter the Email ID to continue",
                        style: AppTextStyles.formalTextStyle()),
                    CustomTextFormField(
                      prefixIcon: Icons.email,
                      controller: emailAppleTextEditingController.value,
                      labelText: AppTexts.textFieldEmailAddress,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                    ),
                    CustomLargeButton(
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: MediaQuery.of(context).size.width * 0.3,
                      text: AppTexts.signUpButtonText,
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (emailAppleTextEditingController
                            .value.text.isEmpty) {
                          customSnackbar(
                              title: AppTexts.error,
                              message: "Fields can not be empty");
                        } else if (!emailAppleTextEditingController
                            .value.text.isEmail) {
                          customSnackbar(
                              title: AppTexts.error,
                              message: AppTexts.emailFormat);
                        } else {
                          Get.back();
                          await storage.write(
                              AppKeys.offlineAppleEmail, user.email);
                          socialSignUp(
                              emailAppleTextEditingController.value.text,
                              "User");
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }
      } catch (e) {
        print(e);
      }
    } else {
      customSnackbar(
          title: AppTexts.alert,
          message: "Apple login is not avialable for this device.");
    }
  }

  Future<void> socialSignUp(String email, String name) async {
    Map<String, dynamic> bodyData = {
      "email": email,
      "password": "",
      "username": name,
    };
    try {
      isLoading.value = true;
      log("beforeResponse 9");
      var response =
          await apiService.post(ApiUrls.signUpEndPoint, json.encode(bodyData));
      log("afterrResponse 10${response.statusCode}");
      var dateObj = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var result = SinUpSuccessResponse.fromJson(dateObj);
        log("signUpResponse --------------------------------\n$dateObj");

        isLoading.value = false;
        if (result.responseDto!.message == "Data saved successfully") {
          insertNotifications();
          await StorageServivce.saveUserName(result.userTokens!.userName!);
          if (await StorageServivce.saveToken(result.userTokens!.token!)) {
            Get.off(() => const GenderPage(), binding: GenderBinding());
          }
        } else if (result.responseDto!.message ==
            " Username/Email is already exist ") {
          customSnackbar(
              title: AppTexts.error, message: "Email is already exist");
          if (await googleSignIn.isSignedIn()) {
            await googleSignIn.signOut();
          }
        } else {
          customSnackbar(
              title: AppTexts.error, message: result.responseDto!.message);
        }
      } else {
        log("catch 15 ${response.body}");
        isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "Api response failed");
      }
    } catch (e) {
      isLoading.value = false;
      log("catch 15 $e");
      // print(e);
    }
  }

  void facebookSignIn() async {
    FacebookAuth facebookInstance = FacebookAuth.instance;
    try {
      final result = await facebookInstance
          .login(permissions: ['email', 'public_profile']);
      if (result.status == LoginStatus.success) {
        var userData = await facebookInstance.getUserData();
        FacebookLoginModel facebookLoginModel =
            FacebookLoginModel.fromJson(jsonEncode(userData));
        await socialSignUp(facebookLoginModel.email ?? "unknown",
            facebookLoginModel.name ?? "unKnown");
      } else if (result.status == LoginStatus.failed) {
        customSnackbar(title: AppTexts.error, message: result.message);
      } else if (result.status == LoginStatus.cancelled) {
        customSnackbar(title: AppTexts.error, message: result.message);
      }
    } catch (e) {
      log(e.toString());
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

  void insertNotifications() async {
    try {
      for (var element in remNotifyDBProvider.remNotilist) {
        await remNotifyDBProvider.insertReminder(element);
      }
    } catch (e) {
      print(e);
    }
  }
}
