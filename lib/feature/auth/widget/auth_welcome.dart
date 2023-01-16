import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/utils/custom_styles.dart';

class AuthWelcome extends StatelessWidget {
  final String boldText;
  final String smallText;
  const AuthWelcome({Key? key, required this.boldText, required this.smallText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          boldText,
          // 'Welcome back',
          style: AppStyles.largeText,
        ),
        Text(smallText,
            // 'Sign in to continue',

            style: AppStyles.smallText)
      ]),
    );
  }
}
