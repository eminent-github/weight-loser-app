import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:weight_loss_app/common/app_colors.dart';

class TermsConditionController extends GetxController {
  late final WebViewController webController;
  var isLoading = true.obs;
  @override
  void onInit() {
    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse('https://www.weightloser.com/terms-and-conditions.php'),
      )
      ..setBackgroundColor(AppColors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Text('Loading...', style: AppTextStyles.formalTextStyle());
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            isLoading.value = false;
          },
        ),
      );
    super.onInit();
  }
}
