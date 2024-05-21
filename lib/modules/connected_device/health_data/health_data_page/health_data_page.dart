// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_loss_app/common/app_keys.dart';
import 'package:weight_loss_app/common/app_text_styles.dart';
import 'package:weight_loss_app/modules/connected_device/health_data/controller/health_data_controller.dart';

class HealthDataPage extends GetView<HealthDataController> {
  const HealthDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Health Example',
          style: AppTextStyles.formalTextStyle(),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          if (controller.storage.hasData(AppKeys.offlineConnectedAuth)) {
            if (controller.storage.read(AppKeys.offlineConnectedAuth)) {
              controller.fetchData();
            } else {
              controller.authorize();
            }
          } else {
            controller.authorize();
          }
        },
        child: Obx(
          () => Column(
            children: [
              // Wrap(
              //   spacing: 10,
              //   children: [
              //     TextButton(
              //         onPressed: controller.authorize,
              //         style: const ButtonStyle(
              //             backgroundColor:
              //                 MaterialStatePropertyAll(Colors.blue)),
              //         child: const Text("Authenticate",
              //             style: TextStyle(color: Colors.white))),
              //     if (Platform.isAndroid)
              //       TextButton(
              //           onPressed: controller.getHealthConnectSdkStatus,
              //           style: const ButtonStyle(
              //               backgroundColor:
              //                   MaterialStatePropertyAll(Colors.blue)),
              //           child: const Text("Check Health Connect Status",
              //               style: TextStyle(color: Colors.white))),
              //     TextButton(
              //         onPressed: controller.fetchData,
              //         style: const ButtonStyle(
              //             backgroundColor:
              //                 MaterialStatePropertyAll(Colors.blue)),
              //         child: const Text("Fetch Data",
              //             style: TextStyle(color: Colors.white))),
              //     // TextButton(
              //     //     onPressed: controller.fetchStepData,
              //     //     style: const ButtonStyle(
              //     //         backgroundColor:
              //     //             MaterialStatePropertyAll(Colors.blue)),
              //     //     child: const Text("Fetch Step Data",
              //     //         style: TextStyle(color: Colors.white))),
              //     // TextButton(
              //     //     onPressed: controller.revokeAccess,
              //     //     style: const ButtonStyle(
              //     //         backgroundColor:
              //     //             MaterialStatePropertyAll(Colors.blue)),
              //     //     child: const Text("Revoke Access",
              //     //         style: TextStyle(color: Colors.white))),
              //     if (Platform.isAndroid)
              //       TextButton(
              //           onPressed: controller.installHealthConnect,
              //           style: const ButtonStyle(
              //               backgroundColor:
              //                   MaterialStatePropertyAll(Colors.blue)),
              //           child: const Text("Install Health Connect",
              //               style: TextStyle(color: Colors.white))),
              //   ],
              // ),
              // const Divider(thickness: 3),
              Expanded(
                child: Center(
                  child: controller.content,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
