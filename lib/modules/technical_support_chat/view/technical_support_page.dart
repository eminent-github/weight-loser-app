import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weight_loss_app/modules/technical_support_chat/controller/technical_support_controller.dart';
import 'package:weight_loss_app/modules/technical_support_chat/widgets/show_image_to_user.dart';
import 'package:weight_loss_app/utils/input_formatters.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';
import '../../../common/app_assets.dart';
import '../../../common/app_colors.dart';
import '../../../common/app_text_styles.dart';

class TechnicalSupportChatPage extends GetView<TechnicalSupportController> {
  const TechnicalSupportChatPage({super.key});

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
          // elevation: 0,
          title: Text(
            'Technical Support',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
        ),
        body: InternetCheckWidget<ConnectivityService>(
          child: Obx(
            () {
              return SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child:
                          //  controller.isLoading.value
                          //     ? Center(
                          //         child: CircularProgressIndicator(
                          //           color: AppColors.buttonColor,
                          //         ),
                          //       )
                          //     :
                          controller.listOfMessages.isEmpty
                              ? Center(
                                  child: Text(
                                    "How can I help you today?",
                                    style: AppTextStyles.formalTextStyle(
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .titleMedium!
                                          .color!,
                                    ),
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
                                    itemCount: controller.listOfMessages.length,
                                    itemBuilder: (context, index) {
                                      var list = controller
                                          .listOfMessages.reversed
                                          .toList();
                                      final message = list[index];
                                      final isUserOwnMessage =
                                          message.staffId == null;
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: isUserOwnMessage
                                              ? height * 0.001
                                              : height * 0.007,
                                        ),
                                        child: message.fileName!.isNotEmpty
                                            ? InkWell(
                                                onLongPress: () {
                                                  showDeleteConfirmationDialog(
                                                      context, message.id!);
                                                },
                                                child: BubbleNormalImage(
                                                  id: message.id.toString(),
                                                  tail: true,
                                                  image: LoadingImage(
                                                    imageUrl: message.fileName!,
                                                  ),
                                                  isSender: isUserOwnMessage
                                                      ? true
                                                      : false,
                                                  color: isUserOwnMessage
                                                      ? AppColors.buttonColor
                                                      : const Color.fromARGB(
                                                          255, 245, 242, 242),
                                                ),
                                              )
                                            : InkWell(
                                                onLongPress: () {
                                                  showDeleteConfirmationDialog(
                                                      context, message.id!);
                                                },
                                                child: BubbleSpecialOne(
                                                  text: message.text!,
                                                  color: isUserOwnMessage
                                                      ? AppColors.buttonColor
                                                      : const Color.fromARGB(
                                                          255, 245, 242, 242),
                                                  isSender: isUserOwnMessage
                                                      ? true
                                                      : false,
                                                  textStyle: TextStyle(
                                                    color: isUserOwnMessage
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontSize: 14,
                                                    fontFamily: AppTextStyles
                                                        .fontFamily,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                      );
                                    },
                                  ),
                                ),
                    ),
                    Container(
                      width: width,
                      height: height * 0.11,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(
                              3.0,
                              4.0,
                            ),
                            blurRadius: 9.0,
                            spreadRadius: 9.0,
                          ), //BoxShadow
                        ],
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: height * 0.07,
                              width: width * 0.75,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color(0xFFE4EDF1)),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: TextFormField(
                                      cursorColor: AppColors.iconTextColor,
                                      controller:
                                          controller.messageController.value,
                                      inputFormatters: [
                                        FirstCharacterNoSpaceFormatter()
                                      ],
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      style: AppTextStyles.formalTextStyle(
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "Type a Message...",
                                        alignLabelWithHint: true,
                                        hintStyle:
                                            AppTextStyles.formalTextStyle(
                                          color: AppColors.iconTextColor,
                                          fontSize: 12,
                                        ),
                                        contentPadding:
                                            EdgeInsets.only(left: width * 0.05),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: SizedBox(
                                        width: width * 0.1,
                                        height: height * 0.05,
                                        child: Material(
                                          color: Colors.transparent,
                                          shape: const CircleBorder(),
                                          child: InkWell(
                                            onTap: () async {
                                              await dialogForImagePicker(
                                                  context, width, height);
                                            },
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Center(
                                              child: SvgPicture.asset(
                                                AppAssets.paperClipCoach,
                                                color: const Color(0xff444343),
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
                            Padding(
                              padding: EdgeInsets.only(left: width * 0.015),
                              child: controller.isSeding.value
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.buttonColor,
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        if (!controller.isTextOnlySpaces(
                                            controller.messageController.value
                                                .text)) {
                                          controller.sendSupportMessage();
                                        }
                                      },
                                      child: SvgPicture.asset(
                                        AppAssets.sndTechnicalSvg,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> dialogForImagePicker(
      BuildContext context, double width, double height) async {
    await showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      context: context,
      pageBuilder: (dialogContext, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            child: SizedBox(
              width: width * 0.75,
              height: height * 0.25,
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    "Choose an Action",
                    style: AppTextStyles.formalTextStyle(
                      color: AppColors.buttonColor,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Divider(
                    color: AppColors.buttonColor,
                    thickness: 2,
                  ),
                  Expanded(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ListTile(
                          onTap: () async {
                            Navigator.pop(dialogContext);
                            bool isImageSelected =
                                await controller.getImage(ImageSource.gallery);
                            if (isImageSelected) {
                              await showBottomSheet(context);
                            }
                          },
                          leading: Icon(
                            Icons.photo_library_rounded,
                            color: AppColors.buttonColor,
                            size: 30,
                          ),
                          title: Text(
                            "Choose from Gallery",
                            style: AppTextStyles.formalTextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        ListTile(
                          onTap: () async {
                            Navigator.pop(dialogContext);
                            bool isImageSelected =
                                await controller.getImage(ImageSource.camera);
                            if (isImageSelected) {
                              await showBottomSheet(context);
                            }
                          },
                          leading: Icon(
                            Icons.camera_alt_rounded,
                            color: AppColors.buttonColor,
                            size: 30,
                          ),
                          title: Text(
                            "Capture from Camera",
                            style: AppTextStyles.formalTextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return ScaleTransition(
          scale: anim,
          child: child,
        );
      },
    );
  }

  Future<void> showBottomSheet(BuildContext context) async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bcontext) {
        return ShowImageToUser(
          controller: controller,
          bottomSheetContext: bcontext,
        );
      },
    );
  }

  void showDeleteConfirmationDialog(BuildContext context, num id) {
    showDialog(
      context: context,
      builder: (BuildContext innerContext) {
        return AlertDialog(
          title: Text(
            'Delete Message',
            style: AppTextStyles.formalTextStyle(
              color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
            ),
          ),
          content: Text(
            'Are you sure you want to delete this message?',
            style: AppTextStyles.formalTextStyle(
              color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(innerContext).pop();
                controller.deleteSupportMessage(id: id);
              },
              child: Text(
                'Yes',
                style: AppTextStyles.formalTextStyle(
                  color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(innerContext).pop();
              },
              child: Text(
                'No',
                style: AppTextStyles.formalTextStyle(
                  color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
