// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:weight_loss_app/common/app_colors.dart';
// import 'package:weight_loss_app/common/app_text_styles.dart';
// import 'package:weight_loss_app/modules/connected_device/connected_devices/widgets/snaclbar.dart';

// class BluetoothOffScreen extends StatelessWidget {
//   const BluetoothOffScreen({super.key, this.adapterState});

//   final BluetoothAdapterState? adapterState;

//   Widget buildBluetoothOffIcon(BuildContext context) {
//     return Icon(
//       Icons.bluetooth_disabled,
//       size: MediaQuery.sizeOf(context).height * 0.2,
//       color: AppColors.greyDim,
//     );
//   }

//   Widget buildTitle(BuildContext context) {
//     String? state = adapterState?.toString().split(".").last;
//     return Text(
//       'Bluetooth is ${state ?? 'not available'}',
//       style: Theme.of(context)
//           .primaryTextTheme
//           .titleSmall
//           ?.copyWith(color: Colors.black),
//     );
//   }

//   Widget buildTurnOnButton(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.015),
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.buttonColor,
//           foregroundColor: AppColors.white,
//         ),
//         onPressed: () async {
//           try {
//             if (await FlutterBluePlus.isSupported) {
//               if (Platform.isAndroid) {
//                 await FlutterBluePlus.turnOn();
//               }
//             }
//           } catch (e) {
//             Snackbar.show(ABC.a, prettyException("Error Turning On:", e),
//                 success: false);
//           }
//         },
//         child: Text(
//           'TURN ON',
//           style: AppTextStyles.formalTextStyle(color: AppColors.white),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     return ScaffoldMessenger(
//       key: Snackbar.snackBarKeyA,
//       child: Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           toolbarHeight: height * 0.1,
//           backgroundColor: Colors.white,
//           title: Text(
//             "Bluetooth",
//             style: TextStyle(
//               color: AppColors.buttonColor,
//               fontSize: 18,
//               fontFamily: AppTextStyles.fontFamily,
//               fontWeight: FontWeight.w700,
//               height: 1.33,
//             ),
//           ),
//           centerTitle: true,
//         ),
//         body: Center(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               buildBluetoothOffIcon(context),
//               buildTitle(context),
//               if (Platform.isAndroid) buildTurnOnButton(context),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
