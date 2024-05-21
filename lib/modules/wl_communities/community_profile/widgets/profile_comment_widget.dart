import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/wl_communities/community_profile/controller/community_profile_controller.dart';
import 'package:weight_loss_app/utils/input_formatters.dart';
import 'package:weight_loss_app/widgets/custom_snackbar.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';

class ProfileCommentWidget extends StatefulWidget {
  const ProfileCommentWidget({super.key, required this.chatId});

  final int chatId;

  @override
  State<ProfileCommentWidget> createState() => _ProfileCommentWidgetState();
}

class _ProfileCommentWidgetState extends State<ProfileCommentWidget> {
  final controller = Get.find<CommunityProfileController>();

  @override
  void initState() {
    controller.getAllCommentsApi(chatId: widget.chatId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;

    return Obx(
      () => Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
              height: height * 0.8,
              child: Column(
                children: [
                  Expanded(
                    child: controller.isCommentsLoading.value
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.buttonColor,
                            ),
                          )
                        : controller.userCommentsList.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.forum_outlined,
                                      color: Color(0xffE5E7EB),
                                      size: 100,
                                    ),
                                    Text(
                                      "No Comments Yet",
                                      style: AppTextStyles.formalTextStyle(
                                        color: const Color(0xff929193),
                                      ),
                                    ),
                                    Text(
                                      "Be the first to comment",
                                      style: AppTextStyles.formalTextStyle(
                                        fontSize: 12,
                                        color: const Color(0xff929193),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                itemCount: controller.userCommentsList.length,
                                reverse: true,
                                itemBuilder: (context, index) {
                                  var list = controller
                                      .userCommentsList.reversed
                                      .toList();
                                  var comment = list[index];
                                  return comment.comment == null
                                      ? const SizedBox()
                                      : Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: height * 0.01,
                                              horizontal: width * 0.05),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width * 0.05,
                                                vertical: height * 0.01),
                                            clipBehavior: Clip.antiAlias,
                                            decoration: const ShapeDecoration(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                              ),
                                              shadows: [
                                                BoxShadow(
                                                  color: Color(0x0C515151),
                                                  blurRadius: 120,
                                                  offset: Offset(0, 0),
                                                  spreadRadius: 0,
                                                )
                                              ],
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        comment.imgPath == null
                                                            ? const CircleAvatar(
                                                                backgroundColor:
                                                                    Color(
                                                                        0xffE5E7EB),
                                                                child: Icon(
                                                                  Icons.person,
                                                                  color:
                                                                      AppColors
                                                                          .white,
                                                                ),
                                                              )
                                                            : CircleAvatar(
                                                                backgroundColor:
                                                                    const Color(
                                                                        0xffE5E7EB),
                                                                backgroundImage:
                                                                    NetworkImage(ApiUrls
                                                                            .imageBaseUrl +
                                                                        comment
                                                                            .imgPath!),
                                                              ),
                                                        Positioned(
                                                          right: 0,
                                                          bottom: 0,
                                                          child: Container(
                                                            width: 9.23,
                                                            height: 9.23,
                                                            decoration:
                                                                ShapeDecoration(
                                                              color: comment
                                                                      .isActive!
                                                                  ? const Color(
                                                                      0xFF44B461)
                                                                  : const Color(
                                                                      0xffE5E7EB),
                                                              shape:
                                                                  const OvalBorder(
                                                                side: BorderSide(
                                                                    width: 1.54,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.03,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: width * 0.015),
                                                      child: Text(
                                                        comment.name.toString(),
                                                        style: const TextStyle(
                                                          color: AppColors
                                                              .profileWlColorText,
                                                          fontSize: 12,
                                                          fontFamily:
                                                              AppTextStyles
                                                                  .fontFamily,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          letterSpacing: -0.12,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  comment.comment.toString(),
                                                  style: const TextStyle(
                                                    color: AppColors
                                                        .profileWlColorText,
                                                    fontSize: 12,
                                                    fontFamily: AppTextStyles
                                                        .fontFamily,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                },
                              ),
                  ),
                  Container(
                    height: height * 0.07,
                    width: width * 0.85,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        color: AppColors.borderColor,
                        width: width * 0.0005,
                      ),
                    ),
                    margin: EdgeInsets.symmetric(vertical: height * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Expanded(
                          flex: 1,
                          child: SizedBox(),
                        ),
                        Expanded(
                          flex: 6,
                          child: TextFormField(
                            controller: controller.commentController,
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: AppTextStyles.fontFamily,
                              fontWeight: FontWeight.w400,
                            ),
                            inputFormatters: [FirstCharacterNoSpaceFormatter()],
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(
                                color: AppColors.containerShadowColor,
                                fontSize: 12,
                                fontFamily: AppTextStyles.fontFamily,
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                              hintText: AppTexts.writeCommentText,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: TextButton(
                              child: Text(
                                AppTexts.postText,
                                style: TextStyle(
                                  color: AppColors.buttonColor,
                                  fontSize: 14,
                                  fontFamily: AppTextStyles.fontFamily,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              onPressed: () {
                                if (controller
                                    .commentController.text.isNotEmpty) {
                                  controller.postComment(
                                      chatId: widget.chatId,
                                      comment:
                                          controller.commentController.text);
                                } else {
                                  customSnackbar(
                                    title: "Alert",
                                    message:
                                        'Please write something to comment',
                                  );
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          controller.isSavedCommentLoading.value
              ? const OverlayWidget()
              : const SizedBox()
        ],
      ),
    );
  }
}
