// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
//
// import '../../generated/l10n.dart';
// import '../utils/asset_images.dart';
// import '../utils/colors.dart';
// import 'country_code_picker/lib/country_picker.dart';
// import 'country_code_picker/lib/src/utils.dart';
//
// class CountryCodeWidget extends StatefulWidget {
//   final TextEditingController? countryCodeController;
//   const CountryCodeWidget({Key? key, this.countryCodeController})
//       : super(key: key);
//
//   @override
//   State<CountryCodeWidget> createState() => _CountryCodeWidgetState();
// }
//
// class _CountryCodeWidgetState extends State<CountryCodeWidget> {
//   Country? _selectedCountry;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         GestureDetector(
//           onTap: () => showCountryPicker(
//             context: context,
//             favorite: <String>['NG'],
//             showPhoneCode: true,
//             onSelect: (Country country) {
//               _selectedCountry = country;
//               setState(() {});
//             },
//             countryListTheme: CountryListThemeData(
//               bottomSheetHeight: 778.h,
//               borderRadius: BorderRadius.vertical(
//                 top: Radius.circular(16.r),
//               ),
//               inputDecoration: InputDecoration(
//                 hintText: S.current.enterYourCountryName,
//                 prefixIcon: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 14.w),
//                   child: SvgPicture.asset(
//                     AssetResources.SEARCH_ICON,
//                     width: 20.w,
//                     height: 20.w,
//                     color: AppColors.zeptaGrayscale[20]!,
//                   ),
//                 ),
//                 hintStyle: TextStyle(
//                   fontSize: 12.sp,
//                   fontWeight: FontWeight.w500,
//                 ),
//                 border: OutlineInputBorder(
//                   borderSide: BorderSide(color: AppColors.zeptaGrayscale[60]!),
//                   borderRadius: BorderRadius.circular(8.r),
//                 ),
//                 filled: true,
//                 fillColor: AppColors.zeptaGrayscale[60],
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
//               ),
//             ),
//           ),
//           child: Container(
//               width: 69.w,
//               height: 39.92.h,
//               padding: EdgeInsets.symmetric(
//                 horizontal: 9.w,
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(19.5.r),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(100.r),
//                     child: Center(
//                       child: Text(
//                         _selectedCountry == null
//                             ? ''
//                             : Utils.countryCodeToEmoji(
//                                 _selectedCountry!.countryCode),
//                         style: TextStyle(fontSize: 23.sp, height: 1),
//                       ),
//                     ),
//                   ),
//                   Icon(
//                     Icons.keyboard_arrow_down_rounded,
//                     size: 20.w,
//                     color: AppColors.zeptaGrayscale[10],
//                   ),
//                 ],
//               )),
//         ),
//         SizedBox(width: 12.w),
//         RichText(
//           text: TextSpan(
//             text: '| ',
//             style: TextStyle(
//               height: 1.26,
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w400,
//               color: AppColors.zeptaPurple,
//             ),
//             children: [
//               if (_selectedCountry != null)
//                 TextSpan(
//                   text: '${_selectedCountry?.phoneCode}-',
//                   style: TextStyle(
//                     height: 1.26,
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.zeptaGrayscale[40],
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
