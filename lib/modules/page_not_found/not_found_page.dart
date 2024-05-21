import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../common/app_assets.dart';
import '../../common/app_colors.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        leading:  IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),onPressed: (){
          Get.back();
        },),

        toolbarHeight: height * 0.1,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.3,
              width: width,
              child: SvgPicture.asset(AppAssets.pageNotFound),
            ),
          ],
        ),
      ),
    );
  }
}
