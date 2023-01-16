import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:go_caby_rider/shared/navigation/navigation_service.dart';
import 'package:go_caby_rider/shared/navigation/routes.dart';

import 'configs/app_startup.dart';
import 'configs/theme.dart';
import 'feature/auth/route/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.landscapeLeft]);
  await AppStartUp().setUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, child) => GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild?.unfocus();
          }
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'CabyRide',
          themeMode: ThemeMode.light,
          theme: AppTheme.lightThemeData,
          navigatorKey: GetIt.I<NavigationService>().navigatorKey,
          initialRoute: AuthRoutes.initial,
          onGenerateRoute: routes,
        ),
      ),
    );
  }
}
