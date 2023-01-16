import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../navigation/navigation_service.dart';

class DialogUtil {
  static void showLoadingDialog(BuildContext context, {String? text}) {
    showGeneralDialog(
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierDismissible: false,
        transitionDuration: const Duration(milliseconds: 200),
        context: context,
        pageBuilder: (_, __, ___) {
          return const Material(
            type: MaterialType.transparency,
            child: Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator()),
          );
        },
        transitionBuilder: (_, anim, __, child) {
          return SlideTransition(
            position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
                .animate(anim),
            child: child,
          );
        });
  }

  static void dismissLoadingDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static void dismissWithNavigationService() {
    GetIt.I.get<NavigationService>().back();
  }
}
