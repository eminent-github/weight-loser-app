import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/wl_communities/wl_community/model/wl_community_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class CommunityProfileController extends GetxController {
  RxBool isPressed = false.obs;
  RxString userName = "".obs;
  etUserName() async {
    userName.value = await StorageServivce.getUserName() ?? 'unknown';
  }

  @override
  void onInit() {
    etUserName();
    getAllPostsbyUserApi();
    super.onInit();
  }

  var communityAllPostsByUserList = <CommunityAllPostsModel>[].obs;
  var userCommentsList = <ListCommentors>[].obs;
  final TextEditingController commentController = TextEditingController();
  var isLoading = false.obs;
  var isSavedLoading = false.obs;
  var isCommentsLoading = false.obs;
  var isSavedCommentLoading = false.obs;
  final ApiService apiService = ApiService();
  Future<void> getAllPostsbyUserApi() async {
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        ApiUrls.communityAllPostsbyUserEndPoint,
        authToken: token,
      );
      log("status code : ${response.statusCode} body ${response.body}");
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        var jsonList = dataObj["chatAllPosts"] as List;
        communityAllPostsByUserList.value =
            jsonList.map((e) => CommunityAllPostsModel.fromJson(e)).toList();
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

  Future<void> getAllCommentsApi({required int chatId}) async {
    try {
      isCommentsLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        "${ApiUrls.getUserCommentsEndPoint}?id=$chatId",
        authToken: token,
      );
      log("${response.statusCode}body:${jsonDecode(response.body)["chatAllPosts"]}");
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        var jsonList = dataObj["likesCommentModel"] as List;
        userCommentsList.value =
            jsonList.map((e) => ListCommentors.fromJson(e)).toList();
        isCommentsLoading.value = false;
      } else {
        isCommentsLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "No record found");
      }
    } catch (e) {
      isCommentsLoading.value = false;
      log("exception ${e.toString()}");
    }
  }

  Future<void> savePost({
    required int chatId,
  }) async {
    Map<String, dynamic> bodyData = {"chatId": chatId, "isSaved": "true"};
    try {
      isSavedLoading.value = true;
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
        isSavedLoading.value = false;
      } else {
        isSavedLoading.value = false;
        customSnackbar(title: AppTexts.success, message: 'Post not Saved');
      }
    } catch (e) {
      isSavedLoading.value = false;
      log(e.toString());
    }
  }

  Future<void> likePost({required int chatId, required bool isliked}) async {
    Map<String, dynamic> bodyData = {
      "chatId": chatId,
      "likes": isliked,
    };
    try {
      isSavedLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.post(
        ApiUrls.likePostEndPoint,
        jsonEncode(bodyData),
        authToken: token,
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var dataObj = await jsonDecode(response.body);
        print(dataObj);
        isSavedLoading.value = false;
        getAllPostsbyUserApi();
      } else {
        isSavedLoading.value = false;
      }
    } catch (e) {
      isSavedLoading.value = false;
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

  Future<void> deletePost({
    required int chatId,
  }) async {
    try {
      isSavedLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.delete(
        "${ApiUrls.deletePostEndPoint}/$chatId",
        authToken: token,
      );

      if (response.statusCode == 200) {
        // var dataObj = await jsonDecode(response.body);
        isSavedLoading.value = false;
        customSnackbar(
            title: AppTexts.success, message: 'Post deleted successfully');
        getAllPostsbyUserApi();
      } else {
        isSavedLoading.value = false;
        customSnackbar(title: AppTexts.success, message: 'Post not deleted');
      }
    } catch (e) {
      isSavedLoading.value = false;
      log(e.toString());
    }
  }
}
