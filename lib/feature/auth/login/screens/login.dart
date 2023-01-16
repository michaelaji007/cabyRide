import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_caby_rider/configs/app_startup.dart';
import 'package:go_caby_rider/shared/widgets/messenger.dart';

import '../../../../shared/navigation/navigation_service.dart';
import '../../../../shared/utils/asset_images.dart';
import '../../../../shared/utils/dialog.dart';
import '../../../../shared/widgets/form/custom_text_field.dart';
import '../../../home/widget/set_destination_2.dart';
import '../../route/routes.dart';
import '../../sign_up/cubits/sign_up_cubit.dart';
import '../../widget/auth_welcome.dart';
import '../../widget/custom_bottom_button.dart';
import '../../widget/dont_have.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  bool isVisiblePassword = true;
  String? phone;
  String? email;
  TextEditingController eml = TextEditingController();
  TextEditingController phn = TextEditingController();
  bool isValid = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AnimationController? controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetResources.BANN),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25.h),
                const AuthWelcome(
                  boldText: "Welcome,",
                  smallText: 'Enter Phone to continue',
                ),
                SizedBox(height: 25.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: Form(
                    key: _formKey,
                    onChanged: () {
                      isValid = _formKey.currentState!.validate();
                      setState(() {});
                    },
                    child: Column(
                      children: [
                        CustomTextField(
                          type: FieldType.phone,
                          textEditingController: phn,
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
                          textEditingController: eml,
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
                // LinearProgressIndicator(
                //   value: controller!.value,
                // ),
                SizedBox(height: 40.h),
                DontHave(
                  onPressed: () {
                    getIt<NavigationService>().to(routeName: AuthRoutes.signup);
                  },
                  text: "New on Caby?",
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
                              "fromScreen": FromScreen.login
                            });
                      }
                    },
                    builder: (context, state) {
                      return const SizedBox();
                    }),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: CustomBottomButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            sendOtp();
          }
        },
        text: "Sign in",
      ),
    );
  }

  sendOtp() {
    _formKey.currentState!.validate();
    getIt<SignUpCubit>().sendOTP(
      phone,
      true,
    );
  }
}
