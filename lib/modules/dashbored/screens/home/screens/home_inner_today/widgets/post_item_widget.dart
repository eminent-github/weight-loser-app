import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'diet_item.dart';

class PostItemWidget extends StatelessWidget {
  const PostItemWidget(
      {super.key,
      required this.title,
      required this.keywrod,
      required this.imageUrl,
      required this.backColor,
      required this.isNew,
      required this.iconButtonType,
      required this.heigth,
      required this.width,
      required this.onPressed});
  final String title;
  final String imageUrl;
  final Color backColor;
  final bool isNew;
  final IconData iconButtonType;
  final String keywrod;
  final double heigth;
  final double width;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xffF9F9F0),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          // height: heigth * 0.2,
          width: width * 0.9,
          // margin: const EdgeInsets.only(left: 27, right: 27, top: 0, bottom: 20),
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.05, vertical: heigth * 0.02),
          child: Row(
            children: [
              SizedBox(
                width: width * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isNew == true
                        ? Container(
                            height: heigth * 0.025,
                            width: width * 0.13,
                            decoration: BoxDecoration(
                              color: const Color(0xffF18066),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                "New",
                                style: AppTextStyles.formalTextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: heigth * 0.015,
                    ),
                    Html(
                      data: title,
                      style: {
                        'body': Style(
                          fontFamily: AppTextStyles.fontFamily,
                          color: AppColors.black,
                          fontSize: FontSize(13),
                          fontWeight: FontWeight.bold,
                        ),
                      },
                    ),
                    SizedBox(
                      height: heigth * 0.015,
                    ),
                    Row(
                      children: [
                        IconWithTextWidget(
                          leftIcon: iconButtonType,
                          text: "",
                          color: const Color(0xff74746C),
                          size: 18,
                          fontSize: 12,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          keywrod,
                          style: AppTextStyles.formalTextStyle(
                            fontSize: 12,
                            color: const Color(0xff74746C),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: heigth * 0.12,
                width: width * 0.2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: backColor,
                ),
                child: Center(
                  child: Image.asset(
                    imageUrl,
                    height: heigth * 0.07,
                    width: width * 0.12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
