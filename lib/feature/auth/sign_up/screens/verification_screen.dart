import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_caby_rider/feature/auth/widget/auth_welcome.dart';
import 'package:go_caby_rider/shared/utils/colors.dart';
import 'package:go_caby_rider/shared/widgets/button.dart';
import 'package:go_caby_rider/shared/widgets/messenger.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../../../../configs/app_configs.dart';
import '../../../../configs/app_startup.dart';
import '../../../../shared/navigation/navigation_service.dart';
import '../../../../shared/network/network_request.dart';
import '../../../../shared/utils/dialog.dart';
import '../../../home/route/routes.dart';
import '../../../home/widget/set_destination_2.dart';
import '../../login/widget/otp_timer.dart';
import '../../route/routes.dart';
import '../cubits/sign_up_cubit.dart';
import '../services/api_service.dart';

// enum FromScreen { login, registration }

class VerificationScreen extends StatefulWidget {
  final String? phone;
  final String? email;
  final FromScreen? fromScreen;
  const VerificationScreen({Key? key, this.phone, this.email, this.fromScreen})
      : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen>
    with TickerProviderStateMixin {
  final _otpController = TextEditingController();
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: GoogleFonts.poppins(
        fontSize: 20, color: AppColors.darkBlue, fontWeight: FontWeight.w700),
    decoration: BoxDecoration(
      color: const Color(0xffEBD703),
      borderRadius: BorderRadius.circular(30),
    ),
  );

  bool isPasswordVisible = true;
  TextEditingController? controller;
  String? otp;
  String? password;
  bool isButtonEnabled = false;
  bool _hideResendButton = true;
  late Timer timer;
  int totalTimeInSeconds = 0;

  late AnimationController _controller;
  final int time = 10;
  SignUpCubit signUpCubit = SignUpCubit(
    apiService: SignUpApiService(
      http:
          HttpService(baseUrl: AppURL.baseAccountUrl, hasAuthorization: false),
    ),
  );

  @override
  void initState() {
    totalTimeInSeconds = time;
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: time))
          ..addStatusListener((status) {
            if (status == AnimationStatus.dismissed) {
              setState(() {
                _hideResendButton = !_hideResendButton;
              });
            }
          });
    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
    _startCountdown();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cabyYellow,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 150.h),
            const AuthWelcome(
                boldText: 'Verification code',
                smallText:
                    "Enter the 6 digits verification code sent to your phone"),
            SizedBox(height: 70.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Center(
                child: Pinput(
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  onCompleted: (v) {
                    verify(v);
                  },
                  controller: _otpController,
                ),
              ),
            ),
            Spacer(),
            _hideResendButton
                ? _getTimerText
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: InkWell(
                        onTap: () {
                          if (widget.fromScreen == FromScreen.registration) {
                            signUpCubit.sendOTP(widget.phone, false,
                                email: widget.email);
                          } else {
                            signUpCubit.sendOTP(widget.phone, true,
                                email: widget.email);
                          }

                          _startCountdown();
                        },
                        child: Text(
                          "Resend OTP",
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.darkBlue,
                              fontWeight: FontWeight.w600),
                        )),
                  ),
            SizedBox(height: 30.h),
            Center(
              child: AppButton(
                text: "Verify",
                onPressed: () {},
              ),
            ),
            SizedBox(height: 30.h),
            BlocConsumer(
                bloc: signUpCubit,
                listener: (_, state) {
                  if (state is ResendOtpLoading) {
                    DialogUtil.showLoadingDialog(context);
                  }
                  if (state is ResendOtpError) {
                    // getCouponDataList();
                    // selectedCategories.value.clear();
                    DialogUtil.dismissLoadingDialog(context);
                    NotificationMessage.showSuccess(context,
                        message: state.message);
                    // GetIt.I.get<NavigationService>().back();
                  }
                  if (state is ResendOtpSuccess) {
                    DialogUtil.dismissLoadingDialog(context);
                  }

                  if (state is VerifyOTPCodeLoading) {
                    DialogUtil.showLoadingDialog(context);
                  }
                  if (state is VerifyOTPCodeError) {
                    DialogUtil.dismissLoadingDialog(context);
                    NotificationMessage.showError(context,
                        message: state.message);
                  }
                  if (state is VerifyOTPCodeSuccess) {
                    DialogUtil.dismissLoadingDialog(context);
                    if (widget.fromScreen == FromScreen.registration) {
                      getIt<NavigationService>().pushReplace(
                          routeName: AuthRoutes.registrationSuccess);
                    } else {
                      getIt<NavigationService>()
                          .pushReplace(routeName: HomeRoutes.home);
                    }
                  }
                },
                builder: (context, state) {
                  return const SizedBox();
                }),
          ],
        ),
      ),
    );
  }

  get _getTimerText {
    return Offstage(
      offstage: !_hideResendButton,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OtpTimer(
              _controller,
              14.sp,
              AppColors.cabyLightBlue,
              text: "Resending",
            )
          ],
        ),
      ),
    );
  }

  Future<void> _startCountdown() async {
    setState(() {
      _hideResendButton = true;
      totalTimeInSeconds = time;
    });
    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
  }

  verify(otp) {
    signUpCubit.verifyOTPCode(otp, widget.phone);
  }
}
