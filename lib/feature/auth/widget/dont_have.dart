import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/utils/colors.dart';
import '../../../shared/utils/custom_styles.dart';

class DontHave extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const DontHave({Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: AppStyles.smallText
                .copyWith(color: AppColors.cabyLightBlue, fontSize: 12.sp),
          )),
    );
  }
}
