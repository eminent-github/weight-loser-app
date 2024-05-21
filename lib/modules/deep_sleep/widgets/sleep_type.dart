import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';

class SleepType extends StatelessWidget {
  const SleepType({
    super.key,
    required this.type,
    required this.time,
    required this.imagUrl,
  });

  final String type;
  final String time;
  final String imagUrl;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(11.35),
      elevation: 5,
      child: SizedBox(
        width: width * 0.4,
        height: height * 0.09,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: width * 0.08,
                  height: height * 0.03,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(imagUrl),
                ),
                Column(
                  children: [
                    Text(
                      type,
                      style: AppTextStyles.formalTextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      time,
                      style: AppTextStyles.formalTextStyle(
                        color: AppColors.black.withOpacity(0.5),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
