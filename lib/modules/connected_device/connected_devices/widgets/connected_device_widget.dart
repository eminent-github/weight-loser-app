// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:weight_loss_app/common/app_colors.dart';
// import 'package:weight_loss_app/common/app_text_styles.dart';
// import 'package:weight_loss_app/modules/connected_device/connected_devices/view/device_detail_screen.dart';
// import 'package:weight_loss_app/modules/connected_device/connected_devices/widgets/connected_device_tile.dart';
// import 'package:weight_loss_app/modules/connected_device/connected_devices/widgets/scan_result_tile.dart';
// import 'package:weight_loss_app/modules/connected_device/connected_devices/widgets/snaclbar.dart';
// import 'package:weight_loss_app/modules/connected_device/device_screen/device_screeen.dart';
// import 'package:weight_loss_app/modules/connected_device/utils/extras.dart';

// class AllDevices extends StatefulWidget {
//   const AllDevices({super.key});

//   @override
//   State<AllDevices> createState() => _AllDevicesState();
// }

// class _AllDevicesState extends State<AllDevices> {
//   List<BluetoothDevice> systemDevices = [];
//   List<ScanResult> _scanResults = [];
//   bool _isScanning = false;
//   late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
//   late StreamSubscription<bool> _isScanningSubscription;

//   @override
//   void initState() {
//     super.initState();

//     _scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
//       if (results.isNotEmpty) {
//         _scanResults = results;
//       }

//       setState(() {});
//     });

//     _isScanningSubscription = FlutterBluePlus.isScanning.listen((state) {
//       _isScanning = state;
//       setState(() {});
//     });
//   }

//   @override
//   void dispose() {
//     _scanResultsSubscription.cancel();
//     _isScanningSubscription.cancel();
//     super.dispose();
//   }

//   Future onScanPressed() async {
//     try {
//       systemDevices = await FlutterBluePlus.systemDevices;
//     } catch (e) {
//       Snackbar.show(ABC.b, prettyException("System Devices Error:", e),
//           success: false);
//     }
//     try {
//       if (await Permission.bluetoothScan.request().isGranted) {
//         await FlutterBluePlus.startScan(
//           timeout: const Duration(seconds: 15),
//         );
//         FlutterBluePlus.cancelWhenScanComplete(_scanResultsSubscription);
//       }
//     } catch (e) {
//       Snackbar.show(ABC.b, prettyException("Start Scan Error:", e),
//           success: false);
//     }
//     setState(() {}); // force refresh of systemDevices
//   }

//   Future onStopPressed() async {
//     try {
//       FlutterBluePlus.stopScan();
//       FlutterBluePlus.cancelWhenScanComplete(_scanResultsSubscription);
//     } catch (e) {
//       Snackbar.show(ABC.b, prettyException("Stop Scan Error:", e),
//           success: false);
//     }
//   }

//   void onConnectPressed(BluetoothDevice device) async {
//     if (await Permission.bluetoothConnect.request().isGranted) {
//       device.connectAndUpdateStream().catchError((e) {
//         Snackbar.show(ABC.c, prettyException("Connect Error:", e),
//             success: false);
//       });
//     }
//   }

//   Future onRefresh() async {
//     if (_isScanning == false) {
//       if (await Permission.bluetoothScan.request().isGranted) {
//         if (await Permission.bluetoothConnect.request().isGranted) {
//           try {
//             systemDevices = await FlutterBluePlus.systemDevices;
//           } catch (e) {
//             Snackbar.show(ABC.b, prettyException("System Devices Error:", e),
//                 success: false);
//           }
//           await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
//         }
//       }
//     }
//     setState(() {});
//     return Future.delayed(const Duration(milliseconds: 500));
//   }

//   Widget buildScanButton(BuildContext context) {
//     if (FlutterBluePlus.isScanningNow) {
//       return FloatingActionButton.extended(
//         onPressed: onStopPressed,
//         // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         backgroundColor: Colors.red,
//         label: const Icon(Icons.stop),
//       );
//     } else {
//       return FloatingActionButton.extended(
//         onPressed: onScanPressed,
//         backgroundColor: AppColors.buttonColor,
//         // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         label: Text(
//           "SCAN",
//           style: AppTextStyles.formalTextStyle(color: AppColors.white),
//         ),
//       );
//     }
//   }

//   List<Widget> _buildSystemDeviceTiles(BuildContext context) {
//     return systemDevices
//         .map(
//           (device) => ScanResultTile(
//             device: device,
//             onTap: () {
//               MaterialPageRoute route2 = MaterialPageRoute(
//                 builder: (context) => DeviceDetailScreen(
//                   onTap: () => onConnectPressed(device),
//                   device: device,
//                 ),
//               );
//               Navigator.of(context).push(route2);
//             },
//           ),
//         )
//         .toList();
//   }

//   List<Widget> _buildScanResultTiles(BuildContext context) {
//     return _scanResults
//         .map(
//           (r) => ScanResultTile(
//             device: r.device,
//             onTap: () {
//               MaterialPageRoute route2 = MaterialPageRoute(
//                 builder: (context) => DeviceDetailScreen(
//                   onTap: () => onConnectPressed(r.device),
//                   device: r.device,
//                 ),
//               );
//               Navigator.of(context).push(route2);
//             },
//           ),
//         )
//         .toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // var size = MediaQuery.sizeOf(context);
//     // double height = size.height;
//     // double width = size.width;
//     return ScaffoldMessenger(
//       key: Snackbar.snackBarKeyB,
//       child: Scaffold(
//         body: RefreshIndicator(
//           onRefresh: onRefresh,
//           child: ListView(
//             children: <Widget>[
//               // ..._buildConnectedDeviceTiles(context),
//               ..._buildSystemDeviceTiles(context),
//               ..._buildScanResultTiles(context),
//             ],
//           ),
//         ),
//         floatingActionButton: buildScanButton(context),

//         // body: Container(
//         //   height: height,
//         //   width: width,
//         //   padding: EdgeInsets.symmetric(
//         //     horizontal: width * 0.05,
//         //   ),
//         //   child: Column(
//         //     crossAxisAlignment: CrossAxisAlignment.start,
//         //     children: [
//         //       SizedBox(
//         //         height: height * 0.05,
//         //       ),
//         //       Expanded(
//         //         child: ListView.builder(
//         //           itemCount: 7,
//         //           itemBuilder: (context, index) {
//         //             return Padding(
//         //               padding: const EdgeInsets.only(bottom: 15.0),
//         //               child: GestureDetector(
//         //                 onTap: () {
//         //                   Get.to(() => const DeviceDetailPage(),
//         //                       binding: DeviceDetailBinding());
//         //                 },
//         //                 child: Row(
//         //                   children: [
//         //                     Container(
//         //                       width: 90,
//         //                       height: 82,
//         //                       decoration: ShapeDecoration(
//         //                         color: const Color(0xFFD9D9D9),
//         //                         shape: RoundedRectangleBorder(
//         //                             borderRadius: BorderRadius.circular(5)),
//         //                       ),
//         //                     ),
//         //                     Container(
//         //                       width: width * 0.02,
//         //                     ),
//         //                     const SizedBox(
//         //                       height: 82,
//         //                       child: Column(
//         //                         mainAxisAlignment:
//         //                             MainAxisAlignment.spaceEvenly,
//         //                         children: [
//         //                           Text(
//         //                             'Device Name',
//         //                             style: TextStyle(
//         //                               color: Colors.black,
//         //                               fontSize: 13,
//         //                               fontFamily: 'Manrope',
//         //                               fontWeight: FontWeight.w400,
//         //                             ),
//         //                           ),
//         //                           Text(
//         //                             'Device Detail',
//         //                             style: TextStyle(
//         //                               color: Colors.black,
//         //                               fontSize: 13,
//         //                               fontFamily: 'Manrope',
//         //                               fontWeight: FontWeight.w400,
//         //                             ),
//         //                           ),
//         //                         ],
//         //                       ),
//         //                     )
//         //                   ],
//         //                 ),
//         //               ),
//         //             );
//         //           },
//         //         ),
//         //       ),
//         //     ],
//         //   ),
//         // ),
//       ),
//     );
//   }
// }

// class ConnectedDevices extends StatefulWidget {
//   const ConnectedDevices({super.key});

//   @override
//   State<ConnectedDevices> createState() => _ConnectedDevicesState();
// }

// class _ConnectedDevicesState extends State<ConnectedDevices> {
//   List<BluetoothDevice> _connectedDevices = [];

//   @override
//   void initState() {
//     super.initState();

//     _connectedDevices = FlutterBluePlus.connectedDevices;
//     setState(() {});
//   }

//   void onConnectPressed(BluetoothDevice device) {
//     device.connectAndUpdateStream().catchError((e) {
//       Snackbar.show(ABC.c, prettyException("Connect Error:", e),
//           success: false);
//     });
//   }

//   List<Widget> _buildConnectedDeviceTiles(BuildContext context) {
//     return _connectedDevices
//         .map(
//           (d) => ConnectedDeviceTile(
//             device: d,
//             onOpen: () => Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => DeviceScreen(device: d),
//                 settings: const RouteSettings(name: '/DeviceScreen'),
//               ),
//             ),
//             onConnect: () => onConnectPressed(d),
//           ),
//         )
//         .toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // var size = MediaQuery.sizeOf(context);
//     // double height = size.height;
//     // double width = size.width;

//     return Scaffold(
//       body: ListView(
//         children: <Widget>[
//           ..._buildConnectedDeviceTiles(context),
//         ],
//       ),
//     );
//     // return Container(
//     //   height: height,
//     //   width: width,
//     //   padding: EdgeInsets.symmetric(
//     //     horizontal: width * 0.05,
//     //   ),
//     //   child: Column(
//     //     crossAxisAlignment: CrossAxisAlignment.start,
//     //     children: [
//     //       SizedBox(
//     //         height: height * 0.05,
//     //       ),
//     //       Expanded(
//     //         child: ListView.builder(
//     //           itemCount: 3,
//     //           itemBuilder: (context, index) {
//     //             return Padding(
//     //               padding: const EdgeInsets.only(bottom: 15.0),
//     //               child: GestureDetector(
//     //                 onTap: () {
//     //                   Get.to(() => const DeviceDetailPage(),
//     //                       binding: DeviceDetailBinding());
//     //                 },
//     //                 child: Row(
//     //                   children: [
//     //                     Container(
//     //                       width: 90,
//     //                       height: 82,
//     //                       decoration: ShapeDecoration(
//     //                         color: const Color(0xFFD9D9D9),
//     //                         shape: RoundedRectangleBorder(
//     //                             borderRadius: BorderRadius.circular(5)),
//     //                       ),
//     //                     ),
//     //                     Container(
//     //                       width: width * 0.02,
//     //                     ),
//     //                     const SizedBox(
//     //                       height: 82,
//     //                       child: Column(
//     //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     //                         children: [
//     //                           Text(
//     //                             'Device Name',
//     //                             style: TextStyle(
//     //                               color: Colors.black,
//     //                               fontSize: 13,
//     //                               fontFamily: 'Manrope',
//     //                               fontWeight: FontWeight.w400,
//     //                             ),
//     //                           ),
//     //                           Text(
//     //                             'Device Detail',
//     //                             style: TextStyle(
//     //                               color: Colors.black,
//     //                               fontSize: 13,
//     //                               fontFamily: 'Manrope',
//     //                               fontWeight: FontWeight.w400,
//     //                             ),
//     //                           ),
//     //                         ],
//     //                       ),
//     //                     )
//     //                   ],
//     //                 ),
//     //               ),
//     //             );
//     //           },
//     //         ),
//     //       ),
//     //     ],
//     //   ),
//     // );
//   }
// }
