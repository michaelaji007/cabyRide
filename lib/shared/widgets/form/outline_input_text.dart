// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../utils/colors.dart';
// import '../../utils/font_family.dart';
//
// // ignore: must_be_immutable
// class OutlineInputText extends StatefulWidget {
//   final String? labelText;
//   final TextInputType keyboardType;
//   final bool isPassword;
//   final FormFieldValidator<String>? validator;
//   final ValueChanged<String>? onChanged;
//   final VoidCallback? onEditingComplete;
//   final FormFieldSetter<String>? onSaved;
//   final FocusNode? focusNode;
//   final VoidCallback? onTap;
//   final List<TextInputFormatter>? inputFormatters;
//   final TextInputAction? textInputAction;
//   final String? textPlaceholder;
//   final Widget? suffixIcon;
//   final Widget? prefixIcon;
//
//   String? initialValue;
//   final bool enabled;
//   final bool autofocus;
//   final TextEditingController? controller;
//   final double height;
//   final TextStyle? style;
//   final String? hintText;
//   final bool readOnly;
//   final int? minLines;
//   final int? maxLines;
//   final int? maxLength;
//   final int? lines;
//   final bool alignLabelWithHint;
//   OutlineInputText(
//       {Key? key,
//       this.labelText,
//       this.keyboardType = TextInputType.text,
//       this.isPassword = false,
//       this.autofocus = false,
//       this.validator,
//       this.onChanged,
//       this.inputFormatters,
//       this.onEditingComplete,
//       this.onSaved,
//       this.focusNode,
//       this.minLines,
//       this.maxLength,
//       this.maxLines,
//       this.lines,
//       this.onTap,
//       this.textInputAction = TextInputAction.next,
//       this.textPlaceholder,
//       this.alignLabelWithHint = true,
//       this.suffixIcon,
//       this.prefixIcon,
//       this.initialValue,
//       this.enabled = true,
//       this.readOnly = false,
//       this.controller,
//       this.height = 1,
//       this.hintText,
//       this.style})
//       : super(key: key);
//
//   @override
//   _OutlineInputTextState createState() => _OutlineInputTextState();
// }
//
// class _OutlineInputTextState extends State<OutlineInputText> {
//   late FocusNode _focusNode;
//   late TextEditingController _controller;
//
//   bool isError = false;
//   String? errorString;
//   Color borderColor = Colors.transparent;
//
//   @override
//   void initState() {
//     _controller = widget.controller ?? TextEditingController();
//     _focusNode = widget.focusNode ?? FocusNode();
//     _focusNode.addListener(() {
//       if (!_focusNode.hasFocus) {
//         setState(() {});
//       }
//     });
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _focusNode.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         FocusScope(
//           child: Focus(
//             focusNode: _focusNode,
//             onFocusChange: (focus) {},
//             child: Container(
//               // height: 56.h,
//               padding: EdgeInsets.only(
//                 left: widget.prefixIcon == null ? 24.w : 0,
//                 right: widget.suffixIcon == null ? 24.w : 0,
//               ),
//               decoration: BoxDecoration(
//                 color: AppColors.zeptaGrayscale[60]!,
//                 borderRadius: BorderRadius.circular(16.r),
//                 border: Border.all(
//                   width: 1,
//                   style: BorderStyle.solid,
//                   color: borderColor,
//                 ),
//               ),
//               child: TextFormField(
//                 readOnly: widget.readOnly,
//                 obscureText: widget.isPassword,
//                 onSaved: widget.onSaved,
//                 onChanged: widget.onChanged,
//                 // focusNode: widget.myFocusNode,
//                 controller: widget.controller,
//                 // style: getTextFieldStyle(),
//                 initialValue: widget.initialValue,
//                 autofocus: widget.autofocus,
//                 onTap: widget.onTap,
//                 keyboardType: widget.keyboardType,
//                 textInputAction: widget.textInputAction,
//                 inputFormatters: widget.inputFormatters,
//                 enabled: widget.enabled,
//                 minLines: widget.lines ?? widget.minLines ?? 1,
//                 maxLines: widget.lines ?? widget.maxLines ?? 1,
//
//                 style: widget.style ??
//                     TextStyle(
//                       fontFamily: FontFamily.plusJakartaSans,
//                       color: AppColors.zeptaGrayscale[10],
//                       fontWeight: FontWeight.w400,
//                       fontStyle: FontStyle.normal,
//                       fontSize: 14.sp,
//                       height: 1.26,
//                     ),
//                 decoration: InputDecoration(
//                   hintText: widget.hintText,
//                   labelText: widget.labelText,
//                   prefixIcon: widget.prefixIcon,
//                   suffixIcon: widget.suffixIcon,
//                   alignLabelWithHint: widget.alignLabelWithHint,
//                   contentPadding: EdgeInsets.symmetric(vertical: 15.h),
//                   filled: true,
//                   fillColor: AppColors.zeptaGrayscale[60],
//                   hintStyle: TextStyle(
//                     fontFamily: FontFamily.plusJakartaSans,
//                     color: AppColors.zeptaGrayscale[20],
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
//                     height: 1.5,
//                   ),
//                   floatingLabelStyle: TextStyle(
//                     fontFamily: FontFamily.plusJakartaSans,
//                     color: AppColors.zeptaGrayscale[20],
//                     fontWeight: FontWeight.w400,
//                     fontStyle: FontStyle.normal,
//                     fontSize: 12.sp,
//                     height: 1.5,
//                   ),
//                   border: InputBorder.none,
//                   enabledBorder: InputBorder.none,
//                   errorStyle: const TextStyle(
//                     fontSize: 0,
//                     height: 0,
//                   ),
//                 ),
//
//                 validator: (val) {
//                   if (widget.validator != null) {
//                     if (widget.validator!(val) != null &&
//                         widget.validator!(val)!.isNotEmpty) {
//                       setState(() {
//                         isError = true;
//                         errorString = widget.validator!(_controller.text);
//                       });
//                       return "";
//                     } else {
//                       setState(() {
//                         isError = false;
//                         errorString = widget.validator!(_controller.text);
//                       });
//                     }
//                   }
//                   return null;
//                 },
//               ),
//             ),
//           ),
//         ),
//         Visibility(
//           visible: isError,
//           child: Padding(
//             padding: const EdgeInsets.only(left: 15.0, top: 2.0),
//             child: Text(
//               errorString ?? "",
//               style: TextStyle(
//                 fontWeight: FontWeight.w900,
//                 color: Colors.red,
//                 fontSize: 11.sp,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   getBorderColor(isFocus) {
//     borderColor = isError
//         ? AppColors.errorRed
//         : isFocus
//             ? Colors.black
//             : Colors.transparent;
//   }
// }
//
// // class PaymentTextForm extends StatelessWidget {
// //   PaymentTextForm({Key? key}) : super(key: key);
// //   final TextEditingController controller = TextEditingController();
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       height: 56.h,
// //       padding: EdgeInsets.only(left: 24.w, right: 16.w),
// //       decoration: BoxDecoration(
// //           color: AppColors.zeptaGrayscale[60],
// //           borderRadius: BorderRadius.circular(16.r)),
// //       child: Center(
// //         child: TextFormField(
// //           keyboardType: TextInputType.number,
// //           initialValue: "₦2,930",
// //           style: TextStyle(
// //             fontFamily: FontFamily.plusJakartaSans,
// //             color: AppColors.zeptaPurple,
// //             fontWeight: FontWeight.w500,
// //             fontStyle: FontStyle.normal,
// //             fontSize: 14.sp,
// //             height: 1.26,
// //           ),
// //           decoration: InputDecoration(
// //               border: InputBorder.none,
// //               enabledBorder: InputBorder.none,
// //               focusedBorder: InputBorder.none),
// //         ),
// //       ),
// //     );
// //   }
// // }
