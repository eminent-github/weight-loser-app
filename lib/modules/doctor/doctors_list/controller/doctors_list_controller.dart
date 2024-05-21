import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/app_assets.dart';
import '../models/doctor_model.dart';

class DoctorsListController extends GetxController {
  final TextEditingController searhController = TextEditingController();
  @override
  void dispose() {
    searhController.dispose();
    super.dispose();
  }

  var filteredDoctorsList = <DoctorModel>[].obs;
  var searchQuery = ''.obs;
  List<DoctorModel> doctorsList = [
    DoctorModel(
        avialability: "Sat to Friday",
        imagUrl: AppAssets.doctorImgUrl,
        name: 'hamza',
        specialization: "Nutrition Specialist ",
        available: true),
    DoctorModel(
        avialability: "Sat to Friday",
        imagUrl: AppAssets.doctorImgUrl,
        name: 'faisal',
        specialization: "Nutrition Specialist ",
        available: true),
    DoctorModel(
        avialability: "Sat to Friday",
        imagUrl: AppAssets.doctorImgUrl,
        name: 'meharan',
        specialization: "Nutrition Specialist ",
        available: false),
    DoctorModel(
        avialability: "Sat to Friday",
        imagUrl: AppAssets.doctorImgUrl,
        name: 'gazi',
        specialization: "Nutrition Specialist ",
        available: false),
    DoctorModel(
        avialability: "Sat to Friday",
        imagUrl: AppAssets.doctorImgUrl,
        name: 'uzair',
        specialization: "Nutrition Specialist ",
        available: false),
  ];
  void filterSearchResults(String query) {
    if (query.isEmpty) {
      filteredDoctorsList.assignAll(doctorsList);
    } else {
      filteredDoctorsList.assignAll(
        doctorsList.where(
          (item) => item.name.toLowerCase().trim().contains(
                query.toLowerCase().trim(),
              ),
        ),
      );
      // update();
    }
  }

  @override
  void onInit() {
    filteredDoctorsList.assignAll(doctorsList);
    debounce(searchQuery, filterSearchResults,
        time: const Duration(milliseconds: 100));
    super.onInit();
  }
}
