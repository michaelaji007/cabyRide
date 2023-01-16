import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/utils/asset_images.dart';
import '../../../shared/utils/colors.dart';
import '../model/card_model.dart';
import '../model/method_model.dart';

class PaymentMethodWidget extends StatefulWidget {
  final VoidCallback onTap;
  final PaymentMethod method;

  const PaymentMethodWidget({
    Key? key,
    required this.method,
    required this.onTap,
  }) : super(key: key);

  @override
  State<PaymentMethodWidget> createState() => _PaymentMethodWidgetState();
}

class _PaymentMethodWidgetState extends State<PaymentMethodWidget> {
  String? image;
  PaymentMethod? method;
  @override
  void initState() {
    method = widget.method;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Column(
          children: [
            Row(children: [
              if (widget.method.payload != null)
                SvgPicture.asset(CardIssuer.values
                    .firstWhere(
                        (element) => element == widget.method.payload!.cardType)
                    .image)
              else if (widget.method.paymentMethodType == "CASH")
                SvgPicture.asset(AssetResources.CARD)
              else
                SvgPicture.asset(AssetResources.ADD_CARD),
              SizedBox(width: 10.h),
              if (widget.method.payload != null)
                Text(
                  "**** ${widget.method.payload?.last4}" ?? "",
                  style: GoogleFonts.poppins(
                      fontSize: 16.sp, fontWeight: FontWeight.w500),
                )
              else
                Text(
                  widget.method.paymentMethodType ?? "",

                  // ? "**** ${widget.method.last4}"
                  // : widget.method.last4!,
                  style: GoogleFonts.poppins(
                      fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
              const Spacer(),
              Visibility(
                visible: widget.method.preferredPaymentMethod!,
                child: Container(
                  padding: EdgeInsets.all(5.h),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.cabyLightGreen,
                  ),
                  child: Icon(
                    Icons.check,
                    size: 13.sp,
                    color: Colors.white,
                  ),
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
