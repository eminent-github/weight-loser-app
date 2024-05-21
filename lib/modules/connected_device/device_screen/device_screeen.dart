// import 'dart:async';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:weight_loss_app/common/app_assets.dart';
// import 'package:weight_loss_app/common/app_colors.dart';
// import 'package:weight_loss_app/common/app_text_styles.dart';
// import 'package:weight_loss_app/modules/connected_device/connected_devices/widgets/characteristic_tile.dart';
// import 'package:weight_loss_app/modules/connected_device/connected_devices/widgets/descriptor_tile.dart';
// import 'package:weight_loss_app/modules/connected_device/connected_devices/widgets/service_tile.dart';
// import 'package:weight_loss_app/modules/connected_device/utils/extras.dart';

// import '../connected_devices/widgets/snaclbar.dart';

// class DeviceScreen extends StatefulWidget {
//   final BluetoothDevice device;

//   const DeviceScreen({super.key, required this.device});

//   @override
//   State<DeviceScreen> createState() => _DeviceScreenState();
// }

// class _DeviceScreenState extends State<DeviceScreen> {
//   int? _rssi;
//   int? _mtuSize;
//   BluetoothConnectionState _connectionState =
//       BluetoothConnectionState.disconnected;
//   List<BluetoothService> _services = [];
//   bool _isDiscoveringServices = false;
//   bool _isConnecting = false;
//   bool _isDisconnecting = false;

//   late StreamSubscription<BluetoothConnectionState>
//       _connectionStateSubscription;
//   late StreamSubscription<bool> _isConnectingSubscription;
//   late StreamSubscription<bool> _isDisconnectingSubscription;
//   late StreamSubscription<int> _mtuSubscription;

//   @override
//   void initState() {
//     super.initState();

//     _connectionStateSubscription =
//         widget.device.connectionState.listen((state) async {
//       _connectionState = state;
//       if (state == BluetoothConnectionState.connected) {
//         _services = []; // must rediscover services
//       }
//       if (state == BluetoothConnectionState.connected && _rssi == null) {
//         _rssi = await widget.device.readRssi();
//       }
//       if (mounted) {
//         setState(() {});
//       }
//     });

//     _mtuSubscription = widget.device.mtu.listen((value) {
//       _mtuSize = value;
//       if (mounted) {
//         setState(() {});
//       }
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
//     _mtuSubscription.cancel();
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
//       if (e is FlutterBluePlusException &&
//           e.code == FbpErrorCode.connectionCanceled.index) {
//         // ignore connections canceled by the user
//       } else {
//         Snackbar.show(ABC.c, prettyException("Connect Error:", e),
//             success: false);
//       }
//     }
//   }

//   Future onCancelPressed() async {
//     try {
//       await widget.device.disconnectAndUpdateStream(queue: false);

//       Snackbar.show(ABC.c, "Cancel: Success", success: true);
//     } catch (e) {
//       Snackbar.show(ABC.c, prettyException("Cancel Error:", e), success: false);
//     }
//   }

//   Future onDisconnectPressed(BuildContext context) async {
//     try {
//       await widget.device.disconnectAndUpdateStream();
//       Navigator.pop(context);
//       Snackbar.show(ABC.c, "Disconnect: Success", success: true);
//     } catch (e) {
//       Snackbar.show(ABC.c, prettyException("Disconnect Error:", e),
//           success: false);
//     }
//   }

//   Future onDiscoverServicesPressed() async {
//     if (mounted) {
//       setState(() {
//         _isDiscoveringServices = true;
//       });
//     }
//     try {
//       _services = await widget.device.discoverServices();
//       Snackbar.show(ABC.c, "Discover Services: Success", success: true);
//     } catch (e) {
//       Snackbar.show(ABC.c, prettyException("Discover Services Error:", e),
//           success: false);
//     }
//     if (mounted) {
//       setState(() {
//         _isDiscoveringServices = false;
//       });
//     }
//   }

//   Future onRequestMtuPressed() async {
//     try {
//       await widget.device.requestMtu(223, predelay: 0);
//       Snackbar.show(ABC.c, "Request Mtu: Success", success: true);
//     } catch (e) {
//       Snackbar.show(ABC.c, prettyException("Change Mtu Error:", e),
//           success: false);
//     }
//   }

//   List<Widget> _buildServiceTiles(BuildContext context, BluetoothDevice d) {
//     return _services
//         .map(
//           (s) => ServiceTile(
//             service: s,
//             characteristicTiles: s.characteristics
//                 .map((c) => _buildCharacteristicTile(c))
//                 .toList(),
//           ),
//         )
//         .toList();
//   }

//   CharacteristicTile _buildCharacteristicTile(BluetoothCharacteristic c) {
//     return CharacteristicTile(
//       characteristic: c,
//       descriptorTiles:
//           c.descriptors.map((d) => DescriptorTile(descriptor: d)).toList(),
//     );
//   }

//   Widget buildSpinner(BuildContext context) {
//     return const CircularProgressIndicator(
//       backgroundColor: Colors.black12,
//       color: Colors.black26,
//     );
//   }

//   Widget buildRemoteId(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text('${widget.device.remoteId}'),
//     );
//   }

//   Widget buildRssiTile(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         isConnected
//             ? const Icon(Icons.bluetooth_connected)
//             : const Icon(Icons.bluetooth_disabled),
//         Text(((isConnected && _rssi != null) ? '${_rssi!} dBm' : ''),
//             style: Theme.of(context).textTheme.bodySmall)
//       ],
//     );
//   }

//   Widget buildGetServices(BuildContext context) {
//     return IndexedStack(
//       index: (_isDiscoveringServices) ? 1 : 0,
//       children: <Widget>[
//         TextButton(
//           onPressed: onDiscoverServicesPressed,
//           child: const Text("Get Services"),
//         ),
//         const IconButton(
//           icon: SizedBox(
//             width: 18.0,
//             height: 18.0,
//             child: CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation(Colors.grey),
//             ),
//           ),
//           onPressed: null,
//         )
//       ],
//     );
//   }

//   Widget buildMtuTile(BuildContext context) {
//     return ListTile(
//         title: const Text('MTU Size'),
//         subtitle: Text('$_mtuSize bytes'),
//         trailing: IconButton(
//           icon: const Icon(Icons.edit),
//           onPressed: onRequestMtuPressed,
//         ));
//   }

//   Widget buildConnectButton(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         if (_isConnecting || _isDisconnecting) buildSpinner(context),
//         TextButton(
//           onPressed: _isConnecting
//               ? onCancelPressed
//               : (isConnected
//                   ? () {
//                       onDisconnectPressed(context);
//                     }
//                   : onConnectPressed),
//           style: ButtonStyle(
//               backgroundColor: MaterialStatePropertyAll(AppColors.buttonColor)),
//           child: Text(
//             _isConnecting ? "CANCEL" : (isConnected ? "DISCONNECT" : "CONNECT"),
//             style: AppTextStyles.formalTextStyle(color: AppColors.white),
//           ),
//         ),
//       ],
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
//         appBar: AppBar(
//           title: Text(widget.device.platformName),
//         ),
//         body: SingleChildScrollView(
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
//                         children: [
//                           Text(
//                             widget.device.platformName.isEmpty
//                                 ? widget.device.remoteId.toString()
//                                 : widget.device.platformName,
//                             style: const TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w400,
//                               color: CupertinoColors.black,
//                               fontFamily: AppTextStyles.fontFamily,
//                             ),
//                           ),
//                           SizedBox(
//                             height: height * 0.01,
//                           ),
//                           buildConnectButton(context),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: height * 0.04,
//               ),
//               ListTile(
//                 leading: buildRssiTile(context),
//                 title: Text(
//                     'Device is ${_connectionState.toString().split('.')[1]}.'),
//                 trailing: buildGetServices(context),
//               ),
//               buildMtuTile(context),
//               ..._buildServiceTiles(context, widget.device),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
