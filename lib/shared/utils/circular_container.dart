import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularContainer extends StatelessWidget {
  final Widget child;
  final Color? color;
  const CircularContainer({Key? key, required this.child, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32.w,
      height: 32.h,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Center(child: child),
    );
  }
}
