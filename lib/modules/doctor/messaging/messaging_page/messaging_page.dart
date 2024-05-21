import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/doctor/messaging/controller/messaging_controller.dart';

class MessagingPage extends GetView<MessagingController> {
  const MessagingPage({super.key});

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
          backgroundColor: AppColors.white,
          iconTheme: const IconThemeData.fallback(),
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Dr. Jaime M. Mercado',
                style: AppTextStyles.formalTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                width: width * 0.02,
              ),
              Container(
                width: 6.39,
                height: 6.39,
                decoration: BoxDecoration(
                  color: AppColors.onlineColor,
                  border: Border.all(width: 0.46, color: Colors.yellow),
                  shape: BoxShape.circle,
                ),
              ),
              Text(
                ' Online',
                style: AppTextStyles.formalTextStyle(
                  color: AppColors.onlineColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              )
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Obx(
                  () => Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                    child: ListView.builder(
                      reverse: true,
                      itemCount: controller.messgesList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 40.18,
                          padding: const EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(vertical: height * 0.02),
                          decoration: const ShapeDecoration(
                            color: Color(0xFF146C94),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.96),
                                topRight: Radius.circular(10.96),
                                bottomRight: Radius.circular(10.96),
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              controller.messgesList[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11.87,
                                fontFamily: 'Mulish',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
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
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side:
                        const BorderSide(width: 0.8, color: Color(0xFFD1EFFF)),
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: TextField(
                        controller: controller.messageController,
                        style: AppTextStyles.formalTextStyle(
                          fontSize: 12,
                        ),
                        decoration: InputDecoration(
                          hintText: "Type Something . . . !",
                          hintStyle: AppTextStyles.formalTextStyle(
                            color: const Color(0xFFA5BECC),
                            fontSize: 12,
                          ),
                          contentPadding: EdgeInsets.only(left: width * 0.05),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width * 0.07,
                            height: height * 0.04,
                            child: Material(
                              shape: const CircleBorder(),
                              color: AppColors.white,
                              child: InkWell(
                                onTap: () {
                                  controller.messageController.clear();
                                },
                                borderRadius: BorderRadius.circular(50),
                                child: Center(
                                  child: SvgPicture.asset(
                                      AppAssets.inChatLinkSvgUrl),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.07,
                            height: height * 0.04,
                            child: Material(
                              shape: const CircleBorder(),
                              color: AppColors.white,
                              child: InkWell(
                                onTap: () {
                                  controller.messgesList
                                      .add(controller.messageController.text);
                                  controller.messageController.clear();
                                },
                                borderRadius: BorderRadius.circular(50),
                                child: Center(
                                  child: SvgPicture.asset(
                                      AppAssets.inChatSendSvgUrl),
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
            ],
          ),
        ),
      ),
    );
  }
}
