// import 'dart:async';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get_it/get_it.dart';
//
// import '../../Location/location_services.dart';
// import '../../utils/asset_images.dart';
// import 'outline_input_text.dart';
//
// class AutoCompleteField extends StatefulWidget {
//   final String? labelText;
//   final bool? showSavedAddresses;
//   final FormFieldSetter<String>? onSaved;
//   final Function(bool)? onClear;
//   final String? error;
//   String? controller;
//   final Function(Map? address)? onSelected;
//   final FormFieldValidator<String>? validator;
//
//   AutoCompleteField(
//       {Key? key, this.labelText,
//       this.onSaved,
//       this.error = "Something went wrong",
//       this.validator,
//       this.onSelected,
//       this.controller,
//       this.onClear,
//       this.showSavedAddresses = false}) : super(key: key);
//
//   @override
//   _AutoCompleteFieldState createState() => _AutoCompleteFieldState();
// }
//
// class _AutoCompleteFieldState extends State<AutoCompleteField> {
//   TextEditingController? controller = TextEditingController();
//   Timer? _timer;
//
//   OverlayEntry? predictionOverlay;
//   LocationService locationService = LocationService();
//   String? errorText;
//   List<Prediction>? predictionPlaces;
//   String? previousText;
//   bool isloading = false;
//   LatLng? latLng;
//   _AutoCompleteFieldState();
//
//   @override
//   void initState() {
//     controller?.text = widget.controller ?? "";
//     previousText = controller?.text;
//     controller!.addListener(onChange);
//
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     closePredictionOverlay();
//     controller!.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer(
//       bloc: GetIt.I.get<AddressCubit>(),
//       listener: (context, state) {
//         if (state is FetchingPlaces) {
//           isloading = true;
//           setState(() {});
//         }
//
//         if (state is FetchedPlaces) {
//           isloading = false;
//           predictionPlaces = state.predictions;
//           setState(() {});
//           showPredictions();
//         } else {
//           closePredictionOverlay();
//         }
//
//         if (state is FetchedCoordinate) {
//           latLng = state.coordinate!.latLng;
//           widget.onSelected!({
//             "lat": latLng?.latitude,
//             "long": latLng?.longitude,
//             "street": controller!.text,
//             "city": state.city,
//             "state": state.state,
//             "postalCode": state.postalCode
//           });
//
//           setState(() {});
//         }
//       },
//       builder: (context, state) {
//         return OutlineInputText(
//             controller: controller,
//             labelText: widget.labelText,
//             validator: widget.validator,
//             suffixIcon: isloading
//                 ? const CupertinoActivityIndicator()
//                 : controller!.text.isNotEmpty
//                     ? _buildClearIcon()
//                     : _buildAddressIcon());
//       },
//     );
//   }
//
//   Future<void> onChange() async {
//     String? value = controller!.text;
//
//     if (previousText == value) {
//       return;
//     }
//
//     if (value.length >= 3) {
//       _timer?.cancel();
//       _timer = Timer(const Duration(seconds: 2), () {
//         _timer?.cancel();
//       });
//       getIt<AddressCubit>().fetchPlaces(value);
//     } else {
//       _timer?.cancel();
//     }
//     previousText = value;
//   }
//
//   Widget _buildClearIcon() {
//     return IconButton(
//         icon: Icon(
//           Icons.clear,
//           size: 15.sp,
//           color: Colors.black,
//         ),
//         onPressed: _clearSearchBar);
//   }
//
//   Widget _buildAddressIcon() {
//     return IconButton(
//         icon: SvgPicture.asset(
//           AssetResources.LOCATION_ICON,
//           width: 18.0,
//           color: Colors.black,
//         ),
//         onPressed: null);
//   }
//
//   void _clearSearchBar() {
//     setState(() {
//       controller!.text = "";
//       errorText = null;
//     });
//     widget.onClear!(true);
//     widget.onSelected!(null);
//     closePredictionOverlay();
//   }
//
//   void showPredictions() {
//     if (predictionPlaces == null) {
//       return;
//     }
//     if (predictionOverlay == null) {
//       final RenderBox? textFieldRenderBox =
//           context.findRenderObject() as RenderBox?;
//       final RenderBox? overlay =
//           Overlay.of(context)!.context.findRenderObject() as RenderBox?;
//       final width = textFieldRenderBox!.size.width;
//       final RelativeRect position = RelativeRect.fromRect(
//         Rect.fromPoints(
//           textFieldRenderBox.localToGlobal(
//               textFieldRenderBox.size.bottomLeft(Offset.zero),
//               ancestor: overlay),
//           textFieldRenderBox.localToGlobal(
//               textFieldRenderBox.size.bottomRight(Offset.zero),
//               ancestor: overlay),
//         ),
//         Offset.zero & overlay!.size,
//       );
//
//       predictionOverlay = OverlayEntry(builder: (context) {
//         return Positioned(
//             top: position.top - 3,
//             left: position.left,
//             child: SizedBox(
//                 width: width,
//                 child: Card(
//                     elevation: 3.0,
//                     clipBehavior: Clip.antiAlias,
//                     shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.vertical(
//                             bottom: Radius.circular(0.0))),
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: predictionPlaces!
//                             .map((p) => PredictionTile(
//                                   prediction: p,
//                                   isLast: predictionPlaces?.last == p,
//                                   onTap: (p) async {
//                                     closePredictionOverlay();
//
//                                     previousText = p.description;
//                                     controller!.text = p.description;
//
//                                     getIt<AddressCubit>()
//                                         .getCoordinate(p.description);
//
//                                     isloading = false;
//                                     setState(() {});
//                                   },
//                                 ))
//                             .toList(),
//                       ),
//                     ))));
//       });
//       Overlay.of(context)!.insert(predictionOverlay!);
//     }
//
//     predictionOverlay!.markNeedsBuild();
//   }
//
//   void onSelected(Prediction? newValue) {}
//
//   void closePredictionOverlay() {
//     predictionOverlay?.remove();
//     predictionOverlay = null;
//   }
// }
//
// class PredictionTile extends StatelessWidget {
//   final Prediction prediction;
//   final ValueChanged<Prediction> onTap;
//   final bool isLast;
//
//   const PredictionTile(
//       {Key? key,
//       required this.prediction,
//       required this.onTap,
//       required this.isLast})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var tile = ListTile(
//       onTap: () => onTap(prediction),
//       leading: const Icon(
//         Icons.location_on,
//         color: Colors.grey,
//       ),
//       title: Text(prediction.description, style: TextStyle(fontSize: 13.sp)),
//     );
//     return isLast
//         ? tile
//         : Container(
//             decoration: const BoxDecoration(
//                 border: Border(
//                     bottom: BorderSide(color: Colors.black, width: 0.3))),
//             child: tile);
//   }
// }
