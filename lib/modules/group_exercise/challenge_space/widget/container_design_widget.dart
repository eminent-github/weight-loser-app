import 'package:flutter/material.dart';

import '../../../../common/app_assets.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../common/app_texts.dart';
import 'image_container.dart';

class ContainerDesignWidget extends StatelessWidget {
  const ContainerDesignWidget(
      {super.key,
      required this.myText,
      required this.iconData,
      required this.heightIcon});
  final String myText;
  final IconData iconData;
  final double heightIcon;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          height: height * 0.25,
          width: width * 0.9,
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            children: [
              Container(
                height: height * 0.191,
                width: width * 0.9,
                decoration: const BoxDecoration(
                  color: AppColors.blue,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                ),
                child: Row(children: [
                  Container(
                    height: height * 0.19,
                    width: width * 0.24,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                        ),
                        image: DecorationImage(
                            image: AssetImage(
                              AppAssets.runningUrl,
                            ),
                            fit: BoxFit.fill)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.016, vertical: height * 0.01),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.1,
                          width: width * 0.5,
                          child: const Center(
                            child: Text(
                              AppTexts.dummyText,
                              style: TextStyle(
                                color: AppColors.white,
                                fontFamily: AppTextStyles.fontFamily,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: width * 0.2,
                              child: Stack(
                                children: [
                                  const ImageWidget(),
                                  Positioned(
                                    left: width * 0.02,
                                    bottom: 0,
                                    child: const ImageWidget(),
                                  ),
                                  Positioned(
                                    left: width * 0.06,
                                    bottom: 0,
                                    child: const ImageWidget(),
                                  ),
                                  Positioned(
                                    left: width * 0.1,
                                    bottom: 0,
                                    child: const ImageWidget(),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width * 0.012),
                              child: const Text(
                                "150 People Joined",
                                style: TextStyle(
                                  fontFamily: AppTextStyles.fontFamily,
                                  fontSize: 7,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width * 0.07),
                              child: Icon(
                                iconData,
                                color: AppColors.white,
                                size: 11,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width * 0.01),
                              child: Text(
                                myText,
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontFamily: AppTextStyles.fontFamily,
                                  fontWeight: FontWeight.w400,
                                  fontSize: heightIcon,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ]),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                children: [
                  Container(
                    height: height * 0.035,
                    width: width * 0.1,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(
                              AppAssets.runningUrl,
                            ),
                            fit: BoxFit.cover)),
                  ),
                  const Text(
                    "Mariya Reports",
                    style: TextStyle(
                      fontFamily: AppTextStyles.fontFamily,
                      fontSize: 8.4,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.015),
                    child: Container(
                      height: height * 0.02,
                      width: width * 0.08,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                        color: AppColors.blue,
                      ),
                      child: const Center(
                        child: Text(
                          "Host",
                          style: TextStyle(
                              color: AppColors.white,
                              fontFamily: AppTextStyles.fontFamily,
                              fontSize: 5.04,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.18),
                    child: const Text('Created Date: ' '24 July 2023',
                        style: TextStyle(
                            color: Color(0xffADADAD),
                            fontFamily: AppTextStyles.fontFamily,
                            fontSize: 7,
                            fontWeight: FontWeight.w500)),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
