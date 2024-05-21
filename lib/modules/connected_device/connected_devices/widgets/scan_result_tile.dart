// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:weight_loss_app/common/app_assets.dart';

// class ScanResultTile extends StatefulWidget {
//   const ScanResultTile({
//     super.key,
//     required this.device,
//     this.onTap,
//   });

//   final BluetoothDevice device;
//   final VoidCallback? onTap;

//   @override
//   State<ScanResultTile> createState() => _ScanResultTileState();
// }

// class _ScanResultTileState extends State<ScanResultTile> {
//   Widget _buildTitle(BuildContext context) {
//     if (widget.device.platformName.isNotEmpty) {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             widget.device.platformName,
//             overflow: TextOverflow.ellipsis,
//           ),
//           Text(
//             widget.device.remoteId.toString(),
//             style: Theme.of(context).textTheme.bodySmall,
//           )
//         ],
//       );
//     } else {
//       return Text(widget.device.remoteId.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: widget.onTap,
//       child: Container(
//         height: MediaQuery.sizeOf(context).height * 0.1,
//         width: MediaQuery.sizeOf(context).width,
//         color: Colors.transparent,
//         margin: const EdgeInsets.all(8),
//         child: Row(
//           children: [
//             Flexible(
//               flex: 3,
//               child: Center(
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 8),
//                   decoration: ShapeDecoration(
//                     color: const Color(0xFFD9D9D9),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5)),
//                   ),
//                   child: Center(
//                     child: widget.device.platformName.isNotEmpty
//                         ? SvgPicture.asset(
//                             AppAssets.smartWatchUrl,
//                             fit: BoxFit.fitWidth,
//                             height: MediaQuery.sizeOf(context).height * 0.1,
//                           )
//                         : SvgPicture.asset(
//                             AppAssets.mobileDeviceUrl,
//                             height: MediaQuery.sizeOf(context).height * 0.095,
//                           ),
//                   ),
//                 ),
//               ),
//             ),
//             Flexible(
//               flex: 7,
//               child: _buildTitle(context),
//             ),
//           ],
//         ),
//       ),
//     );

//     //  ListTile(
//     //   leading: widget.device.platformName.isNotEmpty
//     //       ? SvgPicture.asset(
//     //           'assets/smart_watch_1.svg',
//     //           fit: BoxFit.fitWidth,
//     //         )
//     //       : SvgPicture.asset(
//     //           'assets/mobile_device_1.svg',
//     //         ),
//     //   title: _buildTitle(context),
//     //   onTap: widget.onTap,
//     // );
//   }
// }
