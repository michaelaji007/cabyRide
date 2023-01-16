// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get_it/get_it.dart';
// import 'package:go_caby_rider/shared/utils/colors.dart';
// import 'package:go_caby_rider/shared/utils/custom_styles.dart';
//
// import '../../../configs/app_startup.dart';
// import '../../../shared/navigation/navigation_service.dart';
// import '../cubits/address_cubit.dart';
// import '../model/place_coordinate.dart';
// import '../model/prediction.dart';
// import '../route/routes.dart';
// import 'address_places.dart';
// import 'bottom_appbar.dart';
//
// class SetDestination extends StatefulWidget {
//   const SetDestination({Key? key}) : super(key: key);
//
//   @override
//   _SetDestinationState createState() => _SetDestinationState();
// }
//
// class _SetDestinationState extends State<SetDestination> {
//   bool _validate = false;
//   bool isloading = false;
//   List<Prediction>? predictionPlaces;
//   String? destination = "";
//   String? pickup = "";
//   Timer? _timer;
//   FocusNode? pickUpNode = FocusNode();
//   FocusNode? destNode = FocusNode();
//   String? destinationPrediction;
//   String? pickUpPrediction;
//   PlaceCoordinate? dropOffCoordinate;
//   PlaceCoordinate? pickUpCoordinate;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print(pickup);
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white.withOpacity(1.0),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             color: AppColors.darkBlue,
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           bottom: BottomAppBar2(
//             dropOffValue: destinationPrediction,
//             pickupValue: pickUpPrediction,
//             onclearDropoff: (v) {
//               destinationPrediction = "";
//               setState(() {});
//             },
//             pickUpCord: (v) {
//               pickUpCoordinate = v;
//               setState(() {});
//             },
//             setDestinationText: (v) {
//               destination = v;
//               onChange();
//               setState(() {});
//             },
//             pickUpNode: (v) {
//               pickUpNode = v;
//               setState(() {});
//             },
//             dropNode: (v) {
//               destNode = v;
//               setState(() {});
//             },
//             setPickUpText: (v) {
//               pickup = v;
//               onChange();
//               setState(() {});
//             },
//           ),
//         ),
//         body: ((destination!.isEmpty || destination == "") &&
//                 (pickup!.isEmpty || pickup == null) &&
//                 predictionPlaces == null)
//             ? const RecentAndSavedDestination()
//             : pickUpNode!.hasFocus
//                 ? BlocConsumer(
//                     bloc: GetIt.I.get<AddressCubit>(),
//                     listener: (context, state) {
//                       if (state is FetchingPlaces) {
//                         isloading = true;
//                         setState(() {});
//                       }
//
//                       if (state is FetchedPlaces) {
//                         isloading = false;
//                         predictionPlaces = state.predictions;
//                         setState(() {});
//                       }
//
//                       if (state is FetchedPickUpCoordinate) {
//                         isloading = false;
//                         pickUpCoordinate = state.coordinate;
//                         setState(() {});
//                       }
//                     },
//                     builder: (context, state) {
//                       return Container(
//                         constraints:
//                             BoxConstraints(minHeight: 100.h, maxHeight: 400.h),
//                         child: AddressPlaces(
//                           places: predictionPlaces,
//                           onChanged: (prediction) {
//                             pickUpPrediction = prediction.description;
//                             setState(() {});
//                             GetIt.I
//                                 .get<AddressCubit>()
//                                 .getCoordinate(prediction.description);
//                           },
//                         ),
//                       );
//                     },
//                   )
//                 : BlocConsumer(
//                     bloc: GetIt.I.get<AddressCubit>(),
//                     listener: (context, state) {
//                       if (state is FetchingPlaces) {
//                         isloading = true;
//                         setState(() {});
//                       }
//
//                       if (state is FetchedPlaces) {
//                         isloading = false;
//                         predictionPlaces = state.predictions;
//                         setState(() {});
//                       }
//                       if (state is FetchedDropOffCoordinate) {
//                         isloading = false;
//                         dropOffCoordinate = state.coordinate;
//                         if (pickUpCoordinate != null &&
//                             dropOffCoordinate != null) {
//                           getIt<NavigationService>().toWithParameters(
//                               routeName: HomeRoutes.selectRide,
//                               args: {
//                                 "pickUp": pickUpCoordinate,
//                                 "dropOff": dropOffCoordinate
//                               });
//                         }
//
//                         setState(() {});
//                       }
//                     },
//                     builder: (context, state) {
//                       return Container(
//                         constraints:
//                             BoxConstraints(minHeight: 100.h, maxHeight: 400.h),
//                         child: AddressPlaces(
//                           places: predictionPlaces,
//                           onChanged: (prediction) {
//                             destinationPrediction = prediction.description;
//                             setState(() {});
//                             GetIt.I
//                                 .get<AddressCubit>()
//                                 .getDropCoordinate(prediction.description);
//                           },
//                         ),
//                       );
//                     },
//                   ));
//   }
//
//   Future<void> onChange() async {
//     if (destNode!.hasFocus) {
//       if (destination == null) {
//         return;
//       }
//       if (destination!.length >= 3) {
//         _timer?.cancel();
//         _timer = Timer(const Duration(seconds: 2), () {
//           _timer?.cancel();
//         });
//
//         getIt<AddressCubit>().fetchPlaces(destination!);
//       } else {
//         _timer?.cancel();
//       }
//     } else if (pickUpNode!.hasFocus) {
//       if (pickup == null) {
//         return;
//       }
//       if (pickup!.length >= 3) {
//         _timer?.cancel();
//         _timer = Timer(const Duration(seconds: 2), () {
//           _timer?.cancel();
//         });
//
//         getIt<AddressCubit>().fetchPlaces(pickup!);
//       } else {
//         _timer?.cancel();
//       }
//     }
//   }
// }
//
// class RecentAndSavedDestination extends StatefulWidget {
//   const RecentAndSavedDestination({Key? key}) : super(key: key);
//
//   @override
//   State<RecentAndSavedDestination> createState() =>
//       _RecentAndSavedDestinationState();
// }
//
// class _RecentAndSavedDestinationState extends State<RecentAndSavedDestination> {
//   List<RecentLocation> allrecent = [
//     RecentLocation(desc: "Tafawa Balewa way 903", title: "Abuja"),
//     RecentLocation(desc: "Tafawa Balewa way 903", title: "Abuja")
//   ];
//
//   List<RecentLocation> allsaved = [
//     RecentLocation(
//         desc: "Home", title: "Area 2 section 1 Bendel street, Garki, Abuja"),
//     RecentLocation(
//         desc: "Work", title: "25 Ibadan street, Area 3, Garki, Abuja")
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20.w),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             height: 25.h,
//           ),
//           Text("Saved destinations",
//               style: AppStyles.largeText.copyWith(
//                 fontSize: 18.sp,
//                 color: AppColors.darkBlue,
//               )),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: allsaved
//                 .map((e) => RecentTile(
//                       recentLocation: e,
//                       onChanged: (RecentLocation value) {},
//                     ))
//                 .toList(),
//           ),
//           SizedBox(height: 15.h),
//           Text("Recent destinations",
//               style: AppStyles.largeText.copyWith(
//                 fontSize: 18.sp,
//                 color: AppColors.darkBlue,
//               )),
//           SizedBox(height: 15.h),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: allrecent
//                 .map((e) => RecentTile(
//                       recentLocation: e,
//                       onChanged: (RecentLocation value) {},
//                     ))
//                 .toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class RecentLocation {
//   String? title;
//   String? desc;
//   RecentLocation({this.title, this.desc});
// }
