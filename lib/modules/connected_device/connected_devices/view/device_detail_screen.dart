// import 'dart:async';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:weight_loss_app/common/app_assets.dart';
// import 'package:weight_loss_app/common/app_colors.dart';
// import 'package:weight_loss_app/common/app_text_styles.dart';
// import 'package:weight_loss_app/modules/connected_device/connected_devices/widgets/snaclbar.dart';
// import 'package:weight_loss_app/modules/connected_device/utils/extras.dart';

// class DeviceDetailScreen extends StatefulWidget {
//   final VoidCallback? onTap;
//   final BluetoothDevice device;
//   const DeviceDetailScreen({super.key, this.onTap, required this.device});

//   @override
//   State<DeviceDetailScreen> createState() => _DeviceDetailScreenState();
// }

// class _DeviceDetailScreenState extends State<DeviceDetailScreen> {
//   // BluetoothConnectionState _connectionState = BluetoothConnectionState.disconnected;
//   // late StreamSubscription<BluetoothConnectionState> _connectionStateSubscription;
//   // bool _isConnectingOrDisconnecting = false;

//   BluetoothConnectionState _connectionState =
//       BluetoothConnectionState.disconnected;

//   bool _isConnecting = false;
//   bool _isDisconnecting = false;

//   late StreamSubscription<BluetoothConnectionState>
//       _connectionStateSubscription;
//   late StreamSubscription<bool> _isConnectingSubscription;
//   late StreamSubscription<bool> _isDisconnectingSubscription;

//   @override
//   void initState() {
//     super.initState();

//     // _connectionStateSubscription = widget.result.device.connectionState.listen((state) {
//     //   _connectionState = state;
//     //   setState(() {});
//     // });

//     _connectionStateSubscription =
//         widget.device.connectionState.listen((state) async {
//       _connectionState = state;

//       setState(() {});
//     });

//     _isConnectingSubscription = widget.device.isConnecting.listen((value) {
//       _isConnecting = value;
//       if (mounted) {
//         setState(() {});
//       }
//     });

//     _isDisconnectingSubscription =
//         widget.device.isDisconnecting.listen((value) {
//       _isDisconnecting = value;
//       if (mounted) {
//         setState(() {});
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _connectionStateSubscription.cancel();

//     _isConnectingSubscription.cancel();
//     _isDisconnectingSubscription.cancel();
//     super.dispose();
//   }

//   bool get isConnected {
//     return _connectionState == BluetoothConnectionState.connected;
//   }

//   Future onConnectPressed() async {
//     try {
//       await widget.device.connectAndUpdateStream();
//       Snackbar.show(ABC.c, "Connect: Success", success: true);
//     } catch (e) {
//       print("Connect Error: $e");
//       Snackbar.show(ABC.c, prettyException("Connect Error:", e),
//           success: false);
//     }
//   }

//   Future onDisconnectPressed() async {
//     try {
//       await widget.device.disconnectAndUpdateStream();
//       Snackbar.show(ABC.c, "Disconnect: Success", success: true);
//     } catch (e) {
//       Snackbar.show(ABC.c, prettyException("Disconnect Error:", e),
//           success: false);
//     }
//   }

//   Widget buildConnectOrDisconnectButton(BuildContext context) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: AppColors.buttonColor,
//         foregroundColor: Colors.white,
//       ),
//       onPressed: isConnected ? onDisconnectPressed : onConnectPressed,
//       child: Text(
//         isConnected ? "DISCONNECT" : "CONNECT",
//         style: const TextStyle(
//           fontSize: 14,
//           fontWeight: FontWeight.w400,
//           color: CupertinoColors.white,
//           fontFamily: AppTextStyles.fontFamily,
//         ),
//       ),
//     );
//   }

//   Widget buildConnectButton(BuildContext context) {
//     if (_isConnecting || _isDisconnecting) {
//       return buildSpinner(context);
//     } else {
//       return buildConnectOrDisconnectButton(context);
//     }
//   }

//   Widget buildSpinner(BuildContext context) {
//     return const CircularProgressIndicator(
//       backgroundColor: Colors.black12,
//       color: Colors.black26,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.sizeOf(context);
//     double height = size.height;
//     double width = size.width;
//     return ScaffoldMessenger(
//       key: Snackbar.snackBarKeyC,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           elevation: 0,
//           toolbarHeight: height * 0.1,
//           backgroundColor: Colors.white,
//           title: Text(
//             "Device Detail",
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
//         body: SafeArea(
//           child: Column(
//             children: <Widget>[
//               SizedBox(
//                 height: height * 0.2,
//                 width: width,
//                 child: Row(
//                   children: [
//                     Flexible(
//                       flex: 5,
//                       child: Center(
//                         child: SvgPicture.asset(
//                           widget.device.platformName.isNotEmpty
//                               ? AppAssets.smartWatchUrl
//                               : AppAssets.mobileDeviceUrl,
//                           fit: BoxFit.fitHeight,
//                           height: height * 0.2,
//                         ),
//                       ),
//                     ),
//                     Flexible(
//                       flex: 5,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             widget.device.platformName.isEmpty
//                                 ? widget.device.remoteId.toString()
//                                 : widget.device.platformName,
//                             style: const TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w400,
//                                 color: CupertinoColors.black,
//                                 fontFamily: AppTextStyles.fontFamily),
//                           ),
//                           // _buildConnectButton(context),
//                           buildConnectButton(context),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
