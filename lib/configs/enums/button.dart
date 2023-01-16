import 'package:flutter/material.dart';

import '../../shared/utils/colors.dart';

enum ButtonType {
  primary,
  secondary,
  tertiary,
  green,
}

extension ButtonTypeExt on ButtonType {
  Color get buttonColor {
    switch (this) {
      case ButtonType.primary:
        return AppColors.darkBlue;
      case ButtonType.secondary:
        return AppColors.cabyGreen;
      case ButtonType.tertiary:
        return Colors.transparent;
      case ButtonType.green:
        return AppColors.cabyGreen;
    }
  }

  Color get disabledColor {
    switch (this) {
      case ButtonType.primary:
        return AppColors.darkBlue.withOpacity(0.5);
      case ButtonType.secondary:
        return AppColors.cabyGreen.withOpacity(0.5);
      case ButtonType.tertiary:
        return Colors.transparent.withOpacity(0.5);
      case ButtonType.green:
        return Colors.transparent;
    }
  }

  Color get borderColor {
    switch (this) {
      case ButtonType.primary:
        return AppColors.darkBlue;
      case ButtonType.secondary:
        return AppColors.cabyGreen;
      case ButtonType.tertiary:
        return Colors.red;
      case ButtonType.green:
        return Colors.transparent;
    }
  }

  Color get textColor {
    switch (this) {
      case ButtonType.primary:
        return Colors.white;
      case ButtonType.secondary:
        return Colors.white;
      case ButtonType.tertiary:
        return Colors.red;
      case ButtonType.green:
        return Colors.white;
    }
  }
}
