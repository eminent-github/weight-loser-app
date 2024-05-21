// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:weight_loss_app/common/app_text_styles.dart';
// import 'package:weight_loss_app/modules/connected_device/device_detail/controller/device_detail_controller.dart';
// import 'package:weight_loss_app/utils/internet_check_widget.dart';
// import 'package:weight_loss_app/widgets/custom_button_widget.dart';

// import '../../../../common/app_texts.dart';

// class DeviceDetailPage extends GetView<DeviceDetailController> {
//   const DeviceDetailPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: InternetCheckWidget<ConnectivityService>(
//         child: SafeArea(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: height * 0.02,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: width * 0.03),
//                 child: IconButton(
//                   onPressed: () {
//                     Get.back();
//                   },
//                   icon: const Icon(Icons.arrow_back),
//                 ),
//               ),
//               SizedBox(
//                 height: height * 0.02,
//               ),
//               Row(
//                 children: [
//                   SizedBox(
//                     width: width * 0.02,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(left: width * 0.06),
//                     child: Container(
//                       width: width * 0.45,
//                       height: height * 0.12,
//                       decoration: ShapeDecoration(
//                         color: const Color(0xFFD9D9D9),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(5)),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: width * 0.03,
//                   ),
//                   SizedBox(
//                     height: height * 0.1,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         const Text(
//                           AppTexts.deviceNameText,
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 14,
//                             fontFamily: AppTextStyles.fontFamily,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                         CustomButtonWidget(
//                           height: height * 0.045,
//                           width: width * 0.3,
//                           text: AppTexts.connectText,
//                           onPressed: () {},
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     width: width * 0.02,
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: height * 0.05,
//               ),
//               Center(
//                 child: SizedBox(
//                   width: width * 0.84,
//                   height: height * 0.55,
//                   child: const Text(
//                     AppTexts.deviceDetailParagraphText,
//                     textAlign: TextAlign.justify,
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 12,
//                       fontFamily: AppTextStyles.fontFamily,
//                       fontWeight: FontWeight.w400,
//                       height: 2.43,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
