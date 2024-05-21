// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/progress_user/controller/progress_user_controller.dart';
import 'package:weight_loss_app/modules/ultimate_selfie/models/ultimate_selfie_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class UltimateSelfieController extends GetxController {
  late TextEditingController weightController;
  late TextEditingController waistController;

  @override
  void onInit() {
    weightController = TextEditingController();
    waistController = TextEditingController();
    getUltimateApi();
    super.onInit();
  }

  @override
  void dispose() {
    waistController.dispose();
    waistController.dispose();
    super.dispose();
  }

  double bmi(double height, String unit, double weight) {
    log("height: $height weight: $weight unit: $unit");
    if (unit != "kg") {
      double heightInInches = (height / 2.54);
      log("bmi: ${weight / (heightInInches * heightInInches) * 703}");
      return weight / (heightInInches * heightInInches) * 703;
    } else {
      double heightInMeters = height / 100;
      log("bmi: ${weight / (heightInMeters * heightInMeters)}");
      return weight / (heightInMeters * heightInMeters);
    }
  }

  RxString imagePath = ''.obs;
  Future<bool> getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
      return true;
    }
    return false;
  }

  Rx<DateTime?> selectedDate = DateTime.now().obs;

  Future<void> pickDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
    }
  }

  var isLoading = false.obs;
  var isSelfieUploadLoading = false.obs;
  final ApiService apiService = ApiService();
  var userSelfieData = UltimateSelfieModel().obs;

  Future<void> getUltimateApi() async {
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        ApiUrls.getUltimateSelfieEndPoint,
        authToken: token,
      );
      log("${response.statusCode}body${response.body}");
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        userSelfieData.value = UltimateSelfieModel.fromJson(dataObj);

        isLoading.value = false;
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "No record found");
      }
    } catch (e) {
      isLoading.value = false;
      log("exception ${e.toString()}");
    }
  }

  void validateAndPost(
    BuildContext context,
    double height,
    String unit,
  ) {
    if (weightController.value.text.isEmpty) {
      customSnackbar(title: AppTexts.alert, message: "Weight is Required");
    } else if (waistController.value.text.isEmpty) {
      customSnackbar(title: AppTexts.alert, message: "Waist is Required");
    } else if (bmi(height, unit, double.parse(weightController.text))
            .toPrecision(1) <
        18.5) {
      customSnackbar(
          title: AppTexts.alert, message: "Please enter correct weight");
    } else if (int.parse(waistController.value.text) < 10 ||
        int.parse(waistController.value.text) > 80) {
      customSnackbar(
          title: AppTexts.alert, message: "Please enter correct Waist");
    } else {
      Navigator.of(context).pop();
      postSelfieApi(File(imagePath.value));
    }
  }

  Future<void> postSelfieApi(File myimageFile) async {
    try {
      isSelfieUploadLoading.value = true;
      String? token = await StorageServivce.getToken();
      var request = http.MultipartRequest('POST',
          Uri.parse("${ApiUrls.baseUrl}${ApiUrls.getUltimateSelfieEndPoint}"));

      request.headers.addAll({
        'Accept': 'multipart/form-data',
        'Authorization': 'Bearer $token',
      });

      request.fields['Weight'] = weightController.value.text;
      request.fields['Waist'] = waistController.value.text;
      request.fields['Dated'] = selectedDate.value.toString();

      var stream = http.ByteStream(Stream.castFrom(myimageFile.openRead()));
      var length = await myimageFile.length();
      var multipartFile = http.MultipartFile('ImageFile', stream, length,
          filename: myimageFile.path.split('/').last);
      request.files.add(multipartFile);

      var response = await request.send();
      // print(response.statusCode);
      if (response.statusCode == 200) {
        // var responseBody = await response.stream.bytesToString();
        // Map<String, dynamic> jsonData = jsonDecode(responseBody);
        imagePath.value = "";

        customSnackbar(
            title: AppTexts.success, message: 'Picture is uploaded.');
        weightController.clear();
        waistController.clear();
        var userProgressController = Get.find<ProgressUserController>();
        userProgressController.getUserStats().then((value) {
          userProgressController.getUserWeightStats();
          isSelfieUploadLoading.value = false;
          getUltimateApi();
        }).onError((error, stackTrace) {
          isSelfieUploadLoading.value = false;
          getUltimateApi();
        });
      } else {
        isSelfieUploadLoading.value = false;
        customSnackbar(title: AppTexts.success, message: 'Selfie not Posted');
      }
    } catch (e) {
      isSelfieUploadLoading.value = false;
      log(e.toString());
    }
  }

  Future<void> downloadImage(
      {required String url, required BuildContext context}) async {
    try {
      var response = await Dio()
          .get(url, options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 100,
          name: "name");
      log('this is image path and info $result');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Image downloaded successfully'),
        ),
      );
    } catch (error) {
      log('Error downloading image: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error downloading image'),
        ),
      );
    }
  }
}
