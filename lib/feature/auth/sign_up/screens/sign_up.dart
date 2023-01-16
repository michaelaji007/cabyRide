import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_caby_rider/shared/widgets/messenger.dart';

import '../../../../configs/app_startup.dart';
import '../../../../shared/navigation/navigation_service.dart';
import '../../../../shared/utils/asset_images.dart';
import '../../../../shared/utils/dialog.dart';
import '../../../../shared/widgets/form/custom_text_field.dart';
import '../../../home/widget/set_destination_2.dart';
import '../../route/routes.dart';
import '../../widget/auth_welcome.dart';
import '../../widget/custom_bottom_button.dart';
import '../../widget/dont_have.dart';
import '../cubits/sign_up_cubit.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? email;
  bool isVisiblePassword = true;
  String? phone;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetResources.BANN),
                  fit: BoxFit.cover,
                ),
              ),
              // child:
            ),
            const AuthWelcome(
              boldText: "Welcome,",
              smallText: 'Sign up and join the family',
            ),
            SizedBox(height: 55.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      type: FieldType.phone,
                      textInputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11)
                      ],
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Field is Required";
                        }
                        phone = v;
                        return null;
                      },
                      header: "Enter phone number",
                    ),
                    CustomTextField(
                      type: FieldType.email,
                      validator: (v) {
                        if (v!.trim().isEmpty) {
                          return "Email is required";
                        } else if (!EmailValidator.validate(
                            v.replaceAll(" ", "").trim())) {
                          return "Email is invalid";
                        }
                        email = v;
                        return null;
                      },
                      textActionType: ActionType.next,
                      header: "Email Address (Optional)",
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40.h),
            DontHave(
              onPressed: () {
                getIt<NavigationService>().to(routeName: AuthRoutes.login);
              },
              text: "Already have an account",
            ),
            SizedBox(height: 20.h),
            BlocConsumer(
                bloc: getIt<SignUpCubit>(),
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
                    getIt<NavigationService>().pushReplace(
                        routeName: AuthRoutes.verificationScreen,
                        args: {
                          "email": email,
                          "phone": phone,
                          "fromScreen": FromScreen.registration
                        });
                  }
                },
                builder: (context, state) {
                  return SizedBox();
                }),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            requestOTP();
          }

          // getIt<NavigationService>()
          //     .to(routeName: AuthRoutes.verificationScreen);
        },
        text: "Register",
      ),
    );
  }

  requestOTP() {
    getIt<SignUpCubit>().sendOTP(phone, false, email: email);
  }
}
