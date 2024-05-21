import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/modules/exercise_coach_chat/model/send_technical_chat_model.dart';
import 'package:weight_loss_app/utils/shared_prefrence.dart';

class ExerciseCoachController extends GetxController {
  late HubConnection _hubConnection;
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    _initSignalR();
  }

  final TextEditingController messageController = TextEditingController();

  RxList<SendTechnicalChatModel> myList = <SendTechnicalChatModel>[].obs;

  Future<void> _initSignalR() async {
    try {
      isLoading.value = true;
      const hubUrl = '${ApiUrls.baseUrl}/chat';

      _hubConnection = HubConnectionBuilder()
          .withUrl(
            hubUrl,
          )
          .build();
      await _hubConnection.start();
      await getAllMessageListener();
      _hubConnection.on('SendTechnicalChatUser', _handleReceivedMessage);
      isLoading.value = false;
      log('SignalR connection started');
    } catch (e) {
      log('Error starting SignalR connection: $e');
    }
  }

  void _handleReceivedMessage(dynamic parameters) {
    List<dynamic> receivedData = parameters;

    // for (var messageList in receivedData) {
    if (myList.isEmpty) {
      if (receivedData[0] is List) {
        for (var messageMap in receivedData[0]) {
          if (messageMap is Map<String, dynamic>) {
            var technicalChatModel =
                SendTechnicalChatModel.fromJson(messageMap);

            myList.add(technicalChatModel);
          } else {
            log('Invalid message format: $messageMap');
          }
        }
        // log("${myList.map((element) => element.userName).toList()} $parameters");
      } else {
        log('Invalid message format: $receivedData[0]');
      }
    } else if (receivedData.length > myList.length) {
      myList.add(receivedData[receivedData.length - 1]);
    } else {
      if (receivedData[0] is List) {
        for (var messageMap in receivedData[0]) {
          if (messageMap is Map<String, dynamic>) {
            var technicalChatModel =
                SendTechnicalChatModel.fromJson(messageMap);

            myList.add(technicalChatModel);
          } else {
            log('Invalid message format: $messageMap');
          }
        }
        // log("${myList.map((element) => element.userName).toList()} $parameters");
      } else {
        log('Invalid message format: $receivedData[0]');
      }
    }
    // }
  }

  bool isTextOnlySpaces(String text) {
    return text.trim().isEmpty;
  }

  Future getAllMessageListener() async {
    try {
      String? token = await StorageServivce.getToken();
      // I have used static token that Mehran has provided me. My user's token did not have any data to see how it is working.
      // we must replace the token below with the token from shared preferences.
      await _hubConnection.invoke('GetAllTechnicalChat', args: [
        "$token"
      ]).onError((error, stackTrace) => log('error: $error'));
    } catch (e) {
      log('Error GetAllTechnicalChat: ${e.toString()}');
    }
  }

  Future<void> sendMessage({required String message}) async {
    try {
      String? token = await StorageServivce.getToken();

      const methodName = 'SendMessageToClient';

      await _hubConnection.invoke(methodName, args: [
        {'Token': token, 'Message': message}
      ]).onError((error, stackTrace) => log('error: $error'));
      log('Message sent: $message');
    } catch (e) {
      log('Error sending message: $e');
    }
  }

  @override
  void onClose() {
    super.onClose();
    messageController.dispose();
    _hubConnection.stop();
    log('onClose triggered');
  }
}
