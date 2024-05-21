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

class WlStatusDetailController extends GetxController {
  var isCommentsLoading = false.obs;
  var isSavedDetialLoading = false.obs;
  var isSavedCommentLoading = false.obs;
  int? saveChatId;

  void getsaveChatId(int bsaveChatId) {
    print("bsave $bsaveChatId");
    saveChatId = bsaveChatId;
  }

  @override
  void onInit() {
    getAllCommentsApi(chatId: saveChatId!);
    getSavedDetailApi(saveId: saveChatId!);

    super.onInit();
  }

  final ApiService apiService = ApiService();
  final TextEditingController commentController = TextEditingController();
  var userCommentsList = <ListCommentors>[].obs;
  var communitySavedPostsModel = CommunityAllPostsModel().obs;

  Future<void> postComment({
    required int chatId,
    required String comment,
  }) async {
    Map<String, dynamic> bodyData = {
      "chatId": chatId,
      "comment": comment,
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
        customSnackbar(title: AppTexts.success, message: 'Posted successfully');
        commentController.clear();
        getAllCommentsApi(chatId: chatId);
        isSavedCommentLoading.value = false;
      } else {
        isSavedCommentLoading.value = false;
      }
    } catch (e) {
      isSavedCommentLoading.value = false;
      log(e.toString());
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

  Future<void> getSavedDetailApi({required int saveId}) async {
    try {
      isSavedDetialLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        "${ApiUrls.getSavedDetialEndPoint}$saveId",
        authToken: token,
      );
      log("${response.statusCode}body:${jsonDecode(response.body)}");
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        var jsonData = dataObj["chatPosts"];
        communitySavedPostsModel.value =
            CommunityAllPostsModel.fromJson(jsonData);
        isSavedDetialLoading.value = false;
      } else {
        isSavedDetialLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "No record found");
      }
    } catch (e) {
      isSavedDetialLoading.value = false;
      log("exception ${e.toString()}");
    }
  }

  Future<void> likePost({required int chatId, required bool isliked}) async {
    print(isliked);
    Map<String, dynamic> bodyData = {
      "chatId": chatId,
      "likes": isliked,
    };
    try {
      isSavedCommentLoading.value = true;
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
        isSavedCommentLoading.value = false;
        getSavedDetailApi(saveId: saveChatId!);
      } else {
        isSavedCommentLoading.value = false;
      }
    } catch (e) {
      isSavedCommentLoading.value = false;
      log(e.toString());
    }
  }
}
