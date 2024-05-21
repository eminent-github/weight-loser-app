import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weight_loss_app/modules/dashbored/screens/drawer/modalClass/container_shadow_modal_class.dart';

import '../../../../../common/app_colors.dart';
import '../../../../../common/app_text_styles.dart';

class CustomContainerShadow extends StatelessWidget {
  const CustomContainerShadow(
      {super.key,
      this.heightContainer,
      this.widthContainer,
      this.containerModalClass,
      this.onPressed,
      this.textC,
      this.iconPath});
  final double? heightContainer;
  final double? widthContainer;
  final String? textC;
  final String? iconPath;
  final VoidCallback? onPressed;
  final ContainerModalClass? containerModalClass;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Material(
          color: AppColors.white,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          elevation: 20,
          child: InkWell(
            onTap: onPressed ?? () {},
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            child: SizedBox(
              height: height * 0.11,
              width: width * 0.22,
              child: Center(
                child: SvgPicture.asset(
                    iconPath ?? containerModalClass!.iconImage),
              ),
            ),
          ),
        ),
        SizedBox(
          height: height * 0.025,
        ),
        AutoSizeText(
          textC ?? containerModalClass!.text,
          textAlign: TextAlign.center,
          minFontSize: 7,
          style: TextStyle(
            color: Theme.of(context).primaryTextTheme.titleSmall!.color!,
            fontSize: 11,
            fontFamily: AppTextStyles.fontFamily,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}

class CustomProfContainerShadow extends StatelessWidget {
  const CustomProfContainerShadow({
    super.key,
    this.heightContainer,
    this.widthContainer,
    required this.containerModalClass,
    this.onPressed,
  });
  final double? heightContainer;
  final double? widthContainer;

  final VoidCallback? onPressed;
  final ContainerModalClass containerModalClass;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Material(
          color: AppColors.white,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          elevation: 20,
          child: InkWell(
            onTap: onPressed ?? () {},
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            child: SizedBox(
              height: height * 0.11,
              width: width * 0.22,
              child: Center(
                child: containerModalClass.isIcon
                    ? Icon(
                        containerModalClass.icon,
                        color: AppColors.buttonColor,
                        size: 45,
                      )
                    : SvgPicture.asset(containerModalClass.iconImage),
              ),
            ),
          ),
        ),
        SizedBox(
          height: height * 0.025,
        ),
        AutoSizeText(
          containerModalClass.text,
          textAlign: TextAlign.center,
          minFontSize: 5,
          maxLines: 2,
          style: TextStyle(
            color: Theme.of(context).primaryTextTheme.titleSmall!.color!,
            fontSize: 11,
            fontFamily: AppTextStyles.fontFamily,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
