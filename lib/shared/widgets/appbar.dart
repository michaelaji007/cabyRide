// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get_it/get_it.dart';
// import 'package:zepta_supplier/shared/utils/colors.dart';
// import 'package:zepta_supplier/shared/utils/font_family.dart';
// import 'package:zepta_supplier/shared/widgets/divider.dart';
//
// import '../navigation/navigation_service.dart';
// import '../utils/asset_images.dart';
//
// class ZeptaAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final Widget? leadingIcon;
//   final String? titleText;
//   final Widget? titleWidget;
//   final Widget? trailing;
//   final Color? backgroundColor;
//   final bool centerTitle;
//   final double? elevation;
//   final Color? shadowColor;
//   final double? appHeight;
//   final double? leadingWidth;
//   final bool showUnderline;
//
//   const ZeptaAppBar(
//       {Key? key,
//       this.leadingIcon,
//       this.titleText,
//       this.titleWidget,
//       this.trailing,
//       this.centerTitle = true,
//       this.elevation = 0,
//       this.shadowColor = Colors.white,
//       this.backgroundColor,
//       this.leadingWidth = 56.0,
//       this.appHeight = 60,
//       this.showUnderline = false})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       elevation: elevation,
//       shadowColor: shadowColor,
//       backgroundColor: backgroundColor ?? AppColors.zeptaWhite,
//       leadingWidth: leadingWidth,
//       toolbarHeight: 74.h,
//       centerTitle: centerTitle,
//       bottom: PreferredSize(
//         preferredSize: Size(1.sw, 1.h),
//         child: showUnderline ? ZeptaDivider(height: 1.h) : const SizedBox(),
//       ),
//       title: titleWidget ??
//           Text(
//             titleText ?? "",
//             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                   fontSize: 14.sp,
//                   color: AppColors.zeptaGrayscale[10],
//                   fontWeight: FontWeight.w600,
//                   fontFamily: FontFamily.plusJakartaSans,
//                 ),
//           ),
//       leading: leadingIcon ??
//           GestureDetector(
//             onTap: () {
//               GetIt.I.get<NavigationService>().back();
//             },
//             child: SvgPicture.asset(
//               AssetResources.KEYBOARD_BACK_ICON,
//               height: 24.h,
//               width: 24.w,
//               fit: BoxFit.scaleDown,
//             ),
//           ),
//       actions: [trailing ?? const SizedBox()],
//     );
//   }
//
//   @override
//   Size get preferredSize => Size.fromHeight(appHeight!);
// }
