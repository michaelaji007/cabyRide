import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:go_caby_rider/feature/auth/route/routes.dart';
import 'package:go_caby_rider/feature/auth/sign_up/model/user.dart';

import '../../configs/app_configs.dart';
import '../../configs/app_startup.dart';
import '../../shared/navigation/navigation_service.dart';
import '../../shared/utils/colors.dart';
import '../../shared/utils/storage.dart';
import '../home/route/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late bool isFirstTime;

  @override
  void initState() {
    // GetIt.I<AnalyticService>().addEvent(name: "App_Launched");

    isUserFirstTime().then((value) => isFirstTime = value);

    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));

    _animationController.forward();
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        GetIt.I.get<NavigationService>().to(
            routeName:
                // isFirstTime
                //     ? AuthRoutes.login
                getIt.isRegistered<User>()
                    ? HomeRoutes.home
                    : AuthRoutes.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.darkBlue,
        body: Center(
            child: Text(
          "CABYRIDE",
          style: TextStyle(
              color: AppColors.cabyYellow,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold),
        )));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<bool> isUserFirstTime() async {
    var firstTime = await LocalStorageUtils.read(AppConstants.isUserFirstTime);
    return firstTime == null;
  }
}
