import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weight_loss_app/modules/refund/controller/refund_controller.dart';

class RefundPage extends GetView<RefundController> {
  const RefundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1872F5),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Obx(
          () => Stack(
            children: [
              InAppWebView(
                key: controller.webViewKey,
                initialUrlRequest: URLRequest(
                    url: WebUri(
                        "https://go.crisp.chat/chat/embed/?website_id=40917beb-e013-4522-9a15-12b94b39a8bb")),
                initialSettings: controller.settings,
                onLoadStart: (wController, url) {},
                onPermissionRequest: (wController, request) async {
                  return PermissionResponse(
                      resources: request.resources,
                      action: PermissionResponseAction.GRANT);
                },
                shouldOverrideUrlLoading:
                    (wController, navigationAction) async {
                  var uri = navigationAction.request.url!;

                  if (![
                    "http",
                    "https",
                    "file",
                    "chrome",
                    "data",
                    "javascript",
                    "about"
                  ].contains(uri.scheme)) {
                    if (await canLaunchUrl(uri)) {
                      // Launch the App
                      await launchUrl(
                        uri,
                      );
                      // and cancel the request
                      return NavigationActionPolicy.CANCEL;
                    }
                  }

                  return NavigationActionPolicy.ALLOW;
                },
                onProgressChanged: (wController, progress) {
                  controller.progress.value = progress / 100;
                },
                onUpdateVisitedHistory: (wController, url, androidIsReload) {},
                onConsoleMessage: (wController, consoleMessage) {
                  if (kDebugMode) {
                    print(consoleMessage);
                  }
                },
              ),
              controller.progress.value < 1.0
                  ? Center(
                      child: CircularProgressIndicator(
                          value: controller.progress.value))
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
