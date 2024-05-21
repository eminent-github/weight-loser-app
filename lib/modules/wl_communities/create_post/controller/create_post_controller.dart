import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class CreatePostController extends GetxController {
  final TextEditingController postTextController = TextEditingController();

  var imagePathList = <String>[].obs;
  var imageApiIdsList = <String>[];
  final postTextValue = ''.obs;
  Future getImage() async {
    final pickedFile = await ImagePicker().pickMultipleMedia();

    if (pickedFile.isNotEmpty) {
      if (imagePathList.isEmpty) {
        imagePathList.value = pickedFile.map((e) {
          return e.path;
        }).toList();
      } else {
        imagePathList.addAll(pickedFile.map((e) {
          return e.path;
        }).toList());
      }
    }
  }

  Future getCameraImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      imagePathList.add(pickedFile.path);
    }
  }

  bool isTextOnlySpaces(String text) {
    return text.trim().isEmpty;
  }

  @override
  void onInit() {
    String image = Get.arguments as String;
    if (image == "") {
    } else {
      imagePathList.add(image);
    }

    super.onInit();
  }

  void createPost() async {
    if (postTextController.text.isEmpty && imagePathList.isEmpty) {
      customSnackbar(
          title: AppTexts.success, message: 'There is Nothing to post.');
    } else if (imagePathList.isNotEmpty) {
      for (var element in imagePathList) {
        if (element.contains(".mp4")) {
          await postImageOrVideoApi("video", File(element));
        } else {
          await postImageOrVideoApi("image", File(element));
        }
      }

      int id = await savingFilesApi(imageApiIdsList);
      if (id != 0) {
        createPostApi(id);
      } else {
        customSnackbar(title: AppTexts.success, message: 'Post not added');
      }
    } else {
      createPostApi(0);
    }
  }

  var isLoading = false.obs;
  final ApiService apiService = ApiService();
  Future<void> createPostApi(int fileId) async {
    // print(postTextController.text);
    Map<String, dynamic> bodyData = {
      "text": postTextController.text,
      "catagory": "chat",
      "fileId": fileId,
      "isSaved": "false"
    };
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.post(
        ApiUrls.communityChatPostEndPoint,
        jsonEncode(bodyData),
        authToken: token,
      );
      var dataObj = await jsonDecode(response.body);
      log('this is status coode when adding post to server ${response.statusCode}');
      if (response.statusCode == 200) {
        log(dataObj.toString());
        isLoading.value = false;
        Get.back();
        customSnackbar(
            title: AppTexts.success, message: 'Post Added successfully');
      } else {
        isLoading.value = false;
        log("$dataObj${response.statusCode}");
        customSnackbar(title: AppTexts.success, message: 'Post not added');
      }
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }

  Future<int> savingFilesApi(List<String> fileIdList) async {
    // print(postTextController.text);
    Map<String, dynamic> bodyData = {
      "filename": json.encode(fileIdList),
    };
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.post(
        ApiUrls.communityChatPostFilesEndPoint,
        jsonEncode(bodyData),
        authToken: token,
      );
      var dataObj = await jsonDecode(response.body);
      if (response.statusCode == 200) {
        return dataObj["responseDto"]["id"] as int;
      } else {
        isLoading.value = false;
        return 0;
      }
    } catch (e) {
      isLoading.value = false;

      log(e.toString());
      return 0;
    }
  }

  Future<void> postImageOrVideoApi(String type, File myimageFile) async {
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
      print(response.statusCode);
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        Map<String, dynamic> jsonData = jsonDecode(responseBody);
        String imageFileName = jsonData["fileName"] as String;
        imageApiIdsList.add(imageFileName);
        log("images name list by apis$imageApiIdsList");
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.success, message: 'Post not added');
      }
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }
}
