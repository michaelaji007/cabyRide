import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_caby_rider/feature/payment/cubits/payment_cubit.dart';
import 'package:go_caby_rider/feature/payment/model/method_model.dart';
import 'package:go_caby_rider/feature/payment/widget/payment_method_widget.dart';
import 'package:go_caby_rider/shared/widgets/messenger.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../configs/app_startup.dart';
import '../../shared/utils/colors.dart';
import '../../shared/utils/dialog.dart';
import '../../shared/widgets/zepta_app_bar.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  var txRef;
  // = "gocaby-${DateTime.now().millisecondsSinceEpoch}";
  final _formKey = GlobalKey<FormState>();
  String? cardNumber;
  bool inProgress = false;
  String? cvv;
  int? expiryMonth;
  int? expiryYear;
  List<PaymentMethod> allMethods = [];
  List<PaymentMethod> another = [
    PaymentMethod(
        id: null,
        paymentMethodType: "Add payment card",
        payload: null,
        preferredPaymentMethod: false),
  ];
  @override
  void initState() {
    getcards();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(),
            const HeaderText(
              text: "Payment",
              subText: "Please, select your payment method",
            ),
            SizedBox(height: 40.h),
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Payment Method",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 11.sp,
                        color: AppColors.cabyGrey),
                  ),
                  SizedBox(height: 20.h),
                  BlocConsumer(
                    bloc: getIt<PaymentCubit>(),
                    listener: (context, state) {
                      if (state is GetCardsLoading) {}
                      if (state is GetCardsSuccess) {
                        allMethods = (state.methods);
                        allMethods.addAll(another);
                      }
                      if (state is GetCardsError) {}

                      if (state is SendTxRefLoading) {
                        DialogUtil.showLoadingDialog(context);
                      }
                      if (state is SendTxRefSuccess) {
                        DialogUtil.dismissLoadingDialog(context);
                        getcards();
                      }
                      if (state is SendTxRefError) {
                        DialogUtil.dismissLoadingDialog(context);
                        NotificationMessage.showError(context,
                            message: state.message);
                      }

                      if (state is SetPrefLoading) {
                        DialogUtil.showLoadingDialog(context);
                      }
                      if (state is SetPrefSuccess) {
                        DialogUtil.dismissLoadingDialog(context);
                        getcards();
                      }
                      if (state is SetPrefError) {
                        DialogUtil.dismissLoadingDialog(context);
                        NotificationMessage.showError(context,
                            message: state.message);
                      }
                    },
                    builder: (context, state) {
                      if (state is GetCardsLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is GetCardsError) {
                        return const SizedBox();
                      }

                      return Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              if (allMethods[index].paymentMethodType ==
                                      "CASH" ||
                                  allMethods[index].paymentMethodType ==
                                      "Add payment card") {
                                return PaymentMethodWidget(
                                  method: allMethods[index],
                                  onTap: () {
                                    if (allMethods[index].paymentMethodType !=
                                        "Add payment card") {
                                      setPref(
                                          allMethods[index].paymentMethodType,
                                          allMethods[index].id);
                                    } else if (allMethods[index]
                                            .paymentMethodType ==
                                        "Add payment card") {}
                                  },
                                );
                              }
                              return Dismissible(
                                key: Key(
                                    allMethods[index].payload!.uuid.toString()),
                                background: Container(
                                  color: Colors.red,
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: const <Widget>[
                                      Icon(
                                        Icons.delete,
                                      )
                                    ],
                                  ),
                                ),
                                onDismissed: (direction) {
                                  setState(() {
                                    allMethods.removeAt(index);
                                  });
                                  deleteCard(allMethods[index].payload!.uuid);
                                  NotificationMessage.showSuccess(context,
                                      message: "Card removed successfully");
                                },
                                child: PaymentMethodWidget(
                                  method: allMethods[index],
                                  onTap: () {
                                    if (allMethods[index].paymentMethodType !=
                                        "Add payment card") {
                                      setPref(
                                          allMethods[index].paymentMethodType,
                                          allMethods[index].id);
                                    } else if (allMethods[index]
                                            .paymentMethodType ==
                                        "Add payment card") {}
                                  },
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(
                                color: AppColors.cabyGrey,
                                // height: 50.h,
                              );
                            },
                            itemCount: allMethods.length),
                      );
                    },
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  void getcards() {
    getIt<PaymentCubit>().getPaymentMethod();
  }

  void setPref(paymentMethod, value) {
    getIt<PaymentCubit>().setPrefPaymentMethod(paymentMethod, value);
  }

  void deleteCard(id) {
    getIt<PaymentCubit>().deleteCard(id);
  }
}
