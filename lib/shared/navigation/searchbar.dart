// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// import '../../../shared/utils/asset_images.dart';
// import '../../../shared/utils/font_family.dart';
// import '../utils/colors.dart';
//
// class SearchBar extends StatelessWidget {
//   final String hint;
//   final double borderRadius;
//   final TextEditingController controller;
//   final Function(String)? onChanged;
//   final Function()? onEditingComplete;
//   final Widget? suffix;
//   final Color? textColor;
//   final Color? backgroundColor;
//   const SearchBar(
//       {Key? key,
//       required this.hint,
//       required this.controller,
//       this.onChanged,
//       this.onEditingComplete,
//       this.backgroundColor,
//       this.suffix,
//       this.textColor,
//       this.borderRadius = 8})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: backgroundColor ?? AppColors.zeptaGrayscale[60],
//         borderRadius: BorderRadius.circular(borderRadius),
//       ),
//       height: 44.h,
//       width: 1.sw,
//       alignment: Alignment.center,
//       child: TextFormField(
//         controller: controller,
//         onFieldSubmitted: (value) {
//           // TODO: call the search and filter method
//         },
//         onChanged: onChanged,
//         onEditingComplete: onEditingComplete,
//         textAlignVertical: TextAlignVertical.top,
//         style: Theme.of(context).textTheme.titleMedium?.copyWith(
//               fontFamily: FontFamily.plusJakartaSans,
//               color: textColor ?? AppColors.zeptaGrayscale[20],
//               fontWeight: FontWeight.w500,
//               fontSize: 12.sp,
//             ),
//         decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
//                   fontFamily: FontFamily.plusJakartaSans,
//                   color: AppColors.zeptaGrayscale[20],
//                   fontWeight: FontWeight.w500,
//                   fontSize: 12.sp,
//                 ),
//             prefixIcon: SizedBox(
//               height: 20.h,
//               width: 10.w,
//               child: Center(
//                 child: SvgPicture.asset(
//                   AssetResources.SEARCH_ICON,
//                 ),
//               ),
//             ),
//             suffixIcon: SizedBox(
//               height: 20.h,
//               width: 30.w,
//               child: Center(
//                 child: suffix,
//               ),
//             ),
//             border: InputBorder.none,
//             focusedBorder: InputBorder.none,
//             enabledBorder: InputBorder.none,
//             disabledBorder: InputBorder.none),
//       ),
//     );
//   }
// }
