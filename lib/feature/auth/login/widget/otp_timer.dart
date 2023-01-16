import 'package:flutter/material.dart';

import '../../../../shared/utils/colors.dart';

class OtpTimer extends StatelessWidget {
  final AnimationController controller;
  final double fontSize;
  final String? text;
  Color timeColor = Colors.black;

  OtpTimer(this.controller, this.fontSize, this.timeColor,
      {Key? key, this.text})
      : super(key: key);

  String get timerString {
    Duration duration = controller.duration! * controller.value;
    if (duration.inHours > 0) {
      return '${duration.inHours}:${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }
    return '${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  Duration? get duration {
    Duration? duration = controller.duration;
    return duration;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          return RichText(
            text: TextSpan(
              text: text,
              style: TextStyle(
                  fontSize: fontSize,
                  color: AppColors.darkBlue,
                  fontWeight: FontWeight.w600),
              children: <TextSpan>[
                TextSpan(
                  text: " $timerString",
                  style: TextStyle(
                      fontSize: fontSize,
                      color: AppColors.darkBlue,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          );
        });
  }
}
