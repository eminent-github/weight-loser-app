// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:get/get.dart';
// import 'package:weight_loss_app/common/app_colors.dart';
// import 'package:weight_loss_app/common/app_text_styles.dart';
// import 'package:weight_loss_app/common/app_texts.dart';
// import 'package:weight_loss_app/modules/connected_device/connected_devices/view/bluetooth_off_screen.dart';
// import 'package:weight_loss_app/utils/internet_check_widget.dart';
// import '../controller/connected_device_controller.dart';
// import '../widgets/connected_device_widget.dart';

// class ConnectedDevicePage extends GetView<ConnectedDeviceController> {
//   const ConnectedDevicePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     // double width = MediaQuery.of(context).size.width;
//     return Obx(() => controller.adapterState.value == BluetoothAdapterState.on
//         ? Scaffold(
//             appBar: AppBar(
//               toolbarHeight: height * 0.1,
//               backgroundColor: Colors.white,
//               title: Text(
//                 AppTexts.connectedDeviceText,
//                 style: TextStyle(
//                   color: AppColors.buttonColor,
//                   fontSize: 18,
//                   fontFamily: AppTextStyles.fontFamily,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               centerTitle: true,
//               // actions: [
//               //   IconButton(
//               //     padding: EdgeInsets.only(right: width * 0.05),
//               //     onPressed: () {},
//               //     icon: const Icon(
//               //       Icons.search,
//               //       color: Color(0xffD0D0D0),
//               //     ),
//               //   )
//               // ],
//               bottom: TabBar(
//                 indicatorColor: AppColors.buttonColor,
//                 controller: controller.tabController,
//                 tabs: controller.list,
//               ),
//             ),
//             body: InternetCheckWidget<ConnectivityService>(
//               child: SafeArea(
//                 child: TabBarView(
//                   controller: controller.tabController,
//                   children: [
//                     GetBuilder<ConnectedDeviceController>(
//                       builder: (controller) {
//                         return const AllDevices();
//                       },
//                     ),
//                     const ConnectedDevices(),
//                   ],
//                 ),
//               ),
//             ),
//           )
//         : BluetoothOffScreen(adapterState: controller.adapterState.value));
//   }
// }
