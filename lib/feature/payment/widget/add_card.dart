// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:go_caby_rider/shared/utils/asset_images.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../../shared/models/payment_card.dart';
// import '../../../shared/utils/card_utils.dart';
// import '../../../shared/utils/card_validator.dart';
// import '../../../shared/utils/colors.dart';
// import '../../../shared/utils/input_formatters.dart';
// import '../../../shared/utils/strings.dart';
// import '../../../shared/widgets/button.dart';
// import '../../../shared/widgets/form/custom_text_field.dart';
// import '../../../shared/widgets/zepta_app_bar.dart';
//
// class AddCard extends StatefulWidget {
//   const AddCard({Key? key}) : super(key: key);
//
//   @override
//   State<AddCard> createState() => _AddCardState();
// }
//
// class _AddCardState extends State<AddCard> {
//   TextEditingController numberController = TextEditingController();
//   PaymentCard cardInfo = PaymentCard();
//
//   @override
//   void dispose() {
//     // Clean up the controller when the Widget is removed from the Widget tree
//     numberController.removeListener(_getCardTypeFrmNumber);
//     numberController.dispose();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     cardInfo.issuer = 0;
//     numberController.addListener(_getCardTypeFrmNumber);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Header(),
//             const HeaderText(
//               text: "Card",
//               subText: "Add payment card",
//             ),
//             SizedBox(height: 40.h),
//             Expanded(
//                 child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 20.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Enter your details",
//                     style: GoogleFonts.poppins(
//                         fontWeight: FontWeight.w400,
//                         fontSize: 11.sp,
//                         color: AppColors.cabyGrey),
//                   ),
//                   SizedBox(height: 30.h),
//                   CustomTextField(
//                     type: FieldType.phone,
//                     textInputFormatters: getNumberFormatter(),
//                     textEditingController: numberController,
//                     suffix: _getCardIcon(),
//                     onSubmit: (String value) {
//                       cardInfo.number =
//                           CardUtils.getCleanedNumber(numberController.text);
//                     },
//                     validator: (v) {
//                       if (v!.isEmpty) {
//                         return "Field is Required";
//                       }
//                       return null;
//                     },
//                     header: "Card number",
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: CustomTextField(
//                           type: FieldType.phone,
//                           textInputFormatters: [
//                             FilteringTextInputFormatter.digitsOnly,
//                             LengthLimitingTextInputFormatter(4),
//                             MonthInputFormatter()
//                           ],
//
//                           validator: CardValidator.validateDate,
//                           header: "Card Date",
//                           onSubmit: (value) {
//                             List<int> expiryDate =
//                                 CardValidator.getExpiryDate(value);
//                             cardInfo.month = expiryDate[0].toString();
//                             cardInfo.year = expiryDate[1].toString();
//                           },
//                           // prefixIcon: Icons.business_sharp,
//                         ),
//                       ),
//                       SizedBox(
//                         width: 30.w,
//                       ),
//                       Expanded(
//                         child: CustomTextField(
//                           type: FieldType.phone,
//                           textInputFormatters: [
//                             FilteringTextInputFormatter.digitsOnly,
//                             LengthLimitingTextInputFormatter(4),
//                           ],
//
//                           onSubmit: (String value) {
//                             cardInfo.cvv = value;
//                           },
//                           validator: CardValidator.validateCVV,
//                           header: "CVV",
//
//                           // prefixIcon: Icons.business_sharp,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 40.h),
//                   AppButton(
//                     text: "Add Card",
//                     onPressed: () {},
//                   )
//                 ],
//               ),
//             ))
//           ],
//         ),
//       ),
//     );
//   }
//
//   String? validateCardNumWithLuhnAlgorithm(String value) {
//     if (value.isEmpty) {
//       return Strings.fieldReq;
//     }
//   }
//
//   void _getCardTypeFrmNumber() {
//     String input = CardValidator.getCleanedNumber(numberController.text);
//     CardIssuer cardType = CardValidator.getCardIssuerFrmNumber(input);
//     setState(() {
//       cardInfo.setIssuer(cardType);
//     });
//   }
//
//   List<TextInputFormatter> getNumberFormatter() {
//     var formatter = [
//       FilteringTextInputFormatter.digitsOnly,
//       LengthLimitingTextInputFormatter(19),
//     ];
//
//     formatter.add(NumberInputFormatter());
//
//     return formatter;
//   }
//
//   Widget _getCardIcon() {
//     String img = "";
//     Icon? icon;
//     switch (cardInfo.getIssuer()) {
//       case CardIssuer.master:
//         img = AssetResources.MASTER_CARDS;
//         // 'mastercard.svg';
//         break;
//       case CardIssuer.visa:
//         img = AssetResources.VISA_CARD;
//         break;
//       case CardIssuer.verve:
//         img = 'verve.svg';
//         break;
//       case CardIssuer.unknown:
//         icon = Icon(
//           Icons.warning,
//           size: 20.sp,
//           color: Colors.red,
//         );
//         break;
//     }
//     print(img);
//     Widget widget;
//     if (img.isNotEmpty) {
//       widget = SvgPicture.asset(
//         img,
//         height: 20.h,
//         width: 30.w,
//       );
//     } else {
//       widget = icon!;
//     }
//     return widget;
//   }
// }
