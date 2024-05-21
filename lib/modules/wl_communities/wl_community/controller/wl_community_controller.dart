import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/wl_communities/create_post/binding/create_post_binding.dart';
import 'package:weight_loss_app/modules/wl_communities/create_post/create_post_page/create_post_page.dart';
import 'package:weight_loss_app/modules/wl_communities/wl_community/model/wl_community_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class WlCommunityController extends GetxController {
  var communityAllPostsList = <CommunityAllPostsModel>[].obs;
  var userCommentsList = <ListCommentors>[].obs;
  final TextEditingController commentController = TextEditingController();
  var profImage = "".obs;
  Future getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      Get.to(
        () => const CreatePostPage(),
        binding: CreatePostBinding(),
        arguments: pickedFile.path,
      );
    }
  }

  var isLoading = false.obs;
  var isCommentsLoading = false.obs;
  var isSavedLoading = false.obs;
  var isSavedCommentLoading = false.obs;
  final ApiService apiService = ApiService();

  @override
  void onInit() {
    getAllPostsApi();
    super.onInit();
  }

  Future<void> getAllPostsApi() async {
    try {
      // isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        ApiUrls.communityAllPostsEndPoint,
        authToken: token,
      );
      log("${response.statusCode}body:${jsonDecode(response.body)["chatAllPosts"]}");
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        var jsonList = dataObj["chatAllPosts"] as List;
        profImage.value = dataObj["profileImg"] != null
            ? dataObj["profileImg"] as String
            : "";
        communityAllPostsList.value =
            jsonList.map((e) => CommunityAllPostsModel.fromJson(e)).toList();
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

  Future<void> getAllCommentsApi({required int chatId}) async {
    try {
      // isCommentsLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        "${ApiUrls.getUserCommentsEndPoint}?id=$chatId",
        authToken: token,
      );
      log("${response.statusCode}body:${jsonDecode(response.body)["likesCommentModel"]}");
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        var jsonList = dataObj["likesCommentModel"] as List;
        userCommentsList.value =
            jsonList.map((e) => ListCommentors.fromJson(e)).toList();
        // isCommentsLoading.value = false;
      } else {
        // isCommentsLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "No record found");
      }
    } catch (e) {
      // isCommentsLoading.value = false;
      log("exception ${e.toString()}");
    }
  }

  Future<void> savePost({
    required int chatId,
    required bool isSaved,
  }) async {
    Map<String, dynamic> bodyData = {"chatId": chatId, "isSaved": isSaved};
    try {
      // isSavedLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.post(
        ApiUrls.savePostEndPoint,
        jsonEncode(bodyData),
        authToken: token,
      );

      if (response.statusCode == 200) {
        var dataObj = await jsonDecode(response.body);
        print(dataObj);
        customSnackbar(
            title: AppTexts.success, message: 'Post Saved successfully');
        getAllPostsApi();
        // isSavedLoading.value = false;
      } else {
        // isSavedLoading.value = false;
        customSnackbar(title: AppTexts.success, message: 'Post not Saved');
      }
    } catch (e) {
      // isSavedLoading.value = false;
      log(e.toString());
    }
  }

  Future<void> unSavePost({
    required int chatId,
    required int id,
  }) async {
    log("chatId : $chatId id: $id");
    Map<String, dynamic> bodyData = {
      "id": id,
      "chatId": chatId,
      "isSaved": "false"
    };
    try {
      // isSavedLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.patch(
        ApiUrls.savePostEndPoint,
        jsonEncode(bodyData),
        authToken: token,
      );
      log("${response.statusCode}body:${jsonDecode(response.body)}");
      if (response.statusCode == 200) {
        var dataObj = await jsonDecode(response.body);
        print(dataObj);
        customSnackbar(
            title: AppTexts.success, message: 'Post unSaved successfully');

        // isSavedLoading.value = false;
        getAllPostsApi();
      } else {
        // isSavedLoading.value = false;
        customSnackbar(title: AppTexts.error, message: 'Post not unSaved');
      }
    } catch (e) {
      // isSavedLoading.value = false;
      log(e.toString());
    }
  }

  Future<void> likePost({required int chatId, required bool isliked}) async {
    Map<String, dynamic> bodyData = {
      "chatId": chatId,
      "likes": isliked,
    };
    try {
      // isSavedLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.post(
        ApiUrls.likePostEndPoint,
        jsonEncode(bodyData),
        authToken: token,
      );
      log('this is like API status code ${response.statusCode}');
      if (response.statusCode == 200) {
        var dataObj = await jsonDecode(response.body);
        log('htiis object $dataObj');
        // isSavedLoading.value = false;
        getAllPostsApi();
      } else {
        // isSavedLoading.value = false;
      }
    } catch (e) {
      // isSavedLoading.value = false;
      log(e.toString());
    }
  }

  Future<void> postComment({
    required int chatId,
    required String comment,
  }) async {
    Map<String, dynamic> bodyData = {
      "chatId": chatId,
      "comment": comment.trim(),
    };
    try {
      isSavedCommentLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.post(
        ApiUrls.likePostEndPoint,
        jsonEncode(bodyData),
        authToken: token,
      );

      if (response.statusCode == 200) {
        // var dataObj = await jsonDecode(response.body);
        isSavedCommentLoading.value = false;
        commentController.clear();
        getAllCommentsApi(chatId: chatId);
      } else {
        isSavedCommentLoading.value = false;
      }
    } catch (e) {
      isSavedCommentLoading.value = false;
      log(e.toString());
    }
  }
}
