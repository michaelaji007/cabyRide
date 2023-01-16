// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:go_caby_rider/shared/utils/strings.dart';
//
// import '../../feature/payment/model/card_model.dart';
//
// class CardValidator {
//   static String? validateCVV(String? value) {
//     if (value!.isEmpty) {
//       return Strings.fieldReq;
//     }
//
//     if (value.length < 3 || value.length > 4) {
//       return "CVV is invalid";
//     }
//     return null;
//   }
//
//   static String? validateDate(String? value) {
//     if (value!.isEmpty) {
//       return Strings.fieldReq;
//     }
//
//     int? year;
//     int? month;
//     if (value.contains(RegExp(r'(\/)'))) {
//       var split = value.split(RegExp(r'(\/)'));
//       month = int.parse(split[0]);
//       year = int.tryParse(split[1]);
//     } else {
//       month = int.parse(value.substring(0, (value.length)));
//       year = -1;
//     }
//
//     if ((month < 1) || (month > 12)) {
//       return 'Expiry month is invalid';
//     }
//
//     var normalizeY = normalizeYear(year);
//     if ((normalizeY < 1) || (normalizeY > 2099)) {
//       return 'Expiry year is invalid';
//     }
//
//     if (!validExpiryDate(month, year)) {
//       return "Card has expired";
//     }
//     return null;
//   }
//
//   static String getEnteredNumLength(String text) {
//     String numbers = getCleanedNumber(text);
//     return '${numbers.length}/19';
//   }
//
//   static bool hasMonthPassed(int year, int month) {
//     var now = DateTime.now();
//     return hasYearPassed(year) ||
//         normalizeYear(year) == now.year && (month < now.month + 1);
//   }
//
//   static bool hasYearPassed(int year) {
//     int normalizedYear = normalizeYear(year);
//     var now = DateTime.now();
//     return normalizedYear < now.year;
//   }
//
//   // Convert two-digit year to full year if necessary
//   static int normalizeYear(int? year) {
//     if (year == null) {
//       return 0;
//     }
//     if (year < 100 && year >= 0) {
//       var now = DateTime.now();
//       String currentYear = now.year.toString();
//       String prefix = currentYear.substring(0, currentYear.length - 2);
//       year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
//     }
//     return year;
//   }
//
//   static bool isNotExpired(int year, int month) {
//     return !hasYearPassed(year) && !hasMonthPassed(year, month);
//   }
//
//   static bool validExpiryDate(int? month, int? year) {
//     // I am supposed to check for a valid month but I have already done that
//     return !(month == null || year == null) && isNotExpired(year, month);
//   }
//
//   static List<int> getExpiryDate(String value) {
//     var split = value.split(RegExp(r'(\/)'));
//     return [int.parse(split[0]), int.parse(split[1])];
//   }
//
//   static String getCleanedNumber(String text) {
//     RegExp regExp = RegExp(r"[^0-9]");
//     return text.replaceAll(regExp, '');
//   }
//
//   static bool _validCVV(String value) {
//     if (value.isEmpty) {
//       return false;
//     }
//
//     if (value.length < 3 || value.length > 4) {
//       return false;
//     }
//     return true;
//   }
//
//   static bool validCardNumWithLuhnAlgorithm(String value) {
//     if (value.isEmpty) {
//       return false;
//     }
//
//     String input = getCleanedNumber(value);
//
//     int sum = 0;
//     int length = input.length;
//     for (var i = 0; i < length; i++) {
//       // get digits in reverse order
//       int digit = int.parse(input[length - i - 1]);
//
//       // every 2nd number multiply with 2
//       if (i % 2 == 1) {
//         digit *= 2;
//       }
//       sum += digit > 9 ? (digit - 9) : digit;
//     }
//
//     if (sum % 10 == 0) {
//       return true;
//     }
//
//     return false;
//   }
//
//   // static List<String> getIssuesWithCard(PaymentCard? cardInfo) {
//   //   List<String> issues = [];
//   //   if (!validCardNumWithLuhnAlgorithm(cardInfo!.number!)) {
//   //     issues.add('Card number is not complete or invalid');
//   //   }
//   //
//   //   if (!validExpiryDate(
//   //       int.parse(cardInfo.month!), int.parse(cardInfo.year!))) {
//   //     issues.add('Expiry date is invalid or expired');
//   //   }
//   //
//   //   if (!_validCVV(cardInfo.cvv.toString())) {
//   //     issues.add('CVV is incomplete');
//   //   }
//   //
//   //   return issues;
//   // }
//
//   static Color getTextColorFrmCardIssuer(CardIssuer cardType) {
//     Color color;
//     switch (cardType) {
//       case CardIssuer.master:
//         color = Colors.white;
//         break;
//       case CardIssuer.visa:
//         color = Colors.white;
//         break;
//       case CardIssuer.verve:
//         color = Colors.black;
//         break;
//       case CardIssuer.unknown:
//         color = Colors.grey;
//         break;
//     }
//     return color;
//   }
//
//   static Widget getCardIcon(CardIssuer cardType,
//       [bool addPadding = true, double size = 40]) {
//     String img;
//     Color? color;
//     switch (cardType) {
//       case CardIssuer.master:
//         img = 'mastercard';
//         break;
//       case CardIssuer.visa:
//         img = 'visa';
//         break;
//       case CardIssuer.verve:
//         img = 'verve_card';
//         break;
//       case CardIssuer.unknown:
//         img = 'error';
//         color = Colors.red[600];
//         size = 20;
//         break;
//     }
//     var picture = SvgPicture.asset(
//       // 'assets/images/$img.svg',
//       width: size,
//       color: color,
//     );
//     return addPadding
//         ? Padding(
//             padding: EdgeInsets.symmetric(horizontal: 10),
//             child: picture,
//           )
//         : picture;
//   }
//
//   static String getCardIssuerStr(CardIssuer cardType) {
//     String type;
//     switch (cardType) {
//       case CardIssuer.master:
//         type = 'Mastercard';
//         break;
//       case CardIssuer.visa:
//         type = 'Visa';
//         break;
//       case CardIssuer.verve:
//         type = 'Verve';
//         break;
//       default:
//         type = 'Unkwnown';
//         break;
//     }
//     return type;
//   }
//
//   static String getObscuredNumberWithSpaces(String string) {
//     assert(
//         !(string.length < 8),
//         'Card Number $string must be more than 8 '
//         'characters and above');
//     var length = string.length;
//     var buffer = StringBuffer();
//     for (int i = 0; i < string.length; i++) {
//       if (i < (length - 4)) {
//         // The numbers before the last digits is changed to X
//         buffer.write('\u002A');
//       } else {
//         // The last four numbers are spared
//         buffer.write(string[i]);
//       }
//       var nonZeroIndex = i + 1;
//       if (nonZeroIndex % 4 == 0 && nonZeroIndex != string.length) {
//         buffer.write(' ');
//       }
//     }
//     return buffer.toString();
//   }
//
//   static String getObscuredCVV(String cvv) {
//     var buffer = StringBuffer();
//     for (var i = 0; i < cvv.length; i++) {
//       buffer.write('x');
//     }
//     return buffer.toString();
//   }
//
//   static CardIssuer getCardIssuerFrmNumber(String input) {
//     CardIssuer cardIssuer;
//     if (input.startsWith(RegExp(
//         r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
//       cardIssuer = CardIssuer.master;
//     } else if (input.startsWith(RegExp(r'[4]'))) {
//       cardIssuer = CardIssuer.visa;
//     } else if (input.startsWith(RegExp(r'((506(0|1))|(507(8|9))|(6500))'))) {
//       cardIssuer = CardIssuer.verve;
//     } else {
//       cardIssuer = CardIssuer.unknown;
//     }
//     return cardIssuer;
//   }
// }
