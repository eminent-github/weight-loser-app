import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

import '../../../../../common/app_text_styles.dart';
import '../controller/grocery_controller.dart';
import '../widgets/loaded_widget.dart';

class GroceryPage extends StatelessWidget {
  GroceryPage({super.key});
  final GroceryController controller = Get.put(GroceryController());
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Grocery',
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
                      height: height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(6),
                              onTap: () {
                                controller.currentIndex.value =
                                    (controller.currentIndex.value - 1) %
                                        controller.queryList.length;
                                controller.getGroceryApi(controller
                                    .queryList[controller.currentIndex.value]);
                              },
                              child: Container(
                                height: height * 0.04,
                                width: width * 0.08,
                                decoration: BoxDecoration(
                                  color: AppColors.buttonColor,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: AppColors.white,
                                  size: 13,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.01,
                            ),
                            Container(
                              height: height * 0.04,
                              width: width * 0.2,
                              decoration: BoxDecoration(
                                color: AppColors.buttonColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                child: Text(
                                  controller
                                      .queryList[controller.currentIndex.value],
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.formalTextStyle(
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.01,
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(6),
                              onTap: () {
                                controller.currentIndex.value =
                                    (controller.currentIndex.value + 1) %
                                        controller.queryList.length;
                                controller.getGroceryApi(controller
                                    .queryList[controller.currentIndex.value]);
                              },
                              child: Container(
                                height: height * 0.04,
                                width: width * 0.08,
                                decoration: BoxDecoration(
                                  color: AppColors.buttonColor,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: AppColors.white,
                                  size: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: controller.isLoading.value
                          ? Center(
                              child: CircularProgressIndicator(
                                color: AppColors.buttonColor,
                              ),
                            )
                          : UserGroceryLoadedUI(
                              userGroceryModel:
                                  controller.userGroceryModel.value,
                            ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                  ],
                ),
              ),
              controller.isPurchasedLoading.value
                  ? const OverlayWidget()
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
