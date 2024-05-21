import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/profile/view_profile/model/user_profile_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class EditProfileController extends GetxController {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController locationController;
  late TextEditingController phoneNumberController;
  RxString updatedImage = "".obs;
  var isLoading = false.obs;
  final ApiService apiService = ApiService();

  @override
  void onInit() {
    var userProfileData = Get.arguments as UserProfileModel;
    nameController = TextEditingController(text: userProfileData.name);
    emailController = TextEditingController(text: userProfileData.email);
    locationController = TextEditingController(text: userProfileData.location);
    phoneNumberController = TextEditingController(text: userProfileData.mobile);
    updatedImage.value =
        userProfileData.imgPah == null ? "" : userProfileData.imgPah!;
    super.onInit();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    locationController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      postImageApi("image", File(pickedImage.path));
    } else {
      customSnackbar(title: AppTexts.success, message: 'Please take an Image');
    }
  }

  void validateAndPost({
    required int profId,
  }) {
    if (nameController.value.text.isEmpty) {
      customSnackbar(title: AppTexts.error, message: AppTexts.emptyUserName);
    } else if (locationController.value.text.isEmpty) {
      customSnackbar(title: AppTexts.error, message: AppTexts.emptyLocation);
    } else if (phoneNumberController.value.text.isEmpty) {
      customSnackbar(title: AppTexts.error, message: AppTexts.emptyPhoneNumber);
    } else if (phoneNumberController.value.text.length < 5) {
      customSnackbar(
          title: AppTexts.error, message: "Please enter correct number");
    } else if (locationController.value.text.length < 3) {
      customSnackbar(
          title: AppTexts.error, message: "Please enter correct location");
    } else {
      editProfile(profId: profId);
    }
  }

  Future<void> postImageApi(String type, File myimageFile) async {
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var request = http.MultipartRequest('POST',
          Uri.parse("${ApiUrls.baseUrl}${ApiUrls.communityPostImageEndPoint}"));

      request.headers.addAll({
        'Accept': 'multipart/form-data',
        'Authorization': 'Bearer $token',
      });

      request.fields['Type'] = type;

      var stream = http.ByteStream(Stream.castFrom(myimageFile.openRead()));
      var length = await myimageFile.length();
      var multipartFile = http.MultipartFile('ImageFile', stream, length,
          filename: myimageFile.path.split('/').last);
      request.files.add(multipartFile);

      var response = await request.send();
      // print(response.statusCode);
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        Map<String, dynamic> jsonData = jsonDecode(responseBody);
        updatedImage.value = jsonData["fileName"] as String;
        customSnackbar(
            title: AppTexts.success, message: 'Picture added Successfully');
        log("images name list by apis${updatedImage.value}");

        isLoading.value = false;
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.success, message: 'image not added');
      }
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }

  Future<void> editProfile({
    required int profId,
  }) async {
    Map<String, dynamic> bodyData = {
      "id": profId,
      "name": nameController.text,
      "location": locationController.text,
      "mobile": phoneNumberController.text,
      "imgPah": updatedImage.value
    };
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.post(
        ApiUrls.postUserProfileEndPoint,
        jsonEncode(bodyData),
        authToken: token,
      );
      var dataObj = await jsonDecode(response.body);
      print("$dataObj${response.statusCode}");
      if (response.statusCode == 200) {
        await StorageServivce.saveUserName(nameController.text);
        Get.back();
        customSnackbar(
            title: AppTexts.success, message: 'Profile Updated successfully');

        isLoading.value = false;
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.success, message: 'Profile not Update');
      }
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }
}
