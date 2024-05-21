// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/modules/group_exercise/challenge/binding/chalenge_binding.dart';
import 'package:weight_loss_app/modules/group_exercise/challenge/chalenge_page/challenge_page.dart';
import 'package:weight_loss_app/modules/group_exercise/create_challenge/binding/create_challenge_binding.dart';
import 'package:weight_loss_app/modules/group_exercise/create_challenge/create_challenge_page/create_challenge_page.dart';
import 'package:weight_loss_app/utils/internet_check_widget.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';
import '../controller/challenge_space_controller.dart';
import '../widget/container_design_widget.dart';

class ChallengeSpacePage extends GetView<ChallengeSpaceController> {
  const ChallengeSpacePage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppTexts.challengeSpace,
          style: TextStyle(
            fontFamily: AppTextStyles.fontFamily,
            fontSize: 18,
            color: AppColors.blue,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.white,
        iconTheme: const IconThemeData(color: AppColors.blue),
        elevation: 0,
        actions: [
          Container(
            height: height * 0.01,
            width: width * 0.11,
            margin: EdgeInsets.only(right: width * 0.05),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFEAEAEA),
            ),
            child: const Icon(
              Icons.notifications,
              size: 20,
            ),
          )
        ],
      ),
      body: InternetCheckWidget<ConnectivityService>(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.07),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: height * 0.03,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Text(
                    AppTexts.happeningNow,
                    style: TextStyle(
                        color: AppColors.blue,
                        fontFamily: AppTextStyles.fontFamily,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Text(
                    AppTexts.spaceGoing,
                    style: TextStyle(
                        fontFamily: AppTextStyles.fontFamily,
                        color: AppColors.textChallengeColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: height * 0.02,
                  ),
                ),
                SliverList.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: height * 0.01, horizontal: width * 0.01),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => const ChallengePage(),
                              binding: ChallengeBinding());
                        },
                        child: const ContainerDesignWidget(
                          iconData: Icons.signal_cellular_alt_sharp,
                          myText: AppTexts.liveChallengeText,
                          heightIcon: 13,
                        ),
                      ),
                    );
                  },
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: height * 0.03,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Text(
                    "Coming Up...",
                    style: TextStyle(
                        color: AppColors.blue,
                        fontFamily: AppTextStyles.fontFamily,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: height * 0.03,
                  ),
                ),
                SliverList.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: height * 0.01, horizontal: width * 0.01),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => const ChallengePage(),
                                binding: ChallengeBinding());
                          },
                          child: const ContainerDesignWidget(
                            iconData: Icons.add_alert_rounded,
                            myText: AppTexts.addReminderText,
                            heightIcon: 5,
                          ),
                        ),
                      );
                    }),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: height * 0.03,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: width * 0.05),
                      child: Material(
                        color: AppColors.buttonColor,
                        borderRadius: BorderRadius.circular(20),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => const CreateChallengePage(),
                                binding: CreateChallengeBinding());
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox(
                            height: height * .05,
                            width: width * 0.38,
                            child: const Center(
                              child: Text(
                                "Create Challenge",
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 11,
                                  fontFamily: AppTextStyles.fontFamily,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                 SliverToBoxAdapter(
                  child: SizedBox(
                    height: height * 0.05,
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
