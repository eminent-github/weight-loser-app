import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/widgets/custom_button_widget.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';
import '../controller/appearance_controller.dart';

class AppearancePage extends GetView<AppearanceController> {
  const AppearancePage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        title: Text(
          AppTexts.appearance,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.06,
            ),
            SizedBox(
              height: height * 0.25,
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.12),
                    child:  Text(
                      'Select Themes',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
                        fontSize: 12,
                        fontFamily: AppTextStyles.fontFamily,
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Center(
                    child: SizedBox(
                      height: height * 0.16,
                      width: width * 0.85,
                      child: GridView.builder(
                        itemCount: controller.themeList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1.1,
                          crossAxisCount: 3,
                        ),
                        itemBuilder: (context, index) {
                          return GetBuilder(
                            init: controller,
                            builder: (controller) {
                              return GestureDetector(
                                onTap: () {
                                  controller.toggleSelection(index);
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: height * 0.08,
                                      width: width * 0.16,
                                      decoration: BoxDecoration(
                                          color: controller.colorList[index],
                                          border: Border.all(
                                              color: AppColors.blackDim,
                                              width: height * 0.001),
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: Align(
                                          alignment: Alignment.topCenter,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              controller.items[index].isSelected
                                                  ? Icon(
                                                      Icons
                                                          .check_circle_rounded,
                                                      color:
                                                          AppColors.buttonColor,
                                                      size: height * 0.03,
                                                    )
                                                  : const SizedBox(),
                                            ],
                                          )),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Text(
                                      controller.items[index].name,
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.formalTextStyle(
                                        fontSize: 11,
                                        color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CustomButtonWidget(
              height: height * 0.05,
              width: width * 0.35,
              text: AppTexts.applyText,
              onPressed: () => controller.applyTheme(),
            ),
          ],
        ),
      ),
    );
  }
}
