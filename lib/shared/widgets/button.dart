import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../configs/enums/button.dart';

class AppButton extends StatelessWidget {
  final Widget? child;
  final String? text;
  final ButtonType buttonType;
  final VoidCallback? onPressed;
  final bool? isLoading;
  final Color? color;
  final Color? borderColor;
  final double? verticalPadding;
  final TextStyle? textStyle;
  final double? radius;
  const AppButton(
      {Key? key,
      this.child,
      this.radius,
      this.color,
      this.text,
      this.borderColor,
      this.buttonType = ButtonType.primary,
      this.onPressed,
      this.isLoading,
      this.verticalPadding,
      this.textStyle})
      : assert(text != null || child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (onPressed != null) {
          FocusScope.of(context).unfocus();
          onPressed!();
        }
      },
      style: ButtonStyle(
        elevation: MaterialStateProperty.resolveWith<double>((states) => 0),
        padding: MaterialStateProperty.resolveWith<EdgeInsets>(
          (states) => EdgeInsets.symmetric(vertical: verticalPadding ?? 12.h),
        ),
        fixedSize: MaterialStateProperty.resolveWith<Size>(
          (states) => Size(334.w, 48.h),
        ),
        shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
          (states) => RoundedRectangleBorder(
            side: BorderSide(
              color: onPressed == null
                  ? Colors.transparent
                  : borderColor ?? color ?? buttonType.borderColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(radius ?? 8.r),
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled) || onPressed == null) {
              return buttonType.disabledColor;
            }
            return color ??
                buttonType.buttonColor; // Use the component's default.
          },
        ),
      ),
      child: (isLoading ?? false)
          ? _loadingWidget()
          : child ??
              Text(
                text!,
                style: textStyle ??
                    TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      height: 1,
                      fontFamily: text!.contains('₦') ? '' : 'Avenir',
                      color: buttonType.textColor,
                    ),
              ),
    );
  }
}

Widget _loadingWidget() => const Center(
      child: CircularProgressIndicator(
        color: Color(0xFFF4F4F4),
      ),
    );
