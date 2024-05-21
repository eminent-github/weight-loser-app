import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCardController extends GetxController {
  late TextEditingController nameController;
  late TextEditingController cardNumberController;
  late TextEditingController expiryDateController;
  late TextEditingController cvvController;

  @override
  void onInit() {
    nameController = TextEditingController();
    cardNumberController = TextEditingController();
    expiryDateController = TextEditingController();
    cvvController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    nameController.dispose();
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    super.dispose();
  }
}
