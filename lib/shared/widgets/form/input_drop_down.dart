// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../utils/colors.dart';
// import '../../utils/font_family.dart';
//
// class InputDropDown<T> extends StatelessWidget {
//   final ValueChanged<T?>? onChanged;
//   final T? selectedValue;
//   final List<T> items;
//   final FocusNode? focusNode;
//   final String? labelText;
//   final Widget? prefixIcon;
//   final String? textPlaceholder;
//   final FormFieldValidator<T?>? validator;
//   final FormFieldSetter<T?>? onSaved;
//   final String? headerText;
//   final String? hintText;
//   final Function(T) getLabel;
//   final bool isLoading;
//   const InputDropDown(
//       {Key? key,
//       this.onChanged,
//       this.selectedValue,
//       required this.items,
//       required this.labelText,
//       this.textPlaceholder,
//       this.focusNode,
//       this.validator,
//       this.headerText,
//       this.onSaved,
//       required this.getLabel,
//       this.prefixIcon,
//       this.isLoading = false,
//       this.hintText})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return _MaterialDropDown<T>(
//       onChanged: onChanged,
//       selectedValue: selectedValue,
//       items: items,
//       labelText: labelText,
//       textPlaceholder: textPlaceholder,
//       focusNode: focusNode,
//       validator: validator,
//       onSaved: onSaved,
//       headerText: headerText,
//       getLabel: getLabel,
//       prefixIcon: prefixIcon,
//       isLoading: isLoading,
//       hintText: hintText,
//     );
//     // return Platform.isIOS
//     //     ? _CupertinoDropDown<T>(
//     //         onChanged: onChanged,
//     //         selectedValue: selectedValue,
//     //         items: items,
//     //         labelText: labelText,
//     //         textPlaceholder: textPlaceholder,
//     //         focusNode: focusNode,
//     //         validator: validator,
//     //         onSaved: onSaved,
//     //         headerText: headerText,
//     //         getLabel: getLabel,
//     //         prefixIcon: prefixIcon,
//     //         isLoading: isLoading,
//     //         hintText: hintText,
//     //       )
//     //     : _MaterialDropDown<T>(
//     //         onChanged: onChanged,
//     //         selectedValue: selectedValue,
//     //         items: items,
//     //         labelText: labelText,
//     //         textPlaceholder: textPlaceholder,
//     //         focusNode: focusNode,
//     //         validator: validator,
//     //         onSaved: onSaved,
//     //         headerText: headerText,
//     //         getLabel: getLabel,
//     //         prefixIcon: prefixIcon,
//     //         isLoading: isLoading,
//     //         hintText: hintText,
//     //       );
//   }
// }
//
// class _CupertinoDropDown<T> extends StatelessWidget {
//   final ValueChanged<T?>? onChanged;
//   final T? selectedValue;
//   final List<T> items;
//   final FocusNode? focusNode;
//   final String labelText;
//   final Widget? prefixIcon;
//   final String? textPlaceholder;
//   final FormFieldValidator<T?>? validator;
//   final FormFieldSetter<T?>? onSaved;
//   final String? headerText;
//   final String? hintText;
//   final Function(T) getLabel;
//   final bool isLoading;
//   const _CupertinoDropDown(
//       {Key? key,
//       this.onChanged,
//       this.selectedValue,
//       required this.items,
//       required this.labelText,
//       this.textPlaceholder,
//       this.focusNode,
//       this.validator,
//       this.headerText,
//       this.onSaved,
//       required this.getLabel,
//       this.prefixIcon,
//       this.isLoading = false,
//       this.hintText})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // return   CupertinoPicker(
//     //   magnification: 1.22,
//     //   squeeze: 1.2,
//     //   useMagnifier: true,
//     //   itemExtent: 100.h,
//     //   // This is called when selected item is changed.
//     //   onSelectedItemChanged: (int selectedItem) {
//     //     onChanged(items[selectedItem]);
//     //   },
//     //   children:
//     //   List<Widget>.generate(items.length, (int index) {
//     //     return Center(
//     //       child: Text(
//     //         T
//     //       ),
//     //     );
//     //   }),
//     // );
//
//     return FormField<T>(
//       builder: (
//         FormFieldState<dynamic> field,
//       ) {
//         return CupertinoPicker(
//           magnification: 1.22,
//           squeeze: 1.2,
//           useMagnifier: true,
//           itemExtent: 100.h,
//           // This is called when selected item is changed.
//           onSelectedItemChanged: (int selectedItem) {
//             if (onChanged != null) {
//               onChanged!(items[selectedItem]);
//             }
//           },
//           children: items.map((e) => Text(getLabel(e))).toList(),
//         );
//       },
//       validator: validator,
//       onSaved: onSaved,
//     );
//   }
// }
//
// class _MaterialDropDown<T> extends StatelessWidget {
//   final ValueChanged<T?>? onChanged;
//   final T? selectedValue;
//   final List<T> items;
//   final FocusNode? focusNode;
//   final String? labelText;
//   final Widget? prefixIcon;
//   final String? textPlaceholder;
//   final FormFieldValidator<T?>? validator;
//   final FormFieldSetter<T?>? onSaved;
//   final String? headerText;
//   final String? hintText;
//   final Function(T) getLabel;
//   final bool isLoading;
//   const _MaterialDropDown(
//       {Key? key,
//       this.onChanged,
//       this.selectedValue,
//       required this.items,
//       required this.labelText,
//       this.textPlaceholder,
//       this.focusNode,
//       this.validator,
//       this.headerText,
//       this.onSaved,
//       required this.getLabel,
//       this.prefixIcon,
//       this.isLoading = false,
//       this.hintText})
//       : super(key: key);
//
//   // if selected value is empty string then return null
//   T? transformSelectedValue() {
//     if ((selectedValue is String?) && selectedValue == "") {
//       return null;
//     }
//     return selectedValue;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FormField<T>(
//       builder: (FormFieldState<dynamic> field) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(16.r),
//               child: DropdownButtonFormField(
//                 icon: const SizedBox(),
//                 value: transformSelectedValue(),
//                 items: items.map((value) {
//                   return DropdownMenuItem(
//                     value: value,
//                     child: Text(getLabel(value)),
//                   );
//                 }).toList(),
//                 onChanged: onChanged,
//                 style: textFieldTextStyle(context),
//                 decoration: InputDecoration(
//                   fillColor: AppColors.zeptaGrayscale[60]!,
//                   filled: true,
//                   contentPadding: EdgeInsets.only(
//                     top: 10.h,
//                     bottom: 10.h,
//                     left: 15.w,
//                   ),
//                   labelText: labelText,
//                   floatingLabelBehavior: FloatingLabelBehavior.auto,
//                   prefixIcon: prefixIcon,
//                   suffixIcon: isLoading
//                       ? const CupertinoActivityIndicator()
//                       : const Icon(Icons.keyboard_arrow_down),
//                   hintStyle: TextStyle(
//                     fontFamily: FontFamily.plusJakartaSans,
//                     color: AppColors.zeptaGrayscale[85],
//                     fontWeight: FontWeight.w400,
//                     fontStyle: FontStyle.normal,
//                     fontSize: 14.sp,
//                     height: 1.26,
//                   ),
//                   labelStyle: TextStyle(
//                     fontFamily: FontFamily.plusJakartaSans,
//                     color: AppColors.zeptaGrayscale[20],
//                     fontWeight: FontWeight.w400,
//                     fontStyle: FontStyle.normal,
//                     fontSize: 14.sp,
//                     height: 1.26,
//                   ),
//                   floatingLabelStyle: TextStyle(
//                     fontFamily: FontFamily.plusJakartaSans,
//                     color: AppColors.zeptaGrayscale[20],
//                     fontWeight: FontWeight.w400,
//                     fontStyle: FontStyle.normal,
//                     fontSize: 14.sp,
//                     height: 1.5,
//                   ),
//                   border: InputBorder.none,
//                   enabledBorder: InputBorder.none,
//                 ),
//                 // InputDecoration(
//                 //     labelText: labelText,
//                 //     prefixIcon: prefixIcon,
//                 //     prefixIconConstraints: BoxConstraints(maxHeight: 40.w),
//                 //     labelStyle: labelStyle(context),
//                 //     hintText: textPlaceholder ?? labelText,
//                 //     hintStyle: textFieldPlaceholderTextStyle(context),
//                 //     isDense: true,
//                 //     filled: false,
//                 //     // fillColor: AppColors.textColorSecondaryLight,
//                 //     // contentPadding: EdgeInsets.all(height * 0.015),
//                 //     focusedBorder: AppStyles.focusedBorder,
//                 //     disabledBorder: AppStyles.focusBorder,
//                 //     enabledBorder: AppStyles.focusBorder,
//                 //     errorBorder: AppStyles.focusedBorder,
//                 //     focusedErrorBorder: AppStyles.focusedBorder,
//                 //     errorStyle: errorTextStyle(context)),
//                 validator: validator,
//                 onSaved: onSaved,
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   TextStyle? labelStyle(context) {
//     if (focusNode != null) {
//       return focusNode!.hasFocus
//           ? labelTextFieldTextStyle(context)
//           : textFieldPlaceholderTextStyle(context);
//     }
//     return textFieldPlaceholderTextStyle(context);
//   }
//
//   labelTextFieldTextStyle(context) => TextStyle(
//         fontFamily: FontFamily.plusJakartaSans,
//         color: AppColors.zeptaGrayscale[20]!,
//         fontWeight: FontWeight.w400,
//         fontStyle: FontStyle.normal,
//         fontSize: 12.sp,
//         height: 1.5,
//       );
//
//   // TextStyle(
//   textFieldTextStyle(context) => TextStyle(
//       fontSize: 14.sp,
//       color: AppColors.zeptaGrayscale[85],
//       fontWeight: FontWeight.w500,
//       height: 1.4);
//
//   textFieldPlaceholderTextStyle(context) => TextStyle(
//       fontSize: 14.sp,
//       color: AppColors.zeptaPurple,
//       fontWeight: FontWeight.w400,
//       height: 1.4);
//
//   errorTextStyle(context) => TextStyle(
//       fontSize: 14.sp,
//       color: Theme.of(context).errorColor,
//       fontWeight: FontWeight.w500,
//       height: 1.4);
// }
//
// class DropDownWithBorder<T> extends StatelessWidget {
//   final ValueChanged<T?>? onChanged;
//   final T? selectedValue;
//   final List<T> items;
//   final String? labelText;
//   final Function(T) getLabel;
//
//   const DropDownWithBorder(
//       {Key? key,
//       required this.items,
//       required this.labelText,
//       required this.onChanged,
//       required this.selectedValue,
//       required this.getLabel})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 130.w,
//       height: 40,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(6.r),
//         border: Border.all(
//           color: AppColors.zeptaGrayscale[20]!,
//         ),
//       ),
//       child: DropdownButtonFormField<T>(
//         icon: Icon(
//           Icons.keyboard_arrow_down,
//           color: AppColors.zeptaGrayscale[20],
//         ),
//         value: selectedValue,
//         items: items.map((value) {
//           return DropdownMenuItem<T>(
//             value: value,
//             child: Center(
//               child: Text(
//                 getLabel(value),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           );
//         }).toList(),
//         onChanged: onChanged,
//         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//               fontWeight: FontWeight.w400,
//               fontSize: 10.sp,
//               fontFamily: FontFamily.plusJakartaSans,
//             ),
//         decoration: InputDecoration(
//           floatingLabelBehavior: FloatingLabelBehavior.auto,
//           border: InputBorder.none,
//           enabledBorder: InputBorder.none,
//           contentPadding: EdgeInsets.only(
//             bottom: 8.h,
//             left: 15.w,
//             right: 15.w,
//           ),
//         ),
//       ),
//     );
//   }
// }
