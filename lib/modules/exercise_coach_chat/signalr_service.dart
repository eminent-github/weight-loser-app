// import 'dart:developer';

// import 'package:signalr_core/signalr_core.dart';
// import 'package:weight_loss_app/common/api_urls.dart';

// class SignalRService {
//   final hubConnection = HubConnectionBuilder()
//       .withUrl("${ApiUrls.baseUrl}/chat", HttpConnectionOptions())
//       .build();

//   Future<void> startConnection() async {
//     await hubConnection.start();
//     log('connection started');
//   }

//   void addMessageListener(Function(dynamic) onMessageReceived) {
//     hubConnection.on("SendTechnicalChatUser", onMessageReceived);
//   }

//   void getAllMessageListener(String token) {
//     hubConnection.invoke('GetAllTechnicalChat', args: [token]);
//   }

//   Future<void> sendMessage(String token, String message) async {
//     if (hubConnection.state == HubConnectionState.connected) {
//       await hubConnection.invoke("SendMessageToClient", args: [token, message]);
//     }
//   }

//   Future<void> stopConnection() async {
//     await hubConnection.stop();
//   }
// }
