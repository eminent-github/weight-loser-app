import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppearanceController extends GetxController {
  // Rx<ThemeMode> currentTheme = ThemeMode.light.obs;

  // void toggleSelection(int index) {
  //   if (index == 2) {
  //     // If the fourth item is clicked, unselect all items
  //     for (var item in items) {
  //       item.isSelected = false;
  //     }
  //     themeList[2].isSelected = true;
  //     log('System Default Theme');
  //     Get.changeThemeMode(ThemeMode.system);
  //     update();
  //   } else if (index == 1) {
  //     for (var item in items) {
  //       item.isSelected = false;
  //     }
  //     themeList[1].isSelected = true;
  //     log('Dark Theme');
  //     Get.changeThemeMode(ThemeMode.dark);
  //     Get.changeTheme(ThemeData.dark());
  //     update();
  //   } else if (index == 0) {
  //     for (var item in items) {
  //       item.isSelected = false;
  //     }
  //     themeList[0].isSelected = true;
  //     log('Light Theme');
  //     Get.changeThemeMode(ThemeMode.light);
  //     Get.changeTheme(ThemeData.light());
  //     update();
  //   } else {
  //     themeList[2].isSelected = false;
  //     themeList[index].isSelected = !themeList[index].isSelected;
  //   }
  //   update();
  // }
  // Rx<ThemeMode> currentTheme = ThemeMode.light.obs;
  int selectedThemeIndex = 0;

  @override
  void onInit() {
    super.onInit();
    loadSelectedTheme();
  }

  // void toggleSelection(int index) {
  //   if (index == 0) {
  //     log('Light Theme');
  //     Get.changeThemeMode(ThemeMode.light);
  //   } else if (index == 1) {
  //     log('Dark Theme');
  //     Get.changeThemeMode(ThemeMode.dark);
  //   } else if (index == 2) {
  //     log('System Default Theme');
  //     Get.changeThemeMode(ThemeMode.system);
  //   }
  //   updateThemeItems(index);
  // }

  Future<void> loadSelectedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt('selectedThemeIndex');
    if (themeIndex != null) {
      selectedThemeIndex = themeIndex;
      toggleSelection(themeIndex);
    }
  }

  void toggleSelection(int index) {
    selectedThemeIndex = index;
    updateThemeItems(index);
  }

  void updateThemeItems(int selectedIndex) {
    for (var i = 0; i < themeList.length; i++) {
      themeList[i].isSelected = i == selectedIndex;
    }
    update();
  }

  void applyTheme() async {
    if (selectedThemeIndex == 0) {
      Get.changeThemeMode(ThemeMode.light);
    } else if (selectedThemeIndex == 1) {
      Get.changeThemeMode(ThemeMode.dark);
    } else if (selectedThemeIndex == 2) {
      Get.changeThemeMode(ThemeMode.system);
    }
    await saveSelectedTheme();
    Get.back();
  }

  Future<void> saveSelectedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedThemeIndex', selectedThemeIndex);
  }

  List<ThemeItem> get items => themeList;
  var themeList = <ThemeItem>[
    ThemeItem(name: "Light", isSelected: true),
    ThemeItem(name: "Dark", isSelected: false),
    ThemeItem(name: "System Default", isSelected: false),
  ].obs;
  List<Color> colorList = [
    Colors.white,
    const Color(0xff6A6A6A),
    const Color(0xffFAFAFA),
  ];
}

class ThemeItem {
  final String name;
  bool isSelected;

  ThemeItem({required this.name, required this.isSelected});
}
