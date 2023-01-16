import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'button.dart';

class ErrorEncountered extends StatelessWidget {
  final Function reload;
  const ErrorEncountered({Key? key, required this.reload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Unable to load data",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20.h,
          ),
          AppButton(
            text: "Try again",
            onPressed: () {
              reload();
            },
          )
        ],
      ),
    );
  }
}
