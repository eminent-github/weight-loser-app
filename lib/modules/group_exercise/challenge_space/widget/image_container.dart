import 'package:flutter/widgets.dart';

import '../../../../common/app_assets.dart';
import '../../../../common/app_colors.dart';
class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Container(
                              height: height * 0.04,
                              width: width * 0.12,
                              decoration:  BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColors.borderColor,
                                  width: 2),
                                  image: const DecorationImage(
                                      image: AssetImage(AppAssets.runningUrl))),
                            );
  }
  
}