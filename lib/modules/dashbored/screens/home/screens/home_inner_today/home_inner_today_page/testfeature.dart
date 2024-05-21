// import 'package:app_tutorial/app_tutorial.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:weight_loss_app/modules/dashbored/screens/home/screens/home_inner_today/controller/home_inner_today_controller.dart';

// class TestFeatureScreen extends StatefulWidget {
//   final String title;
//   const TestFeatureScreen({super.key, required this.title});

//   @override
//   State<TestFeatureScreen> createState() => _TestFeatureScreenState();
// }

// class _TestFeatureScreenState extends State<TestFeatureScreen> {
//   @override
//   // List<TutorialItem> items = [];
//   // int _counter = 0;

//   final incrementKey = GlobalKey();
//   final avatarKey = GlobalKey();
//   final textKey = GlobalKey();
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   void initItems() {
//     items.addAll({
//       TutorialItem(
//         globalKey: textKey,
//         shapeFocus: ShapeFocus.square,
//         borderRadius: const Radius.circular(15.0),
//         child: const TutorialItemContent(
//           title: 'Counter text',
//           content: 'This is the text that displays the status of the counter',
//         ),
//       ),
//       TutorialItem(
//         globalKey: incrementKey,
//         color: Colors.black.withOpacity(0.6),
//         borderRadius: const Radius.circular(15.0),
//         shapeFocus: ShapeFocus.roundedSquare,
//         child: const TutorialItemContent(
//           title: 'Increment button',
//           content: 'This is the increment button',
//         ),
//       ),
//       TutorialItem(
//         globalKey: avatarKey,
//         color: Colors.black.withOpacity(0.6),
//         shapeFocus: ShapeFocus.oval,
//         child: const TutorialItemContent(
//           title: 'Avatar',
//           content: 'This is the avatar that displays something',
//         ),
//       ),
//     });
//   }

//   @override
//   void initState() {
//     initItems();
//     Future.delayed(const Duration(microseconds: 200)).then((value) {
//       Tutorial.showTutorial(context, items, onTutorialComplete: () {
//         // Code to be executed after the tutorial ends
//         print('Tutorial is complete!');
//       });
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//         leading: Icon(
//           Icons.add_circle_outline_rounded,
//           key: avatarKey,
//         ),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               key: textKey,
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         key: incrementKey,
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// class TutorialItemContent extends StatefulWidget {
//   const TutorialItemContent({
//     super.key,
//     required this.title,
//     required this.content,
//     this.onPressed,
//   });

//   final String title;
//   final String content;
//   final void Function()? onPressed;

//   @override
//   State<TutorialItemContent> createState() => _TutorialItemContentState();
// }

// class _TutorialItemContentState extends State<TutorialItemContent> {
//   var controller = Get.put(HomeInnerTodayController());

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;

//     return Center(
//       child: SizedBox(
//         // height: MediaQuery.of(context).size.height * 0.6,
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: width * 0.1),
//           child: Column(
//             children: [
//               Text(
//                 widget.title,
//                 style: const TextStyle(color: Colors.white),
//               ),
//               const SizedBox(height: 10.0),
//               Text(
//                 widget.content,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(color: Colors.white),
//               ),
//               const Spacer(),
//               Row(
//                 children: [
//                   TextButton(
//                     onPressed: () {
//                       print('this is skip');
//                       Tutorial.skipAll(context);
//                     },
//                     child: const Text(
//                       'Skip onboarding',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   const Spacer(),
//                   TextButton(
//                     onPressed: scrollToNextTutorial,
//                     // null,

//                     child: const Text(
//                       'Next',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void scrollToNextTutorial() {
//     if (controller.currentTutorialIndex < controller.items.length) {
//       controller.currentTutorialIndex++;
//       controller.scrollController.animateTo(
//         controller.currentTutorialIndex *
//             (MediaQuery.of(context).size.width + 16),
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.ease,
//       );
//     } else {
//       Tutorial.skipAll(context);
//     }
//   }
// }
