import 'dart:ui';

import 'package:flutter/material.dart';
// import 'package:weight_loss_app/common/app_colors.dart';

class OverlayWidget extends StatelessWidget {
  const OverlayWidget({
    super.key,
    this.height,
    this.width,
  });
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double inheight = screenSize.height;
    double inwidth = screenSize.width;
    return SafeArea(
      child: SizedBox(
        height: height ?? inheight,
        width: width ?? inwidth,
        child: Material(
          color: Colors.transparent,
          // clipBehavior: Clip.hardEdge,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 4,
              sigmaY: 4,
            ),
            child: const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        ),
      ),
    );
  }
}
