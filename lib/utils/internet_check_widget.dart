import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/modules/not_found_wifi/not_found_wifi_page.dart';

class InternetCheckWidget<T extends GetxController> extends StatelessWidget {
  final Widget child;

  const InternetCheckWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final connectivityService = Get.find<ConnectivityService>();
      if (!connectivityService.hasInternet.value) {
        return const NotFoundWifiPage(
          isFromSplash: false,
        );
      } else {
        return child;
      }
    });
  }
}

class ConnectivityService extends GetxController {
  var hasInternet = true.obs;
  late StreamSubscription subscription;
  @override
  void onInit() {
    super.onInit();
    checkInternetConnectivity();
    listenToConnectivityChanges();
  }

  @override
  dispose() {
    subscription.cancel();
    super.dispose();
  }

  Future<void> checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    hasInternet.value = (connectivityResult != ConnectivityResult.none);
  }

  ///
  ///
  /* -------------------------------------------------------------------------- */
  /*                      update connectivity_plus: ^6.0.3                      */
  /* -------------------------------------------------------------------------- */
  ///
  ///

  void listenToConnectivityChanges() {
    subscription = Connectivity().onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        hasInternet.value = (result != ConnectivityResult.none);
      }
    });
  }
  // subscription = Connectivity()
  //     .onConnectivityChanged
  //     .listen((ConnectivityResult result) {
  //   hasInternet.value = (result != ConnectivityResult.none);
  // });
}
