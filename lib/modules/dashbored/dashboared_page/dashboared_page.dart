import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:sp_showcaseview/showcaseview.dart';
import 'package:weight_loss_app/common/app_colors.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/dashbored/screens/grocery/grocery_page/grocery_page.dart';
import 'package:weight_loss_app/modules/dashbored/screens/home/home_page/home_page.dart';
import 'package:weight_loss_app/modules/dashbored/screens/scanner/view/scanner_view.dart';
import 'package:weight_loss_app/modules/diary/diary_page/diary_page.dart';
import 'package:weight_loss_app/modules/progress_user/view/progress_user_page.dart';

import '../controller/dashboared_controller.dart';

class DashboaredPage extends GetView<DashboaredController> {
  const DashboaredPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboaredController dashboaredController =
        Get.put(DashboaredController());
    return Scaffold(
      body: Obx(
        () => PersistentTabView(
          navBarHeight: 70,
          hideNavigationBar: dashboaredController.isDrawerHide.value,
          backgroundColor: AppColors.buttonColor,
          onWillPop: (context) async {
            if (controller.doubleTap.value) {
              return true;
            } else {
              controller.doubleTap.value = true;

              Fluttertoast.showToast(
                msg: 'Tap again to exit App',
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
              );

              Future.delayed(const Duration(seconds: 3), () {
                controller.doubleTap.value = false;
              });

              return false;
            }
          },
          navBarBuilder: (navBarConfig) =>
              Style15BottomNavBar(navBarConfig: navBarConfig),
          tabs: [
            /* -------------------------------------------------------------------------- */
            /*                                    home                                    */
            /* -------------------------------------------------------------------------- */
            PersistentTabConfig(
              screen: HomePage(
                isDrawerHide: dashboaredController.isDrawerHide,
                userName: dashboaredController.userName,
                isCallShowcase: dashboaredController.isCallShowcase,
              ),
              item: ItemConfig(
                icon: const Icon(Icons.home),

                ///
                activeForegroundColor: AppColors.primaryColor,
                inactiveForegroundColor: const Color(0xFF8AB6CA),

                ///
                title: "Home",
                textStyle: AppTextStyles.bottomAppbarStyle,
              ),
            ),

            ///
            /* -------------------------------------------------------------------------- */
            /*                                   Grocery                                  */
            /* -------------------------------------------------------------------------- */
            ///
            PersistentTabConfig(
              screen: GroceryPage(),
              item: ItemConfig(
                icon: const Icon(Icons.shopping_cart),

                ///
                activeForegroundColor: AppColors.primaryColor,
                inactiveForegroundColor: const Color(0xFF8AB6CA),

                ///
                title: "Grocery",
                textStyle: AppTextStyles.bottomAppbarStyle,
              ),
            ),

            ///
            /* -------------------------------------------------------------------------- */
            /*                                 ScannerPage                                */
            /* -------------------------------------------------------------------------- */
            ///
            PersistentTabConfig(
              screen: ScannerPage(),
              item: ItemConfig(
                // contentPadding: 0,
                icon: Showcase(
                  key: bottomKey,
                  description: 'Scan any item for instant calorie count',
                  disableDefaultTargetGestures: false,
                  onBarrierClick: () => debugPrint('Barrier clicked'),
                  child: Container(
                    height: 150,
                    width: 100,
                    decoration: BoxDecoration(
                      color: AppColors.buttonColor,
                      border: Border.all(
                        color: const Color.fromARGB(175, 138, 165, 177),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.qr_code_scanner_rounded,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                activeForegroundColor: Colors.transparent,
              ),
            ),

            ///
            /* -------------------------------------------------------------------------- */
            /*                                 ProgressUserPage                           */
            /* -------------------------------------------------------------------------- */
            ///
            PersistentTabConfig(
              screen: const ProgressUserPage(),
              item: ItemConfig(
                icon: Showcase(
                  key: progressKey,
                  description: "Check your progress.",
                  disableDefaultTargetGestures: false,
                  onBarrierClick: () => debugPrint('Barrier clicked'),
                  child: const Icon(Icons.bar_chart_outlined),
                ),

                ///
                activeForegroundColor: AppColors.primaryColor,
                inactiveForegroundColor: const Color(0xFF8AB6CA),

                ///
                title: "Progress",
                textStyle: AppTextStyles.bottomAppbarStyle,
              ),
            ),

            ///
            /* -------------------------------------------------------------------------- */
            /*                                 Diary                                      */
            /* -------------------------------------------------------------------------- */
            ///
            PersistentTabConfig(
              screen: const DiaryPage(),
              item: ItemConfig(
                icon: Showcase(
                  key: diaryKey,
                  description: "Get insight into your daily intakes.",
                  disableDefaultTargetGestures: false,
                  onBarrierClick: () => debugPrint('Barrier clicked'),
                  child: const Icon(Icons.book_online_rounded),
                ),

                ///
                activeForegroundColor: AppColors.primaryColor,
                inactiveForegroundColor: const Color(0xFF8AB6CA),

                ///
                title: "Diary",
                textStyle: AppTextStyles.bottomAppbarStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
