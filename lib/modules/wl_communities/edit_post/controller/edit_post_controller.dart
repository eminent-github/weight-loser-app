import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/wl_communities/wl_community/model/wl_community_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class EditPostController extends GetxController {
  var postTextController = TextEditingController().obs;

  var imageApiIdsList = <String>[].obs;
  @override
  void onInit() {
    ChatPoster chatPost = Get.arguments;
    postTextController.value = TextEditingController(text: chatPost.text);
    postTextValue.value = chatPost.text!;
    imageApiIdsList.value = chatPost.filename!;
    super.onInit();
  }

  final postTextValue = ''.obs;
  Future getImage() async {
    final pickedFile = await ImagePicker().pickMultipleMedia();

    if (pickedFile.isNotEmpty) {
      for (var element in pickedFile) {
        if (element.path.contains(".mp4")) {
          await postImageOrVideoApi("video", File(element.path));
        } else {
          await postImageOrVideoApi("image", File(element.path));
        }
      }
    }
  }

  Future getCameraImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      await postImageOrVideoApi("image", File(pickedFile.path));
    }
  }

  bool isTextOnlySpaces(String text) {
    return text.trim().isEmpty;
  }

  void editPost(int chatId, int fileId) async {
    if (postTextController.value.text.isEmpty && imageApiIdsList.isEmpty) {
      customSnackbar(
          title: AppTexts.success, message: 'There is Nothing to post.');
    } else if (imageApiIdsList.isNotEmpty) {
      bool isFileSaved = await savingFilesApi(imageApiIdsList, fileId);
      if (isFileSaved) {
        editPostApi(fileId, chatId);
      } else {
        customSnackbar(title: AppTexts.success, message: 'Post not Update');
      }
    } else {
      editPostApi(0, chatId);
    }
  }

  var isLoading = false.obs;
  final ApiService apiService = ApiService();
  Future<void> editPostApi(int fileId, int chatId) async {
    print("$chatId fileid $fileId");
    Map<String, dynamic> bodyData = {
      "id": chatId,
      "catagory": "chat",
      "text": postTextController.value.text,
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
      if (response.statusCode == 200) {
        log(dataObj.toString());
        customSnackbar(
            title: AppTexts.success, message: 'Post Updated successfully');
        isLoading.value = false;

        Get.back();
      } else {
        isLoading.value = false;
        log("$dataObj${response.statusCode}");
        customSnackbar(title: AppTexts.success, message: 'Post not Update');
      }
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }

  Future<bool> savingFilesApi(List<String> fileIdList, int fileId) async {
    // print(postTextController.text);
    Map<String, dynamic> bodyData = {
      "id": fileId,
      "filename": json.encode(fileIdList),
    };
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.patch(
        ApiUrls.communityChatPostFilesEndPoint,
        jsonEncode(bodyData),
        authToken: token,
      );
      print(response.statusCode);
      // var dataObj = await jsonDecode(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      isLoading.value = false;

      log(e.toString());
      return false;
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
        isLoading.value = false;
        log("images name list by apis$imageApiIdsList");
      } else {
        isLoading.value = false;
        customSnackbar(title: AppTexts.success, message: 'image not added');
      }
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }
}
