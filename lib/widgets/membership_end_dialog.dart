import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_assets.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_detail/binding/payment_detail_binding.dart';
import 'package:weight_loss_app/modules/payment_integration/payment_detail/payment_detail_page/payment_detail_page.dart';
import 'package:weight_loss_app/modules/setting/account/account_page/account_page.dart';
import 'package:weight_loss_app/modules/setting/account/binding/account_binding.dart';

class MembershipEndDialog extends StatelessWidget {
  const MembershipEndDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    double height = screenSize.height;
    double width = screenSize.width;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Dialog(
        surfaceTintColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: SizedBox(
          width: width * 0.8,
          height: height * 0.6,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.07),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      Get.to(() => const AccountPage(),
                          binding: AccountBinding());
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                  ),
                ),
                SvgPicture.asset(
                  AppAssets.membershipEndSvgUrl,
                  height: height * 0.25,
                ),
                AutoSizeText(
                  'Membership Ended',
                  minFontSize: 10,
                  style: AppTextStyles.formalTextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: SizedBox(
                    height: height * 0.06,
                    child: AutoSizeText(
                      'Renew your membership for continued benefits and enhanced services.',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: AppTextStyles.formalTextStyle(
                        color: const Color(0xFF7E7E7E),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Material(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1, color: AppColors.buttonColor),
                          borderRadius: BorderRadius.circular(33.84),
                        ),
                        child: InkWell(
                          onTap: () {
                            exit(0);
                          },
                          borderRadius: BorderRadius.circular(33.84),
                          child: SizedBox(
                            height: height * 0.055,
                            child: Center(
                              child: AutoSizeText(
                                'Exit',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.formalTextStyle(
                                  fontSize: 15.23,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.05,
                    ),
                    Expanded(
                      child: Material(
                        color: AppColors.buttonColor,
                        borderRadius: BorderRadius.circular(33.84),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => const PaymentDetailPage(),
                                binding: PaymentDetailBinding());
                          },
                          borderRadius: BorderRadius.circular(33.84),
                          child: SizedBox(
                            height: height * 0.055,
                            child: Center(
                              child: AutoSizeText(
                                'Pay',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.formalTextStyle(
                                  color: Colors.white,
                                  fontSize: 15.23,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
