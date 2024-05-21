import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weight_loss_app/common/app_assets.dart';

import '../../../../common/app_colors.dart';

class CbtApplauseWidget extends StatelessWidget {
  const CbtApplauseWidget({super.key, required this.isTrue});
  final bool isTrue;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return Container(
      color: AppColors.black.withOpacity(0.3),
      child: Center(
        child: SizedBox(
          height: height * 0.3,
          child: Center(
            child: Lottie.asset(
              isTrue ? AppAssets.cbtSuccessUrl : AppAssets.cbtFailedUrl,
            ),
          ),
        ),
      ),
    );
  }
}
