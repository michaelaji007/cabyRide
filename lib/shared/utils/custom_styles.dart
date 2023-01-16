import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';
import 'font_family.dart';

class AppStyles {
  final BuildContext context;
  AppStyles({required this.context});

  TextStyle smallBody({
    required Color color,
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    return Theme.of(context).textTheme.bodySmall!.copyWith(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
          fontFamily: FontFamily.plusJakartaSans,
          height: 1.4,
        );
  }

  TextStyle largeBody({
    required Color color,
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
          fontFamily: FontFamily.plusJakartaSans,
          height: 1.4,
        );
  }

  TextStyle mediumBody({
    required Color color,
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
          fontFamily: FontFamily.plusJakartaSans,
          height: 1.4,
        );
  }

  static TextStyle largeText = GoogleFonts.poppins(
      fontSize: 24.sp,
      color: AppColors.darkBlue,
      fontWeight: FontWeight.w700,
      height: 1.4);
  static TextStyle smallText = GoogleFonts.poppins(
      fontSize: 14.sp,
      color: AppColors.darkBlue,
      fontWeight: FontWeight.w400,
      height: 1.4);

  // static var focusBorder = OutlineInputBorder(
  //   borderRadius: BorderRadius.circular(8.r),
  //   borderSide: BorderSide(color: AppColors.zeptaGrayscale[20]!, width: 1.w),
  // );
  // static var focusedBorder = OutlineInputBorder(
  //   borderRadius: BorderRadius.circular(8.r),
  //   borderSide:
  //       BorderSide(color: AppColors.zeptaGrayscale[20] as Color, width: 1.w),
  // );

  // static customTextStyle(double fontSize, Color? color, FontWeight fontWeight,
  //         double? height) =>
  //     TextStyle(
  //       fontSize: fontSize,
  //       color: color,
  //       fontWeight: fontWeight,
  //       height: height,
  //     );
  //
  // static TextStyle style = TextStyle(
  //     color: AppColors.zeptaGrayscale[40],
  //     fontSize: 15.sp,
  //     fontWeight: FontWeight.w500);
  //
  // static TextStyle style3 = TextStyle(
  //     color: AppColors.zeptaGrayscale[10],
  //     fontSize: 14.sp,
  //     fontWeight: FontWeight.w600);
  //
  // static TextStyle style2 = TextStyle(
  //     color: AppColors.zeptaGrayscale[50],
  //     fontSize: 12.sp,
  //     fontWeight: FontWeight.w400);
  //
  // static TextStyle verificationCodeStyle = TextStyle(
  //     fontSize: 24.sp,
  //     color: Colors.black,
  //     fontWeight: FontWeight.w600,
  //     height: 1.4);
  //
  // static var searchFocusBorder = OutlineInputBorder(
  //   borderRadius: BorderRadius.circular(8.r),
  //   borderSide: BorderSide(color: AppColors.textInputBorder, width: 1.w),
  // );
  // static var searchFocusedBorder = OutlineInputBorder(
  //   borderRadius: BorderRadius.circular(8.r),
  //   borderSide: BorderSide(color: AppColors.offWhite, width: 1.w),
  // );
  // static var searchFocusedTransparentBorder = OutlineInputBorder(
  //   borderRadius: BorderRadius.circular(8.r),
  //   borderSide: const BorderSide(color: Colors.transparent),
  // );
}
