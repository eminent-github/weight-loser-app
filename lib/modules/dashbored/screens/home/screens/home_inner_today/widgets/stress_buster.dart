import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../common/app_text_styles.dart';

class StressBusterWidget extends StatelessWidget {
  const StressBusterWidget({
    super.key,
    required this.height,
    required this.width,
    required this.onPressed,
    required this.imageUrl,
    required this.title,
  });
  final String imageUrl;
  final String title;
  final double height;
  final double width;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(7),
      child: Container(
        width: width * 0.4,
        height: height * 0.16,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 0.70,
              color: Color(
                0xFFDADADA,
              ),
            ),
            borderRadius: BorderRadius.circular(7),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              imageUrl,
              width: width * 0.15,
              height: height * 0.07,
            ),
            SizedBox(
              width: width * 0.3,
              child: AutoSizeText(
                title,
                textAlign: TextAlign.center,
                minFontSize: 10,
                maxLines: 2,
                style: AppTextStyles.formalTextStyle(
                  fontSize: 16,
                  color: Theme.of(context).primaryTextTheme.titleMedium!.color!,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
