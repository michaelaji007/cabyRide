import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_caby_rider/feature/home/route/routes.dart';
import 'package:go_caby_rider/feature/home/widget/set_destination_2.dart';
import 'package:go_caby_rider/feature/payment/cubits/payment_cubit.dart';
import 'package:go_caby_rider/shared/widgets/messenger.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../configs/app_configs.dart';
import '../../../configs/app_startup.dart';
import '../../../shared/navigation/navigation_service.dart';
import '../../../shared/utils/asset_images.dart';
import '../../../shared/utils/colors.dart';
import '../../../shared/utils/custom_styles.dart';
import '../../../shared/utils/dialog.dart';
import '../../../shared/widgets/button.dart';
import '../../payment/model/card_model.dart';
import '../../payment/model/method_model.dart';
import '../../profile/widget/save_address_widget.dart';
import '../cubits/trip_cubit.dart';
import '../model/place_coordinate.dart';
import '../model/request_model.dart';
import '../utils/bottomsheets/bottom_sheets.dart';

class SelectRide extends StatefulWidget {
  final PlaceCoordinate? pickUp;
  final PlaceCoordinate? dropOff;
  final RequestModel? model;
  const SelectRide({Key? key, this.pickUp, this.dropOff, this.model})
      : super(key: key);

  @override
  State<SelectRide> createState() => _SelectRideState();
}

class _SelectRideState extends State<SelectRide> {
  String? _mapStyle;
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? mapController;
  BitmapDescriptor? pinLocationIcon;
  List<LatLng> polylineCoordinates = [];
  // Set<Marker> _markers = {};
  bool isCard = true;
  LatLng? initial;
  Timer? timer;
  Map<MarkerId, Marker> markers = {};
  bool selectRide = false;
  Map<PolylineId, Polyline> polylines = {};
  List<PaymentMethod> allMethods = [];
  PlaceCoordinate? pickUp;
  PlaceCoordinate? dropOff;
  PolylinePoints polylinePoints = PolylinePoints();
  PaymentMethod? selectPaymentMethod;

  @override
  void initState() {
    rootBundle.loadString('assets/uber_style.txt').then((string) {
      _mapStyle = string;
    });
    pickUp = widget.pickUp;
    dropOff = widget.dropOff;

    _addMarker(LatLng(pickUp!.latLng.latitude, pickUp!.latLng.longitude),
        "origin", BitmapDescriptor.defaultMarker);

    _addMarker(LatLng(dropOff!.latLng.latitude, dropOff!.latLng.longitude),
        "destination", BitmapDescriptor.defaultMarkerWithHue(90));
    setPolylines();
    getcards();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                      pickUp!.latLng.longitude, pickUp!.latLng.longitude),
                  zoom: 11.5),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              markers: Set<Marker>.of(markers.values),
              polylines: Set<Polyline>.of(polylines.values),
            ),
            Positioned.fill(
              top: 70,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                    width: 350.w,
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    height: 40.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          color: AppColors.darkBlue,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Center(
                            child: Container(
                          width: 270.w,
                          child: Text(
                            dropOff?.formattedAddress ?? "",
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                      ],
                    )),
              ),
            ),
            Positioned.fill(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: selectRide ? 250 : 300,
                padding: EdgeInsets.only(
                    left: 20.h, top: 20.h, right: 10.h, bottom: 20.h),
                width: double.infinity,
                color: Colors.white,
                child: selectRide
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            RichText(
                              text: TextSpan(
                                text: 'Estimated Pickup Time: ',
                                style: GoogleFonts.poppins(
                                    fontSize: 14.sp, color: AppColors.darkBlue),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          '${widget.model?.durationInMinutes} mins',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.w,
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Fare rate: ',
                                style: GoogleFonts.poppins(
                                    fontSize: 14.sp, color: AppColors.darkBlue),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'NGN ${widget.model?.estimatedPrice!
                                          // .toStringAsFixed(0)

                                          }',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Divider(
                              color: AppColors.cabyGrey,
                              height: 50.h,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SvgPicture.asset(AssetResources.PIN,
                                    color: AppColors.darkBlue),
                                SizedBox(
                                  width: 10.w,
                                ),
                                SizedBox(
                                  width: 270.w,
                                  child: Text(pickUp?.formattedAddress ?? "",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                          color: AppColors.darkBlue,
                                          fontSize: 14.sp)),
                                ),
                                const Spacer(),
                                BlueEdit(
                                  onTap: () {
                                    getIt<NavigationService>().pushReplace(
                                        routeName: HomeRoutes.setDestination,
                                        args: {
                                          "from": FromScreen.confirmPick,
                                          "pickUp": widget.pickUp,
                                          "dropOff": widget.dropOff
                                        });
                                  },
                                )
                              ],
                            ),
                            BlocConsumer(
                              bloc: getIt<TripCubit>(),
                              listener: (context, state) {
                                print(state);
                                if (state is ConfirmPickupLoading) {
                                  DialogUtil.showLoadingDialog(context);
                                }
                                if (state is ConfirmPickupSuccess) {
                                  DialogUtil.dismissLoadingDialog(context);
                                  getIt<NavigationService>().toWithParameters(
                                      routeName: HomeRoutes.driverOnTheWay,
                                      args: {
                                        "pickUp": pickUp,
                                        "dropOff": dropOff,
                                        "request": widget.model
                                      });
                                }
                                if (state is ConfirmPickupError) {
                                  DialogUtil.dismissLoadingDialog(context);
                                  NotificationMessage.showError(context,
                                      message: state.message);
                                }
                              },
                              builder: (context, state) {
                                return SizedBox();
                              },
                            ),
                            const Spacer(),
                            AppButton(
                              text: "Confirm Pickup",
                              onPressed: () {
                                confirm(widget.model?.id);
                              },
                            ),
                          ])
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Taxi",
                                style: AppStyles.largeText
                                    .copyWith(fontSize: 12.sp),
                              ),
                              SizedBox(
                                height: 10.w,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset(
                                    AssetResources.TAXI,
                                    width: 100.w,
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      Text(
                                        '\$ ${widget.model?.estimatedPrice
                                        // toStringAsFixed(0)

                                        }',
                                        style: AppStyles.largeText
                                            .copyWith(fontSize: 16.sp),
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w, vertical: 6.h),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6.r),
                                          color: AppColors.cabyLightBlue,
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              "${widget.model?.durationInMinutes}",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 11),
                                            ),
                                            Text(
                                              "Mins",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 11),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          Divider(
                            color: AppColors.cabyGrey,
                            height: 50.h,
                          ),
                          BlocConsumer(
                            bloc: getIt<PaymentCubit>(),
                            listener: (context, state) {
                              print(state);
                              if (state is GetCardsLoading) {}
                              if (state is GetCardsSuccess) {
                                allMethods = (state.methods);
                                selectPaymentMethod = allMethods.singleWhere(
                                    (element) =>
                                        element.preferredPaymentMethod == true);
                                // setState(() {});
                              }
                              if (state is GetCardsError) {}
                            },
                            builder: (context, state) {
                              if (state is GetCardsLoading) {
                                return const CupertinoActivityIndicator();
                              }

                              return InkWell(
                                onTap: () {
                                  pickPaymentMethod(context: context);
                                },
                                child: Row(children: [
                                  if (selectPaymentMethod != null &&
                                      selectPaymentMethod?.paymentMethodType !=
                                          "CASH")
                                    SvgPicture.asset(CardIssuer.values
                                        .firstWhere((element) =>
                                            element ==
                                            selectPaymentMethod
                                                ?.payload?.cardType)
                                        .image)
                                  else if (selectPaymentMethod
                                          ?.paymentMethodType ==
                                      "CASH")
                                    SvgPicture.asset(AssetResources.CARD),
                                  SizedBox(width: 10.h),
                                  if (selectPaymentMethod?.payload != null)
                                    Text(
                                      "**** ${selectPaymentMethod?.payload?.last4}",
                                      style: GoogleFonts.poppins(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500),
                                    )
                                  else
                                    Text(
                                      selectPaymentMethod?.paymentMethodType ??
                                          "",
                                      style: GoogleFonts.poppins(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  const Icon(Icons.keyboard_arrow_down_rounded)
                                ]),
                              );
                            },
                          ),
                          const Spacer(),
                          AppButton(
                            text: "Select Ride",
                            onPressed: () {
                              selectRide = true;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
              ),
            )),
          ],
        ),
      ],
    ));
  }

  confirm(id) {
    getIt<TripCubit>().confirmPickup(id);
  }

  void _onMapCreated(controller) {
    mapController = controller;
    _controller.complete(controller);
    mapController!.setMapStyle(_mapStyle);
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.red,
        points: polylineCoordinates,
        width: 5);
    polylines[id] = polyline;
    setState(() {});
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  setPolylines() async {
    LatLngBounds bound;
    try {
      bound = LatLngBounds(
          southwest: LatLng(pickUp!.latLng.latitude, pickUp!.latLng.longitude),
          northeast:
              LatLng(dropOff!.latLng.latitude, dropOff!.latLng.longitude));
    } catch (e) {
      bound = LatLngBounds(
          northeast: LatLng(pickUp!.latLng.latitude, pickUp!.latLng.longitude),
          southwest:
              LatLng(dropOff!.latLng.latitude, dropOff!.latLng.longitude));
    }

    CameraUpdate u2 = CameraUpdate.newLatLngBounds(bound, 5);

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        AppConfig.MAPAPIKEY,
        PointLatLng(pickUp!.latLng.latitude, pickUp!.latLng.longitude),
        PointLatLng(dropOff!.latLng.latitude, dropOff!.latLng.longitude),
        travelMode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: dropOff!.formattedAddress)]);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();

    mapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(pickUp!.latLng.latitude, pickUp!.latLng.longitude),
        zoom: 11.5)));
  }

  void getcards() {
    getIt<PaymentCubit>().getPaymentMethod();
  }
}
