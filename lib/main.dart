import 'dart:developer';
import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/notification_service.dart';
import 'package:weight_loss_app/controllers/purchase_api_controller.dart';
import 'package:weight_loss_app/local_db/notification_db.dart';
import 'package:weight_loss_app/modules/setting/notifications/model/notification_model.dart';
import 'package:weight_loss_app/theming/app_theme.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';

import 'common/app_texts.dart';
import 'modules/splash/splash_page/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey =
      'pk_test_51On2EbDQ0SCp7bRiOQ0LBiyl1cpqnkgiSoBGwLdzd0GFLcJfKp5Rx1H7tldKAu0AjkjRh5aL2is0nmnp6J8jESeX001BbBZGEE';
  Stripe.merchantIdentifier = 'any string works';

  if (Platform.isAndroid) {
    Stripe.publishableKey =
        'pk_live_51On2EbDQ0SCp7bRigIgqutDNUMHi9TO5LURriOlvHVN1HoLMHmzYHDIoVAn4YQTc0UPfS2qnfDOYx3Yr1E9iXYQm00gvCgWav6';
    await Stripe.instance.applySettings();
  }

  await Firebase.initializeApp();
  await GetStorage.init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: AppColors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final prefs = await SharedPreferences.getInstance();
  if (Platform.isAndroid) {
    await Permission.notification.request();
    await AndroidAlarmManager.initialize();
    await AndroidAlarmManager.periodic(
      const Duration(minutes: 1),
      1,
      getNotiReminder,
      allowWhileIdle: true,
      exact: true,
      wakeup: true,
      rescheduleOnReboot: true,
    );
  }
  runApp(MyApp(
    selectedThemeIndex: prefs.getInt('selectedThemeIndex') ?? 0,
  ));
}

@pragma('vm:entry-point')
getNotiReminder() async {
  List<ReminderNotifyModel> reminderNotifyList =
      await RemNotifyDBProvider().fetchReminderList();
  // print(reminderNotifyList.length);

  for (var reminderNotifyModel in reminderNotifyList) {
    // print(TimeOfDay.now() == parseTimeFromString(reminderNotifyModel.time));
    // print(parseTimeFromString(reminderNotifyModel.time));
    if (TimeOfDay.now() == parseTimeFromString(reminderNotifyModel.time)) {
      // print(
      //     "true ${reminderNotifyModel.name} is on : ${reminderNotifyModel.isOn}");
      if (reminderNotifyModel.isOn == 1) {
        // print("Notify");
        if (reminderNotifyModel.name == "Sleep") {
          NotificationService()
              .scheduleSleepNotification(reminderNotifyModel.time);
        } else {
          NotificationService().scheduleNotification(reminderNotifyModel.name);
        }
      }
      return;
    }
  }
}

TimeOfDay parseTimeFromString(String timeString) {
  try {
    // Split the string by colon
    final parts =
        timeString.substring(0, timeString.length == 7 ? 4 : 5).split(':');

    // Extract hour and minute
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);

    // Check if PM and adjust hour for 24-hour format
    if (timeString.toUpperCase().contains('PM')) {
      hour = hour == 12 ? 12 : hour + 12;
    }
    // log("hour : $hour Minute : $minute");
    // print('dinner: ${DateTime(date.year, date.month, date.day, hour, minute)}');
    return TimeOfDay(hour: hour, minute: minute);
  } catch (e) {
    // Handle parsing error
    // print('Error parsing time string: $e');
    return TimeOfDay.now();
  }
}
// DateTime parseTimeFromString(String timeString) {
//   var date = DateTime.now();
//   try {
//     // Split the string by colon
//     final parts =
//         timeString.substring(0, timeString.length == 7 ? 4 : 5).split(':');
//     // Extract hour and minute
//     int hour = int.parse(parts[0]);
//     int minute = int.parse(parts[1]);
//     // Check if PM and adjust hour for 24-hour format
//     if (timeString.toUpperCase().contains('PM')) {
//       hour = hour == 12 ? 12 : hour + 12;
//     }
//     // log("hour : $hour Minute : $minute");
//     print('dinner: ${DateTime(date.year, date.month, date.day, hour, minute)}');
//     return DateTime(date.year, date.month, date.day, hour, minute);
//   } catch (e) {
//     // Handle parsing error
//     print('Error parsing time string: $e');
//     return DateTime(date.year, date.month, date.day, 18, 30);
//   }
// }

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.selectedThemeIndex});
  final int selectedThemeIndex;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode selectedTheme() {
    if (widget.selectedThemeIndex == 0) {
      return ThemeMode.light;
    } else if (widget.selectedThemeIndex == 1) {
      return ThemeMode.dark;
    } else if (widget.selectedThemeIndex == 2) {
      return ThemeMode.system;
    }
    return ThemeMode.system;
  }

  var purchaseApiController = Get.put(PurchaseApiController(), permanent: true);

  @override
  void initState() {
    purchaseApiController.init();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (purchaseApiController.isWeeklyPurchased.value) {
        log("user is premium with weekly plan");
      } else if (purchaseApiController.isOtherPurchased.value) {
        log("user is premium with other plan");
      } else {
        log("user is not premium");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppTexts.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: selectedTheme(),
      defaultTransition: Transition.rightToLeft,
      home: const SplashPage(),
      initialBinding: BindingsBuilder(() {
        Get.lazyPut<ConnectivityService>(
          () => ConnectivityService(),
          fenix: true,
        );
      }),
    );
  }
}
