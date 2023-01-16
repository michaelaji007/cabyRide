import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class DisplayUtils {
  // number formatter
  static String formatNumber(double number, {bool withDecimals = true}) {
    // format number based on decimals flag
    var format = withDecimals ? '#,###.00' : '#,###';
    var formatter = NumberFormat(format, 'en_US');
    return formatter.format(number);
  }

  static String formatAmount(int amount, {bool withDecimals = true}) {
    var formattedNumber =
        formatNumber(amount / 100.00, withDecimals: withDecimals);
    return formattedNumber;
  }

  static String formatPrice(double amount, {bool withDecimals = false}) {
    var formattedNumber =
        formatNumber(amount.toDouble(), withDecimals: withDecimals);
    return formattedNumber;
  }

  static String formateDate({date}) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat.MMMd().format(dateTime);
    String formattedTime = DateFormat.jm().format(dateTime).toLowerCase();
    // DateFormat('hh:mm aaa').format(date).toLowerCase();
    return "$formattedDate  $formattedTime";
  }

  static String formateDateOnly({date}) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat.MMMd().format(dateTime);

    return "$formattedDate  ";
  }

  static String formateToTimeAgo({String? date}) {
    DateTime dateTime = DateTime.parse(date!);

    // String formattedDate = DateFormat.MMMd().format(dateTime);
    // String formattedTime = DateFormat.jm().format(dateTime).toLowerCase();
    // DateFormat('hh:mm aaa').format(date).toLowerCase();
    return Jiffy(dateTime).fromNow();
  }

  static String formateDateFormat({date}) {
    String formattedDate = DateFormat('dd MMMM yyyy').format(date);
    // String formattedTime = DateFormat.jm().format(date).toLowerCase();
    // DateFormat('hh:mm aaa').format(date).toLowerCase();
    return formattedDate;
  }

  static String formateBirthDate({date}) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDate;
  }

  static String formateActiveOrderDate({date}) {
    DateTime dateTime = DateTime.parse(date!);
    String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
    String formattedTime =
        DateFormat('hh:mm aaa').format(dateTime).toLowerCase();
    return "$formattedDate  $formattedTime";
  }

  static String formateTime({date}) {
    String formattedTime = DateFormat.jm().format(date).toLowerCase();
    // DateFormat('hh:mm aaa').format(date).toLowerCase();
    return formattedTime;
  }

  static String getObscuredNumberWithSpaces(
      {required String? string,
      String obscureValue = '*',
      String space = ' '}) {
    assert(
        !(string!.length < 8),
        'Card Number $string must be more than 8 '
        'characters and above');
    assert(obscureValue.length == 1);
    var length = string!.length;
    var buffer = StringBuffer();
    for (int i = 0; i < string.length; i++) {
      if (i < (length - 4)) {
        // The numbers before the last digits is changed to X
        buffer.write(obscureValue);
      } else {
        // The last four numbers are spared
        buffer.write(string[i]);
      }
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != string.length) {
        buffer.write(space);
      }
    }
    return buffer.toString();
  }

  // static Future selectDate({context, int? addedDay, DateTime? firstDate,}) async {
  //   DateTime today = DateTime.now();
  //   DateTime? selectedDate = await showDatePicker(
  //       context: context,
  //       initialDate: today,
  //       firstDate: firstDate ?? DateTime(2000),
  //       lastDate: DateTime(2035),
  //       builder: (BuildContext context, Widget? child) {
  //         return Theme(
  //           data: ThemeData.dark().copyWith(
  //             colorScheme: ColorScheme.dark(
  //               primary: Colors.deepPurple,
  //               onPrimary: Colors.white,
  //               surface: AppColors.zeptaPurple,
  //               onSurface: Colors.black,
  //             ),
  //             dialogBackgroundColor:Colors.white,
  //           ),
  //           child: child!,
  //         )
  //       },
  //       confirmText: 'Okay',
  //       cancelText: 'Not now',
  //       selectableDayPredicate: (DateTime d) {
  //         if (d.isBefore(DateTime.now().add(Duration(days: addedDay!)))) {
  //           return true;
  //         }
  //         return false;
  //       });
  //
  //   return selectedDate;
  // }
}

// extension GroupingBy<T> on Iterable<T> {
//   Map<String, List<dynamic>> groupBy(String key) {
//     var result = <String, List<T>>{};
//     for (var element in this) {
//       result[element[key]] = (result[element[key]] ?? [])..add(element);
//     }
//     return result;
//   }

// extension Iterables<E> on Iterable<E> {
//   Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) {
//     // accumulator to hold the group (key to list)
//     Map<K, List<E>> accumulator = {};
//
//     // fold function
//     var foldFunc = (Map<K, List<E>> map, E element) {
//       return map
//         // add key with empty list if key is not currently present
//         ..putIfAbsent(keyFunction(element), () => <E>[])
//             // add element to map using
//             .add(element);
//     };
//
//     // fold the list into a group (Map of lists)
//     return fold(accumulator, foldFunc);
//     //return foldFunc;
//   }
// }
