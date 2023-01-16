import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/utils/asset_images.dart';
import '../../../shared/utils/colors.dart';

class WhatYourDestination extends StatelessWidget {
  final VoidCallback onTap;
  const WhatYourDestination({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        height: 50.h,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.h),
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 10.w,
              width: 10.w,
              decoration: BoxDecoration(
                color: AppColors.darkBlue,
                borderRadius: BorderRadius.circular(6.r),
              ),
            ),
            Expanded(
                child: Center(
              child: TextField(
                  onTap: onTap,
                  readOnly: true,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintText: "What's your destination ?",
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: const Color(0xff959DAD)))),
            )),
            const VerticalDivider(
              color: Color(0xffEEF0F0),
              thickness: 2,
            ),
            SizedBox(
              width: 20.w,
            ),
            SvgPicture.asset(AssetResources.PIN)
          ],
        ));
  }
}
