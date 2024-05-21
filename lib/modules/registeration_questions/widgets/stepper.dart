import 'package:flutter/material.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';

class QusStepper extends StatelessWidget {
  const QusStepper({super.key, required this.question});
  final int question;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    // double height = screenSize.height;
    double width = screenSize.width;
    return ListView.builder(
        itemCount: 7,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width * 0.055,
                height: 23,
                decoration: BoxDecoration(
                  color: question > index
                      ? AppColors.buttonColor
                      : AppColors.white,
                  border:
                      Border.all(width: 0.96, color: const Color(0xFFD9D9D9)),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "${index + 1}",
                    style: AppTextStyles.formalTextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              index != 6
                  ? SizedBox(
                      width: width * 0.07,
                      child: const Divider(
                        thickness: 0.5,
                        color: Color(0xFFD9D9D9),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          );
        });
  }
}
