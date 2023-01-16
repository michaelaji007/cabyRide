import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:go_caby_rider/shared/di.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../feature/auth/sign_up/di.dart';
import '../feature/auth/sign_up/model/user.dart';
import '../feature/home/di.dart';
import '../feature/payment/di.dart';
import '../shared/Location/location_services.dart';
import '../shared/notifications/firebase_notification_manager.dart';
import '../shared/utils/storage.dart';
import 'app_configs.dart';

// This is our global ServiceLocator
GetIt getIt = GetIt.instance;

class AppStartUp {
  Future<void> setUp() async {
    getIt.allowReassignment = true;
    await initializedFirebase();
    await registerServices(getIt);

    loadStartUpConfig();
    await firebasePushNotification();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    AppConfig.version = packageInfo.version;
    // Do not change the order of the 2 lines below this
    AppConstants.environment = Environment.staging;
    AppURL.environment = Environment.staging;
    AppConstants();
    AppURL();
  }

  Future<void> registerServices(ioc) async {
    setupSharedServices(ioc);
    setupAddressServices(ioc);

    setupSignUpServices(ioc);
    setupPaymentServices(ioc);
  }

  void loadStartUpConfig() async {
    // clear cached token if the app is a newly installed.
    var isFirstTime =
        await LocalStorageUtils.read(AppConstants.isUserFirstTime);
    if (isFirstTime != "true") {
      await const FlutterSecureStorage().deleteAll();
    }

    LocationService locationService = LocationService();
    locationService.determinePosition();

    var userObject =
        await LocalStorageUtils.readObject<User>(AppConstants.userObject);
    if (userObject != null) {
      User user = User.fromJson(userObject);
      getIt.registerSingleton<User>(user);
    }
  }

  Future<void> initializedFirebase() async {
    try {
      if (Platform.isIOS) {
        await Firebase.initializeApp(
            options: const FirebaseOptions(
          appId: '1:228448875084:ios:01459b78ba8967b5d73ae9',
          apiKey: '',
          projectId: "gocaby-prod-97583",
          messagingSenderId: '',
        ));
      } else {
        await Firebase.initializeApp();
      }
    } catch (ex) {
      // debugPrint(ex.toString());
    }
  }

  Future<void> firebasePushNotification() async {
    FirebaseNotificationManager notificationManager =
        FirebaseNotificationManager();
    await notificationManager.registerNotification();
    try {
      await notificationManager.deviceToken;
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }
}
