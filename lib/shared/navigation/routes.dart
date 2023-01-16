import 'package:flutter/material.dart';
import 'package:go_caby_rider/feature/auth/sign_up/screens/sign_up.dart';
import 'package:go_caby_rider/feature/home/root.dart';
import 'package:go_caby_rider/shared/navigation/animations/slide_up.dart';

import '../../feature/auth/login/screens/login.dart';
import '../../feature/auth/route/routes.dart';
import '../../feature/auth/sign_up/screens/registration_success.dart';
import '../../feature/auth/sign_up/screens/verification_screen.dart';
import '../../feature/auth/splash_page.dart';
import '../../feature/history/root.dart';
import '../../feature/history/route/routes.dart';
import '../../feature/history/widget/history_details.dart';
import '../../feature/home/route/routes.dart';
import '../../feature/home/widget/driver_on_its_way.dart';
import '../../feature/home/widget/ride_success.dart';
import '../../feature/home/widget/select_ride.dart';
import '../../feature/home/widget/set_destination_2.dart';
import '../../feature/payment/root.dart';
import '../../feature/payment/route/routes.dart';
import '../../feature/profile/root.dart';
import '../../feature/profile/route/routes.dart';
import '../../feature/profile/widget/lost_an_item.dart';
import '../../feature/profile/widget/report_miscoduct.dart';
import 'animations/fade_route.dart';

// ignore: prefer_function_declarations_over_variables
var routes = (RouteSettings settings) {
  switch (settings.name) {
    case AuthRoutes.initial:
      return FadeRoute(
        page: const SplashScreen(),
      );
    case AuthRoutes.login:
      return FadeRoute(
        page: const LoginPage(),
      );
    case AuthRoutes.signup:
      return FadeRoute(
        page: const SignUp(),
      );
    case AuthRoutes.verificationScreen:
      Map? args = settings.arguments as Map;
      return FadeRoute(
        page: VerificationScreen(
          phone: args["phone"],
          email: args["email"],
          fromScreen: args["fromScreen"],
        ),
      );
    case AuthRoutes.registrationSuccess:
      return FadeRoute(
        page: const RegistrationSuccess(),
      );

    //  HomeRoutes
    case HomeRoutes.home:
      return FadeRoute(
        page: HomeScreen(),
      );

    case HomeRoutes.setDestination:
      Map? args = settings.arguments as Map;
      return FadeRoute(
        page: SetDestination(
          dropOff: args["dropOff"],
          pickUp: args["pickUp"],
          from: args["from"],
        ),
      );

    case HomeRoutes.selectRide:
      Map args = settings.arguments as Map;
      return FadeRoute(
        page: SelectRide(
          dropOff: args["dropOff"],
          pickUp: args["pickUp"],
          model: args["model"],
        ),
      );
    case HomeRoutes.driverOnTheWay:
      Map args = settings.arguments as Map;
      return FadeRoute(
        page: DriverOnTheWay(
          dropOff: args["dropOff"],
          pickUp: args["pickUp"],
          request: args["request"],
        ),
      );

    case HomeRoutes.rideSuccessful:
      Map args = settings.arguments as Map;
      return SlideUpRoute(
        page: RideSuccessful(
          driverInfo: args["driverInfo"],
        ),
      );

    //   history

    case HistoryRoutes.history:
      return FadeRoute(
        page: const History(),
      );

    case HistoryRoutes.historyDetails:
      Map args = settings.arguments as Map;
      return FadeRoute(
        page: HistoryDetails(
          tripHistoryModel: args["tripHistoryModel"],
        ),
      );

    //    payment

    case PaymentRoutes.paymentMethod:
      return FadeRoute(
        page: const Payment(),
      );

    case ProfileRoutes.profile:
      return FadeRoute(
        page: const Profile(),
      );

    case ProfileRoutes.lostAnItem:
      return FadeRoute(
        page: const LostAnItem(),
      );

    case ProfileRoutes.reportMisconduct:
      return FadeRoute(
        page: const ReportMisconduct(),
      );
  }

  return null;
};
