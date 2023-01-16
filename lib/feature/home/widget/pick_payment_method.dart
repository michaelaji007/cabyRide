import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_caby_rider/shared/widgets/messenger.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../configs/app_startup.dart';
import '../../../shared/navigation/navigation_service.dart';
import '../../../shared/utils/colors.dart';
import '../../../shared/utils/dialog.dart';
import '../../../shared/widgets/zepta_app_bar.dart';
import '../../payment/cubits/payment_cubit.dart';
import '../../payment/model/method_model.dart';
import '../../payment/widget/payment_method_widget.dart';

class PickPaymentMethod extends StatefulWidget {
  const PickPaymentMethod({Key? key}) : super(key: key);

  @override
  State<PickPaymentMethod> createState() => _PickPaymentMethodState();
}

class _PickPaymentMethodState extends State<PickPaymentMethod> {
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
      height: 600.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () {
                    getIt<NavigationService>().back();
                  },
                  icon: const Icon(Icons.close))),
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
                            if (allMethods[index].paymentMethodType == "CASH" ||
                                allMethods[index].paymentMethodType ==
                                    "Add payment card") {
                              return PaymentMethodWidget(
                                method: allMethods[index],
                                onTap: () {
                                  if (allMethods[index].paymentMethodType !=
                                      "Add payment card") {
                                    setPref(allMethods[index].paymentMethodType,
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
                                    setPref(allMethods[index].paymentMethodType,
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

class MyLogo extends StatelessWidget {
  const MyLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Text(
        "GC",
        style: TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
