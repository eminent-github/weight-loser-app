import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagingController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  List<String> messgesList = <String>[].obs;
  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
