import 'package:flutter/material.dart';

import '../shared/utils/colors.dart';

class AppTheme {
  static ThemeData lightThemeData = ThemeData(
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: AppColors.darkBlue),
    fontFamily: 'Avenir',
    primaryColor: Colors.white,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    // scaffoldBackgroundColor: AppColors.background,
    focusColor: const Color(0xFFB9A994),
    // focusColor: AppColors.primaryActive,
    hintColor: Colors.black,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    dividerColor: Colors.transparent,
    // colorScheme: ColorScheme.fromSwatch().copyWith(
    //   secondary: const Color(0xFFB9A994),
    // ),
    // ignore: deprecated_member_use
    accentColor: AppColors.darkBlue,
    // accentColor: const Color(0xFFB9A994),
  );
}
