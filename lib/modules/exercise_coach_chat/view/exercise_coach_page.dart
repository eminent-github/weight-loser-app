import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/modules/exercise_coach_chat/controller/exercise_coach_controller.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import '../../../common/app_assets.dart';
import '../../../common/app_colors.dart';
import '../../../common/app_text_styles.dart';

class ExerciseCoachPage extends GetView<ExerciseCoachController> {
  const ExerciseCoachPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height - kToolbarHeight;
    double width = screenSize.width;
    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          iconTheme: Theme.of(context).iconTheme,
          elevation: 0,
          title: Text(
            'Exercise Coach',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
        ),
        body: InternetCheckWidget<ConnectivityService>(
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Obx(
                    () => controller.isLoading.value
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.buttonColor,
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.03,
                              vertical: height * 0.02,
                            ),
                            child: ListView.builder(
                              reverse: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: controller.myList.length,
                              itemBuilder: (context, index) {
                                final list =
                                    controller.myList.reversed.toList();
                                final userMessage = list[index];
                                return Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: height * 0.001,
                                      ),
                                      child: BubbleSpecialOne(
                                        text: userMessage.posterText!,
                                        color: AppColors.buttonColor,
                                        isSender: true,
                                        textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: AppTextStyles.fontFamily,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: height * 0.007,
                                      ),
                                      child: BubbleSpecialOne(
                                        text: userMessage.roboText == null
                                            ? "Server not responding..."
                                            : userMessage.roboText!,
                                        color: const Color.fromARGB(
                                            255, 245, 242, 242),
                                        isSender: false,
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: AppTextStyles.fontFamily,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                  ),
                ),
                Container(
                  width: width * 0.84,
                  height: 60,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(
                            5.0,
                            5.0,
                          ),
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                        ), //BoxShadow
                      ]),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: TextField(
                          cursorColor: AppColors.iconTextColor,
                          controller: controller.messageController,
                          style: AppTextStyles.formalTextStyle(
                            fontSize: 12,
                          ),
                          decoration: InputDecoration(
                            hintText: "Type a Message...",
                            hintStyle: AppTextStyles.formalTextStyle(
                              color: AppColors.iconTextColor,
                              fontSize: 12,
                            ),
                            contentPadding: EdgeInsets.only(left: width * 0.05),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Material(
                            shape: const CircleBorder(),
                            color: AppColors.white,
                            child: InkWell(
                              onTap: () {
                                if (controller
                                    .messageController.value.text.isNotEmpty) {
                                  if (!controller.isTextOnlySpaces(controller
                                      .messageController.value.text)) {
                                    controller.sendMessage(
                                        message: controller
                                            .messageController.value.text);
                                    controller.messageController.clear();
                                  }
                                }
                              },
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                height: height * 0.07,
                                width: width * 0.12,
                                decoration: BoxDecoration(
                                    color: AppColors.buttonColor,
                                    shape: BoxShape.circle),
                                child: Center(
                                  child: SvgPicture.asset(
                                    AppAssets.sendChatCoach,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
