import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/modules/setting/delete_reason/binding/delete_reason_binding.dart';
import 'package:weight_loss_app/modules/setting/delete_reason/delete_reason_page/delete_reason_page.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';
import '../controller/account_controller.dart';

class AccountPage extends GetView<AccountController> {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        title: Text(
          AppTexts.account,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: InternetCheckWidget<ConnectivityService>(
        child: Obx(
          () => Stack(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.1,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.075),
                      child: Row(
                        children: [
                          Text(
                            AppTexts.linkAccount,
                            style: TextStyle(
                              fontFamily: AppTextStyles.fontFamily,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium!
                                  .color!,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.003,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: width * 0.075),
                        child: AutoSizeText(
                          "You are signed in as ${controller.userEmail.value}",
                          minFontSize: 5,
                          maxLines: 1,
                          style: const TextStyle(
                            fontFamily: AppTextStyles.fontFamily,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.045),
                      child: ListTile(
                        onTap: () {
                          Get.to(() => const DeleteReasonPage(),
                              binding: DeleteReasonBinding());
                        },
                        title: const Text(
                          AppTexts.deleteyourAccount,
                          style: TextStyle(
                            fontFamily: AppTextStyles.fontFamily,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.red,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.red,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.075),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.power_settings_new,
                            size: 26,
                            color: AppColors.blue,
                          ),
                          TextButton(
                            onPressed: () async {
                              controller.logoutAccount();
                            },
                            child: const Text(
                              AppTexts.logOut,
                              style: TextStyle(
                                fontFamily: AppTextStyles.fontFamily,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: AppColors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              controller.isLoading.value
                  ? const Center(
                      child: OverlayWidget(),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
