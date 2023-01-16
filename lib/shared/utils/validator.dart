import '../../configs/app_configs.dart';

class Validator {
  static bool showIcon = false;
  static bool showNameIcon = false;
  static bool showEmailIcon = false;
  static bool showPasswordIcon = false;
  static bool showConfirmIcon = false;

  static String? validateMobile(value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,11}$)';
    RegExp regExp = RegExp(pattern);
    if (value != null) {
      if (value!.length == 0) {
        showIcon = false;
        return "Enter Your Phone Number";
      } else if (!regExp.hasMatch(value)) {
        showIcon = false;
        return "Enter Your Phone Number";
      }
    }
    showIcon = true;
    return null;
  }

  bool validateStructure(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  // static String? validateFirstName(fullName) {
  //   String pattern = r'^[a-z A-Z,.\-]+$';
  //   RegExp regExp = RegExp(pattern);
  //   if (fullName != null) {
  //     if (fullName!.length == 0) {
  //       return S.current.enterValidName;
  //     } else if (!regExp.hasMatch(fullName)) {
  //       return S.current.enterValidName;
  //     }
  //   }
  //
  //   return null;
  // }

  // static String? validateStartTime(fieldValue) {
  //   String pattern = r'^[a-z A-Z 0-9]';
  //   RegExp regExp = RegExp(pattern);
  //   if (fieldValue == null || fieldValue.toString().isEmpty) {
  //     return S.current.startTimeRequired;
  //   } else if (!regExp.hasMatch(fieldValue)) {
  //     return S.current.startTimeRequired;
  //   }
  //   return null;
  // }

  // static String? validateDiscount(fieldValue) {
  //   String pattern = r'^[0-9]';
  //   RegExp regExp = RegExp(pattern);
  //   if (fieldValue == null || fieldValue.toString().isEmpty) {
  //     return S.current.discountRequired;
  //   } else if (!regExp.hasMatch(fieldValue)) {
  //     return S.current.discountRequired;
  //   }
  //   return null;
  // }

  // static String? validateMinOrderAmount(fieldValue) {
  //   String pattern = r'^[0-9]';
  //   RegExp regExp = RegExp(pattern);
  //   if (fieldValue == null || fieldValue.toString().isEmpty) {
  //     return S.current.minOrderAmountRequired;
  //   } else if (!regExp.hasMatch(fieldValue)) {
  //     return S.current.minOrderAmountRequired;
  //   }
  //   return null;
  // }

  // static String? validatePercent(fieldValue) {
  //   String pattern = r'^[0-9]';
  //   RegExp regExp = RegExp(pattern);
  //   if (fieldValue == null || fieldValue.toString().isEmpty) {
  //     return S.current.percentRequired;
  //   } else if (!regExp.hasMatch(fieldValue)) {
  //     return S.current.percentRequired;
  //   }
  //   return null;
  // }
  //
  // static String? validateMinOrderValue(fieldValue) {
  //   String pattern = r'^[0-9]';
  //   RegExp regExp = RegExp(pattern);
  //   if (fieldValue == null || fieldValue.toString().isEmpty) {
  //     return S.current.minOrderValueRequired;
  //   } else if (!regExp.hasMatch(fieldValue)) {
  //     return S.current.minOrderValueRequired;
  //   }
  //   return null;
  // }

  // static String? validateLastName(fullName) {
  //   String pattern = r'^[a-z A-Z,.\-]+$';
  //   RegExp regExp = RegExp(pattern);
  //   if (fullName != null) {
  //     if (fullName!.length == 0) {
  //       return S.current.lastName;
  //     } else if (!regExp.hasMatch(fullName)) {
  //       return S.current.enterValidName;
  //     }
  //   }
  //
  //   return null;
  // }

  // static String? validateEmail(value) {
  //   var pattern = r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$';
  //   RegExp regex = RegExp(pattern);
  //   if (value != null) {
  //     if (value!.isEmpty) {
  //       showEmailIcon = false;
  //       return S.current.emailIsRequired;
  //     } else if (!regex.hasMatch(value)) {
  //       showEmailIcon = false;
  //       return S.current.validEmailRequired;
  //     }
  //   }
  //
  //   showEmailIcon = true;
  //   return null;
  // }

  static String? requiredValidator<T>(T? value, String? message) {
    if (value == null || value.toString().isEmpty) {
      if (message != null) {
        return "$message is required";
      } else {
        return AppConstants.thisFieldIsRequired;
      }
    }

    return null;
  }

  static String? requiredFourValidator(String? value, String? message) {
    if (value == null || value.length < 4) {
      return message ?? AppConstants.thisFieldIsRequired;
    }
    return null;
  }

  // static String? validateMaxDiscount(fieldValue) {
  //   String pattern = r'^[0-9]';
  //   RegExp regExp = RegExp(pattern);
  //   if (fieldValue == null || fieldValue.toString().isEmpty) {
  //     return S.current.maxDiscountRequired;
  //   } else if (!regExp.hasMatch(fieldValue)) {
  //     return S.current.maxDiscountRequired;
  //   }
  //   return null;
  // }

  static String? required11Validator(String? value, String? message) {
    if (value == null || value.length < 11) {
      return message ?? AppConstants.thisFieldIsRequired;
    }
    return null;
  }

  static String? required10Validator(String? value, String? message) {
    if (value == null || value.length < 10) {
      return "$message is required";
    }
    return null;
  }
}
