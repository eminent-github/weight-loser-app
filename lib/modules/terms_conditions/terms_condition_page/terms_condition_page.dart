import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:weight_loss_app/modules/terms_conditions/controller/terms_condition_controller.dart';

class TermsConditionPage extends GetView<TermsConditionController> {
  const TermsConditionPage({super.key});

  @override
  Widget build(BuildContext context) {
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
