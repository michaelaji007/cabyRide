import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_caby_rider/shared/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/custom_styles.dart';

class Header extends StatelessWidget {
  final String? text;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final VoidCallback? preferredActionOnBackPressed;
  final Widget? suffix;
  final bool showPrefix;
  final Color? color;

  final Border? border;
  const Header({
    Key? key,
    this.text,
    this.color,
    this.border,
    this.showPrefix = true,
    this.textStyle,
    this.suffix,
    this.backgroundColor,
    this.preferredActionOnBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        showPrefix
            ? BackButton(
                onPressed: preferredActionOnBackPressed,
              )
            : Opacity(
                opacity: 0,
                child: BackButton(
                  onPressed: preferredActionOnBackPressed,
                )),
        // SizedBox(
        //   width: 5.w,
        // ),
        Text(
          text ?? "",
          style: textStyle ??
              GoogleFonts.poppins(
                color: AppColors.darkBlue,
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
              ),
        ),
        const Spacer(),
        suffix ??
            Opacity(
              opacity: 0,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 20.sp,
                ),
                onPressed: null,
              ),
            ),
      ],
    );
  }
}

class HeaderText extends StatelessWidget {
  final String? text;
  final String? subText;
  const HeaderText({Key? key, this.text, this.subText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text ?? "",
            style: AppStyles.largeText.copyWith(fontSize: 26.sp),
          ),
          Text(
            subText ?? "",
            style: AppStyles.smallText
                .copyWith(fontSize: 12.sp, color: AppColors.cabyGrey),
          )
        ],
      ),
    );
  }
}
