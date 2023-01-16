// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:lottie/lottie.dart';
//
// class ZeptaLoader extends StatefulWidget {
//   const ZeptaLoader({
//     Key? key,
//   }) : super(key: key);
//   @override
//   _ZeptaLoaderState createState() => _ZeptaLoaderState();
// }
//
// class _ZeptaLoaderState extends State<ZeptaLoader>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );
//
//     // _controller.addStatusListener((status) {
//     //   if (status == AnimationStatus.completed) {
//     //     _controller.reverse();
//     //   } else if (status == AnimationStatus.dismissed) {
//     //     _controller.forward();
//     //   }
//     // });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Center(
//         child: Container(
//           height: 50.h,
//           width: 50.w,
//           decoration: const BoxDecoration(
//             shape: BoxShape.circle,
//             // color: Colors.white,
//           ),
//           child: Lottie.asset(
//             'assets/json/loader.json',
//             height: 30,
//             width: 30,
//             controller: _controller,
//             onLoaded: (composition) {
//               _controller
//                 ..forward()
//                 ..repeat(reverse: true);
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
