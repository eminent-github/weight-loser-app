import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/api_urls.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/common/app_texts.dart';
import 'package:weight_loss_app/modules/registeration_questions/drag_cuisine/controller/drag_cuisine_controller.dart';
import 'package:weight_loss_app/modules/registeration_questions/models/get_question_with_answer_model.dart';
import 'package:weight_loss_app/modules/registeration_questions/widgets/qus_top_progress_widget.dart';
import 'package:weight_loss_app/modules/registeration_questions/widgets/transitions.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import 'package:weight_loss_app/widgets/custom_large_button.dart';
import 'package:weight_loss_app/widgets/loading_image.dart';
import 'package:weight_loss_app/widgets/overlay_widget.dart';
import 'package:weight_loss_app/widgets/qus_understand_widget.dart';

class DragCuisinePage extends GetView<DragCuisineController> {
  const DragCuisinePage({
    super.key,
    required this.cuisineDragList,
    required this.order,
    required this.id,
  });
  final List<Option> cuisineDragList;
  final int order;
  final int id;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    double height = size.height;
    double width = size.width;

    return Scaffold(
      body: InternetCheckWidget<ConnectivityService>(
        child: Obx(
          () => Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: height * 0.1,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: SizedBox(
                                height: height,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.02),
                                  child: const Icon(
                                      Icons.arrow_back_ios_new_rounded),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  QusTopProgressWidget(
                                    progress: 1 / secondModuleTotalScreen,
                                    title: AppTexts.qusSecondModule,
                                    height: height * 0.008,
                                    width: width * 0.15,
                                    titleTextColor: AppColors.black,
                                    progressColor: AppColors.dietModuleColor,
                                  ),
                                  QusTopProgressWidget(
                                    progress: 0,
                                    title: AppTexts.qusThirdModule,
                                    height: height * 0.008,
                                    width: width * 0.15,
                                    titleTextColor: AppColors.greyDim,
                                  ),
                                  QusTopProgressWidget(
                                    progress: 0,
                                    title: AppTexts.qusFourthModule,
                                    height: height * 0.008,
                                    width: width * 0.15,
                                    titleTextColor: AppColors.greyDim,
                                  ),
                                  QusTopProgressWidget(
                                    progress: 0,
                                    title: AppTexts.qusFifthModule,
                                    height: height * 0.008,
                                    width: width * 0.15,
                                    titleTextColor: AppColors.greyDim,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.25,
                        child: Center(
                          child: UnderstandWidget(
                            color: AppColors.dietModuleColor,
                            headerText: AppTexts.eatingHabitTitleText,
                            requestText:
                                "Place the selected cuisines in your favorite order",
                            isShowDiscription: true,
                            discriptionText: "(Drag and drop)",
                            height: height * 0.25,
                            width: width,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      SizedBox(
                        height: height * 0.4,
                        child: Center(
                          child: GetBuilder(
                            init: controller,
                            initState: (_) {},
                            builder: (_) {
                              return ReorderableListView(
                                onReorder: controller.reorder,
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.1),
                                children: [
                                  for (int index = 0;
                                      index < cuisineDragList.length;
                                      index++)
                                    Padding(
                                      key: ValueKey(cuisineDragList[index]),
                                      padding: EdgeInsets.symmetric(
                                        vertical: height * 0.02,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: width * 0.08,
                                            height: height * 0.05,
                                            decoration: BoxDecoration(
                                              color: AppColors.buttonColor,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "${index + 1}",
                                                textAlign: TextAlign.center,
                                                style: AppTextStyles
                                                    .formalTextStyle(
                                                  color:
                                                      const Color(0xFFF6F1F1),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: width * 0.65,
                                            height: 51,
                                            decoration: ShapeDecoration(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              shadows: const [
                                                BoxShadow(
                                                  color: Color(0x3F000000),
                                                  blurRadius: 4,
                                                  offset: Offset(0, 0),
                                                  spreadRadius: 0,
                                                )
                                              ],
                                            ),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: width * 0.02,
                                                ),
                                                Icon(
                                                  Icons.drag_indicator_rounded,
                                                  color: AppColors.buttonColor,
                                                ),
                                                SizedBox(
                                                  width: width * 0.02,
                                                ),
                                                SizedBox(
                                                  width: width * 0.1,
                                                  height: 34,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    child: S3LoadingImage(
                                                      imageUrl:
                                                          "${ApiUrls.s3ImageBaseUrl}planImages/dietPlans/${cuisineDragList[index].explanationAnswer}",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width * 0.04,
                                                ),
                                                Text(
                                                  cuisineDragList[index]
                                                          .option ??
                                                      'Chinese',
                                                  textAlign: TextAlign.center,
                                                  style: AppTextStyles
                                                      .formalTextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      CustomLargeButton(
                        text: AppTexts.questionCuisineButton,
                        height: height,
                        width: width * 0.55,
                        onPressed: () {
                          controller.cuisinePrefrenceAnswerApi(
                            order,
                            id,
                            controller.cuisineDragList!
                                .map((e) => e.option)
                                .toList()
                                .toString(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              controller.isLoading.value
                  ? const OverlayWidget()
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
