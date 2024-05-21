import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/modules/technical_support_chat/controller/technical_support_controller.dart';

class ShowImageToUser extends StatelessWidget {
  const ShowImageToUser({
    super.key,
    required this.controller,
    required this.bottomSheetContext,
  });
  final TechnicalSupportController controller;
  final BuildContext bottomSheetContext;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Obx(
      () => Container(
        height: height * 0.4,
        width: width,
        decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                child: SizedBox(
                  height: height * 0.27,
                  child: Obx(
                    () {
                      final imagePath = controller.imagePath.value;
                      return imagePath.isEmpty
                          ? const Center(
                              child: Text('No image selected'),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(imagePath),
                                fit: BoxFit.fill,
                              ),
                            );
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: width * 0.1),
                    child: controller.isImageSeding.value
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.buttonColor,
                            ),
                          )
                        : InkWell(
                            onTap: () async {
                              log(controller.imagePath.value);
                              if (controller.imagePath.value.isNotEmpty) {
                                await controller.postImageOrVideoApi(
                                    bottomSheetContext,
                                    "image",
                                    File(controller.imagePath.value));
                              }
                            },
                            child: SvgPicture.asset(
                              AppAssets.sndTechnicalSvg,
                            ),
                          ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
