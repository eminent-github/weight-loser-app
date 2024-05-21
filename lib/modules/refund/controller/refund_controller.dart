import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class RefundController extends GetxController {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewSettings settings = InAppWebViewSettings(
      isInspectable: kDebugMode,
      mediaPlaybackRequiresUserGesture: false,
      clearCache: true,
      transparentBackground: true,
      allowsInlineMediaPlayback: true,
      iframeAllow: "camera; microphone",
      iframeAllowFullscreen: true);

  var progress = 0.0.obs;
  @override
  void onInit() {
    requestPermission();
    super.onInit();
  }

  void requestPermission() async {
    var status = await Permission.microphone.request();
    if (status.isGranted) {
      log("-------------------yes");
    } else {
      log("-------------------requested");
      await Permission.microphone.request();
    }
  }
}
