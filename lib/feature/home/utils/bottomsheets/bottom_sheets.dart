import 'package:flutter/material.dart';

import '../../widget/pick_payment_method.dart';

var _roundedRectangleBorder = const RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(25),
    topLeft: Radius.circular(25),
  ),
);

void pickPaymentMethod({BuildContext? context}) {
  showModalBottomSheet(
    context: context!,
    barrierColor: barrierColor,
    shape: _roundedRectangleBorder,
    isScrollControlled: true,
    builder: (context) {
      return PickPaymentMethod();
    },
  );
}

Color barrierColor = const Color(0xff364A7D).withOpacity(0.85);
