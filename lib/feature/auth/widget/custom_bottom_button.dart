import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/utils/colors.dart';

class CustomBottomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final TextStyle? textStyle;
  const CustomBottomButton(
      {Key? key, required this.onPressed, required this.text, this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 80.h,
        color: AppColors.cabyYellow,
        child: Center(
            child: Text(
          text,
          style: textStyle ??
              GoogleFonts.poppins(fontSize: 22.sp, fontWeight: FontWeight.w400),
        )),
      ),
    );
  }
}
