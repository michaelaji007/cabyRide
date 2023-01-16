import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;
  final BoxDecoration decoration;

  ShimmerWidget.rectangle(
      {this.width = double.infinity, this.height, this.borderRadius = 0})
      : decoration = const BoxDecoration(shape: BoxShape.rectangle);

  ShimmerWidget.circle(
      {this.width = double.infinity, this.height, this.borderRadius = 0})
      : decoration = const BoxDecoration(shape: BoxShape.circle);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xffEEEFF2),
      highlightColor: const Color(0xffEEEFF2).withOpacity(0.4),
      child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius!),
            color: Colors.grey[400],
          )
          // ShapeDecoration(, shape: shapeBorder),
          ),
    );
  }
}
