import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/wl_communities/wl_community/model/wl_community_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class WlSavedController extends GetxController {
  var isLoading = false.obs;
  var isSavedLoading = false.obs;
  final ApiService apiService = ApiService();
  var communitySavedPostsList = <CommunityAllPostsModel>[].obs;
  var distinctPosts = <CommunityAllPostsModel>[].obs;
  @override
  void onInit() {
    getSavedPostsApi();
    super.onInit();
  }

  Future<void> getSavedPostsApi() async {
    try {
      isLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.get(
        ApiUrls.communitySavedPostsEndPoint,
        authToken: token,
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);
        var jsonList = dataObj["chatAllPosts"] as List;
        distinctPosts.value =
            jsonList.map((e) => CommunityAllPostsModel.fromJson(e)).toList();
        communitySavedPostsList.value = distinctPosts.toSet().toList();

        log('These are all saved posts ${communitySavedPostsList.map((post) => CommunityAllPostsModel(
              chatPoster: post.chatPoster,
              totalLikes: post.totalLikes,
              totlalComments: post.totlalComments,
              isLikedByUser: post.isLikedByUser,
              isSavedByUser: post.isSavedByUser,
            )).toList()}\n');

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
      isSavedLoading.value = true;
      String? token = await StorageServivce.getToken();
      var response = await apiService.patch(
        ApiUrls.savePostEndPoint,
        jsonEncode(bodyData),
        authToken: token,
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var dataObj = await jsonDecode(response.body);
        print(dataObj);
        customSnackbar(
            title: AppTexts.success, message: 'Post unSaved successfully');
        getSavedPostsApi();
        isSavedLoading.value = false;
      } else {
        isSavedLoading.value = false;
        customSnackbar(title: AppTexts.error, message: 'Post not unSaved');
      }
    } catch (e) {
      isSavedLoading.value = false;
      log(e.toString());
    }
  }
}
