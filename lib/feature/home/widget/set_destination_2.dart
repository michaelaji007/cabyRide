import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:go_caby_rider/shared/utils/colors.dart';
import 'package:go_caby_rider/shared/utils/custom_styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../configs/app_startup.dart';
import '../../../shared/navigation/navigation_service.dart';
import '../../../shared/utils/dialog.dart';
import '../cubits/address_cubit.dart';
import '../cubits/trip_cubit.dart';
import '../model/payloads/request_payload.dart';
import '../model/place_coordinate.dart';
import '../model/prediction.dart';
import '../route/routes.dart';
import 'address_places.dart';
import 'color_points.dart';

enum FromScreen { confirmPick, dashboard, login, registration }

class SetDestination extends StatefulWidget {
  final PlaceCoordinate? pickUp;
  final PlaceCoordinate? dropOff;
  final FromScreen? from;
  const SetDestination({Key? key, this.pickUp, this.dropOff, this.from})
      : super(key: key);

  @override
  _SetDestinationState createState() => _SetDestinationState();
}

class _SetDestinationState extends State<SetDestination> {
  bool _validate = false;
  bool isloading = false;
  List<Prediction>? predictionPlaces;
  String? destination = "";
  String? pickup = "";
  Timer? _timer;
  FocusNode pickUpNode = FocusNode();
  FocusNode destNode = FocusNode();
  String? destinationPrediction;
  String? pickUpPrediction;
  PlaceCoordinate? dropOffCoordinate;
  PlaceCoordinate? pickUpCoordinate;
  TextEditingController pickController = TextEditingController();
  TextEditingController destController = TextEditingController();
  @override
  void initState() {
    if (widget.from == FromScreen.dashboard) {
      getIt<AddressCubit>().findPickupCoordinateAddress();
    } else {
      pickUpCoordinate = widget.pickUp;
      pickController.text = pickUpCoordinate!.formattedAddress;
      dropOffCoordinate = widget.dropOff;
      destController.text = dropOffCoordinate!.formattedAddress;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white.withOpacity(1.0),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: AppColors.darkBlue,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(130),
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    PointsWithColor(
                      colour: AppColors.cabyGrey,
                      margin: const EdgeInsets.only(left: 33.0, top: 00.0),
                    ),
                    const Points(),
                    const Points(),
                    const Points(),
                    const Points(),
                    const Points(),
                    PointsWithColor(
                      colour: AppColors.cabyLightBlue,
                      margin: const EdgeInsets.only(
                          left: 33.0, top: 10.0, bottom: 10.0),
                    )
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: BlocConsumer(
                              bloc: GetIt.I.get<AddressCubit>(),
                              listener: (context, state) {
                                if (state is FetchedPickUpCoordinate) {
                                  pickController.text =
                                      state.coordinate!.formattedAddress;
                                  pickUpCoordinate = state.coordinate;
                                  // widget.pickUpCord!(state.coordinate);
                                  destNode.requestFocus();
                                }
                              },
                              builder: (context, state) {
                                return TextField(
                                  focusNode: pickUpNode,
                                  onTap: () {},
                                  onChanged: (v) {},
                                  controller: pickController,
                                  decoration: InputDecoration(
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.darkBlue),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.darkBlue),
                                      ),
                                      labelText: "Pickup",
                                      labelStyle: GoogleFonts.poppins(
                                          color: AppColors.darkBlue,
                                          fontSize: 11.sp),
                                      suffixIcon: IconButton(
                                        icon: isFetchingCoordinate.value
                                            ? const CircularProgressIndicator()
                                            : const Icon(
                                                Icons.clear,
                                                color: AppColors.cabyGrey,
                                              ),
                                        onPressed: () {
                                          pickController.clear();
                                        },
                                      )),
                                );
                              },
                            )),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: TextField(
                            focusNode: destNode,
                            onChanged: (v) {
                              onChange();
                              setState(() {});
                            },
                            onTap: () {},
                            controller: destController,
                            decoration: InputDecoration(
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.darkBlue),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.darkBlue),
                                ),
                                labelText: "Destination",
                                labelStyle: GoogleFonts.poppins(
                                    color: AppColors.darkBlue, fontSize: 11.sp),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    destController.clear();
                                  },
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            ((destController.text.isEmpty) &&
                    (pickController.text.isEmpty) &&
                    predictionPlaces == null)
                ? const RecentAndSavedDestination()
                : pickUpNode.hasFocus
                    ? BlocConsumer(
                        bloc: GetIt.I.get<AddressCubit>(),
                        listener: (context, state) {
                          if (state is FetchingPlaces) {
                            isloading = true;
                            setState(() {});
                          }

                          if (state is FetchedPlaces) {
                            isloading = false;
                            predictionPlaces = state.predictions;
                            setState(() {});
                          }

                          if (state is FetchedPickUpCoordinate) {
                            isloading = false;
                            pickUpCoordinate = state.coordinate;
                            setState(() {});
                          }
                        },
                        builder: (context, state) {
                          return Container(
                            constraints: BoxConstraints(
                                minHeight: 100.h, maxHeight: 400.h),
                            child: AddressPlaces(
                              places: predictionPlaces,
                              onChanged: (prediction) {
                                pickUpPrediction = prediction.description;
                                setState(() {});
                                GetIt.I
                                    .get<AddressCubit>()
                                    .getCoordinate(prediction.description);
                              },
                            ),
                          );
                        },
                      )
                    : BlocConsumer(
                        bloc: GetIt.I.get<AddressCubit>(),
                        listener: (context, state) {
                          if (state is FetchingPlaces) {
                            isloading = true;
                            setState(() {});
                          }

                          if (state is FetchedPlaces) {
                            isloading = false;
                            predictionPlaces = state.predictions;
                            setState(() {});
                          }
                          if (state is FetchedDropOffCoordinate) {
                            isloading = false;
                            dropOffCoordinate = state.coordinate;
                            if (pickUpCoordinate != null &&
                                dropOffCoordinate != null) {
                              request();
                            }
                          }
                        },
                        builder: (context, state) {
                          return Container(
                            constraints: BoxConstraints(
                                minHeight: 100.h, maxHeight: 400.h),
                            child: AddressPlaces(
                              places: predictionPlaces,
                              onChanged: (prediction) {
                                destinationPrediction = prediction.description;
                                setState(() {});
                                GetIt.I
                                    .get<AddressCubit>()
                                    .getDropCoordinate(prediction.description);
                              },
                            ),
                          );
                        },
                      ),
            BlocConsumer(
              bloc: GetIt.I.get<TripCubit>(),
              listener: (context, state) {
                if (state is RequestTripLoading) {
                  DialogUtil.showLoadingDialog(context);
                }

                if (state is RequestTripSuccess) {
                  DialogUtil.dismissLoadingDialog(context);
                  getIt<NavigationService>().toWithParameters(
                      routeName: HomeRoutes.selectRide,
                      args: {
                        "pickUp": pickUpCoordinate,
                        "model": state.model,
                        "dropOff": dropOffCoordinate
                      });
                }
                if (state is RequestTripError) {
                  DialogUtil.dismissLoadingDialog(context);
                }
              },
              builder: (context, state) {
                return SizedBox();
              },
            )
          ],
        ));
  }

  request() {
    late RequestPayload payload;
    payload = RequestPayload(
        from: From(
          latitude: pickUpCoordinate?.latLng.latitude,
          longitude: pickUpCoordinate?.latLng.longitude,
        ),
        fromName: pickUpCoordinate?.formattedAddress,
        to: From(
            latitude: dropOffCoordinate?.latLng.latitude,
            longitude: dropOffCoordinate?.latLng.longitude),
        toName: dropOffCoordinate?.formattedAddress);
    getIt<TripCubit>().requestTrip(payload);
  }

  Future<void> onChange() async {
    if (destNode.hasFocus) {
      if (destController.text.isEmpty) {
        return;
      }
      if (destController.text.length >= 3) {
        _timer?.cancel();
        _timer = Timer(const Duration(seconds: 2), () {
          _timer?.cancel();
        });

        getIt<AddressCubit>().fetchPlaces(destController.text);
      } else {
        _timer?.cancel();
      }
    } else if (pickUpNode.hasFocus) {
      if (pickController.text.isEmpty) {
        return;
      }
      if (pickController.text.length >= 3) {
        _timer?.cancel();
        _timer = Timer(const Duration(seconds: 2), () {
          _timer?.cancel();
        });

        getIt<AddressCubit>().fetchPlaces(pickController.text);
      } else {
        _timer?.cancel();
      }
    }
  }
}

class RecentAndSavedDestination extends StatefulWidget {
  const RecentAndSavedDestination({Key? key}) : super(key: key);

  @override
  State<RecentAndSavedDestination> createState() =>
      _RecentAndSavedDestinationState();
}

class _RecentAndSavedDestinationState extends State<RecentAndSavedDestination> {
  List<PlaceCoordinate> allrecent = [
    PlaceCoordinate(
        formattedAddress: "Tafawa Balewa way 903",
        latLng: LatLng(233432.56, 5667565454),
        placeId: "345434"),
    PlaceCoordinate(
        formattedAddress: "Tafawa Balewa way 903",
        latLng: LatLng(233432.56, 5667565454),
        placeId: "345434"),
  ];

  List<PlaceCoordinate> allsaved = [
    PlaceCoordinate(
        formattedAddress: "Tafawa Balewa way 903",
        latLng: LatLng(233432.56, 5667565454),
        placeId: "345434"),
    PlaceCoordinate(
        formattedAddress: "Tafawa Balewa way 903",
        latLng: LatLng(233432.56, 5667565454),
        placeId: "345434"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 25.h,
          ),
          Text("Saved destinations",
              style: AppStyles.largeText.copyWith(
                fontSize: 18.sp,
                color: AppColors.darkBlue,
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: allsaved
                .map((e) => RecentTile(
                      recentLocation: e,
                      onChanged: (PlaceCoordinate value) {},
                    ))
                .toList(),
          ),
          SizedBox(height: 15.h),
          Text("Recent destinations",
              style: AppStyles.largeText.copyWith(
                fontSize: 18.sp,
                color: AppColors.darkBlue,
              )),
          SizedBox(height: 15.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: allrecent
                .map((e) => RecentTile(
                      recentLocation: e,
                      onChanged: (PlaceCoordinate value) {},
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class RecentLocation {
  String? title;
  String? desc;
  RecentLocation({this.title, this.desc});
}
