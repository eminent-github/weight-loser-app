// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
// import 'package:weight_loss_app/common/app_colors.dart';

// import '../controller/dashboared_controller.dart';

// class DashboaredPage extends GetView<DashboaredController> {
//   const DashboaredPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Obx(
//         () => PersistentTabView(
//           context,
//           navBarHeight: 70,
//           screens: controller.tabItems,
//           items: controller.navBarsItems(),
//           navBarStyle: NavBarStyle.style15,
//           hideNavigationBar: controller.isDrawerHide.value,
//           backgroundColor: AppColors.buttonColor,
//           onWillPop: (context) async {
//             if (controller.doubleTap.value) {
//               return true;
//             } else {
//               controller.doubleTap.value = true;

//               Fluttertoast.showToast(
//                 msg: 'Tap again to exit App',
//                 toastLength: Toast.LENGTH_SHORT,
//                 timeInSecForIosWeb: 1,
//               );

//               Future.delayed(const Duration(seconds: 3), () {
//                 controller.doubleTap.value = false;
//               });

//               return false;
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
