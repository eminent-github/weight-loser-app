import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:weight_loss_app/modules/privacy_policy/controller/privacy_policy_controller.dart';

class PrivacyPolicyPage extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    // var screenSize = MediaQuery.sizeOf(context);
    // double height = screenSize.height;
    // double width = screenSize.width;
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => Stack(
            children: [
              WebViewWidget(controller: controller.webController),
              controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
