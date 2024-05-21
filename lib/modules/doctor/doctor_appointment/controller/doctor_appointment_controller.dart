import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_assets.dart';

import '../models/day_night_model.dart';
import '../models/doc_contact_model.dart';

class DoctorAppointmentController extends GetxController {
  String? selectedDate;
  var isDayNight = 0.obs;
  var timeIndex = 0.obs;
  var paymentSelectionIndex = 0.obs;

  TextEditingController detialController = TextEditingController();

  List<DayNightModel> daytimeList = [
    DayNightModel(title: "MORNING", imageUrl: AppAssets.morningIconSvgUrl),
    DayNightModel(title: "EVENING", imageUrl: AppAssets.eveningIconSvgUrl),
  ];
  List<DocContactModel> docContactList = [
    DocContactModel(
      icon: Icons.call,
      title: "Voice Call",
      subTitle: "Can Make a Voice Call with Doctor",
      price: "10\$",
    ),
    DocContactModel(
      icon: Icons.chat_rounded,
      title: "Messaging",
      subTitle: "Can Messaging with Doctor",
      price: "10\$",
    ),
    DocContactModel(
      icon: Icons.video_call,
      title: "Video Call",
      subTitle: "Can Make a Video Call with Doctor",
      price: "100\$",
    ),
  ];
  List<String> timeList = [
    "09:00AM",
    "09:00AM",
    "09:00AM",
    "09:00AM",
    "09:00AM",
    "09:00AM",
  ];
}
