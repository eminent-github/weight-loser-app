// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'dart:async';

// class ConnectedDeviceController extends GetxController
//     with GetSingleTickerProviderStateMixin {
//   late TabController tabController;
//   // ignore: prefer_final_fields
//   Rx<BluetoothAdapterState> adapterState = BluetoothAdapterState.unknown.obs;

//   late StreamSubscription<BluetoothAdapterState> adapterStateStateSubscription;

//   @override
//   void onInit() {
//     tabController = TabController(length: 2, vsync: this);

//     adapterStateStateSubscription =
//         FlutterBluePlus.adapterState.listen((state) {
//       adapterState.value = state;
//       log("message-----------$state");
//     });
//     super.onInit();
//   }

//   @override
//   void onClose() {
//     adapterStateStateSubscription.cancel();
//     super.onClose();
//   }

//   List<Widget> list = [
//     const Tab(
//         child: Text(
//       'All',
//     )),
//     const Tab(
//         child: Text(
//       'Connected',
//     )),
//   ];
// }
