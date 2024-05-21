import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/technical_support_chat/model/get_messages_model.dart';
import 'package:weight_loss_app/utils/api_service.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';

class TechnicalSupportController extends GetxController {
  String? loginToken;
  bool? isFromLogin;
  getBindData({String? t, required bool i}) {
    loginToken = t;
    isFromLogin = i;
  }

  @override
  void onInit() {
    getMessagesFromSupport();
    super.onInit();
  }

  final Rx<TextEditingController> messageController =
      TextEditingController().obs;
  @override
  void dispose() {
    messageController.value.dispose();
    super.dispose();
  }

  bool isInputEmpty = true;

  var isLoading = false.obs;
  var isSeding = false.obs;
  var isImageSeding = false.obs;
  final ApiService apiService = ApiService();

  var listOfMessages = <TechnicalSupportChatList>[].obs;

  getMessagesFromSupport() async {
    try {
      // isLoading.value = true;
      String? token =
          isFromLogin! ? loginToken : await StorageServivce.getToken();
      log("token$token");
      var response = await apiService.get(
        ApiUrls.getChatForTechnicalSupportEndPoint,
        authToken: token,
      );
      log("${response.statusCode}${jsonDecode(response.body)}");
      if (response.statusCode == 200) {
        var dataObj = jsonDecode(response.body);

        var data = GetMessageModelForTechnicalSupport.fromJson(dataObj);
        listOfMessages.value = data.technicalSupportChatList != null
            ? data.technicalSupportChatList!
            : [];
        log(dataObj.toString());

        // isLoading.value = false;
      } else {
        // isLoading.value = false;
        customSnackbar(title: AppTexts.error, message: "No messages found");
      }
    } catch (e) {
      // isLoading.value = false;
      log(e.toString());
    }
  }

  bool isTextOnlySpaces(String text) {
    return text.trim().isEmpty;
  }

  sendSupportMessage() async {
    isSeding.value = true;
    Map<String, dynamic> bodyData = {
      "text": messageController.value.text.trim(),
    };
    try {
      String? token =
          isFromLogin! ? loginToken : await StorageServivce.getToken();
      var response = await apiService.post(
        ApiUrls.sendMessageForTechnicalSupportEndPoint,
        jsonEncode(bodyData),
        authToken: token,
      );
      var dataObj = await jsonDecode(response.body);
      log("$dataObj${response.statusCode}");
      if (response.statusCode == 200) {
        await getMessagesFromSupport();
        isSeding.value = false;
        imagePath.value = '';
        messageController.value.clear();
      } else {
        isSeding.value = false;
        messageController.value.clear();
        customSnackbar(title: AppTexts.success, message: 'Message is not sent');
      }
    } catch (e) {
      isSeding.value = false;
      messageController.value.clear();
      log(e.toString());
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

  Future<void> postImageOrVideoApi(
      BuildContext bottomSheetContext, String type, File myimageFile) async {
    try {
      isImageSeding.value = true;
      String? token =
          isFromLogin! ? loginToken : await StorageServivce.getToken();
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
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        Map<String, dynamic> jsonData = jsonDecode(responseBody);
        String postedImage = jsonData["fileName"] as String;
        sendSupportImage(bottomSheetContext, image: postedImage);
      } else {
        isImageSeding.value = false;
        customSnackbar(title: AppTexts.success, message: 'Image not posted');
      }
    } catch (e) {
      isImageSeding.value = false;
      log(e.toString());
    }
  }

  sendSupportImage(BuildContext bottomSheetContext,
      {required String image}) async {
    Map<String, dynamic> bodyData = {
      "text": messageController.value.text,
      "fileName": image,
    };
    try {
      String? token =
          isFromLogin! ? loginToken : await StorageServivce.getToken();
      var response = await apiService.post(
        ApiUrls.sendMessageForTechnicalSupportEndPoint,
        jsonEncode(bodyData),
        authToken: token,
      );
      var dataObj = await jsonDecode(response.body);
      log("$dataObj${response.statusCode}");
      if (response.statusCode == 200) {
        isImageSeding.value = false;
        Navigator.pop(bottomSheetContext);
        imagePath.value = '';
        await getMessagesFromSupport();
      } else {
        isImageSeding.value = false;
        customSnackbar(title: AppTexts.success, message: 'Message is not sent');
      }
    } catch (e) {
      isImageSeding.value = false;

      log(e.toString());
    }
  }

  deleteSupportMessage({required num id}) async {
    isSeding.value = true;

    try {
      String? token =
          isFromLogin! ? loginToken : await StorageServivce.getToken();
      var response = await apiService.delete(
        "${ApiUrls.sendMessageForTechnicalSupportEndPoint}/$id",
        authToken: token,
      );
      var dataObj = await jsonDecode(response.body);
      log("$dataObj${response.statusCode}");
      if (response.statusCode == 200) {
        await getMessagesFromSupport();
        isSeding.value = false;
      } else {
        isSeding.value = false;
        customSnackbar(title: AppTexts.success, message: 'Message not Deleted');
      }
    } catch (e) {
      isSeding.value = false;
      log(e.toString());
    }
  }
}
