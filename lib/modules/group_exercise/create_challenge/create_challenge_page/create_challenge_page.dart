import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/modules/group_exercise/create_challenge/widget/bottom_sheet.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import '../../../../../common/app_colors.dart';
import '../../../../../common/app_text_styles.dart';
import '../../../../../common/app_texts.dart';
import '../controller/create_challenge_controller.dart';

class CreateChallengePage extends GetView<CreateChallengeController> {
  const CreateChallengePage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height - kToolbarHeight;
    double width = size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppTexts.createChallenge,
          style: TextStyle(
            fontFamily: AppTextStyles.fontFamily,
            fontSize: 18,
            color: AppColors.blue,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData.fallback(),
        elevation: 0,
      ),
      body: InternetCheckWidget<ConnectivityService>(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.04,
              ),
              Container(
                height: height * 0.12,
                width: width * 0.85,
                decoration: const BoxDecoration(
                  color: AppColors.containerBackGround,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: TextFormField(
                  expands: true,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: AppTexts.challengeWrite,
                    hintStyle: TextStyle(
                      fontFamily: AppTextStyles.fontFamily,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              SizedBox(
                height: height * 0.55,
                width: width * 0.85,
                child: ListView.builder(
                  itemCount: controller.cbtQuesList.length,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.01),
                    child: Obx(
                      () => InkWell(
                        onTap: () {
                          controller.selectedIndex.value = index;
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: height * 0.07,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            border: Border.all(
                              color: AppColors.blue,
                              width: 0.2,
                            ),
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                controller.cbtQuesList[index],
                                style: const TextStyle(
                                  fontFamily: AppTextStyles.fontFamily,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.blue,
                                ),
                              ),
                              const Text(
                                '8:25 Minutes',
                                style: TextStyle(
                                  fontFamily: AppTextStyles.fontFamily,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.blue,
                                ),
                              ),
                              controller.selectedIndex.value == index
                                  ? Icon(
                                      Icons.check_circle_rounded,
                                      color: AppColors.buttonColor,
                                      size: 20,
                                    )
                                  : Icon(
                                      Icons.check_circle_outlined,
                                      color: AppColors.buttonColor,
                                      size: 20,
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.04),
              Expanded(
                child: Center(
                  child: SizedBox(
                    height: height * 0.05,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Material(
                          color: AppColors.blue,
                          child: InkWell(
                            onTap: () async {},
                            child: SizedBox(
                              width: width * 0.5,
                              child: const Center(
                                child: Text(
                                  AppTexts.startChallenge,
                                  style: TextStyle(
                                    fontFamily: AppTextStyles.fontFamily,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              showDragHandle: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                ),
                              ),
                              backgroundColor: Colors.white,
                              builder: (BuildContext context) {
                                return const BottomSheetDesign();
                              },
                            );
                          },
                          child: const Icon(
                            Icons.schedule,
                            size: 35,
                            color: AppColors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
