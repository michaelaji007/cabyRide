import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../configs/app_configs.dart';
import '../../../configs/app_startup.dart';
import '../../../configs/enums/button.dart';
import '../../../shared/navigation/navigation_service.dart';
import '../../../shared/utils/asset_images.dart';
import '../../../shared/utils/colors.dart';
import '../../../shared/utils/custom_styles.dart';
import '../../../shared/widgets/button.dart';
import '../cubits/trip_cubit.dart';
import '../model/place_coordinate.dart';
import '../model/request_model.dart';
import '../route/routes.dart';
import 'color_points.dart';

class DriverOnTheWay extends StatefulWidget {
  final PlaceCoordinate? pickUp;
  final PlaceCoordinate? dropOff;
  final RequestModel? request;
  const DriverOnTheWay({Key? key, this.pickUp, this.dropOff, this.request})
      : super(key: key);

  @override
  State<DriverOnTheWay> createState() => _DriverOnTheWayState();
}

class _DriverOnTheWayState extends State<DriverOnTheWay>
    with TickerProviderStateMixin {
  String? _mapStyle;
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? mapController;
  BitmapDescriptor? pinLocationIcon;

  bool isCard = false;
  LatLng? initial;
  Timer? timer;
  Map<MarkerId, Marker> markers = {};
  bool headingToDest = false;
  Map<PolylineId, Polyline> polylines = {};
  PlaceCoordinate? pickUp;
  PlaceCoordinate? dropOff;
  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];
  BitmapDescriptor? markerbitmap;
  DriverInfo? driverInfo;
  AnimationController? controller;
  bool driverArrived = false;
  bool tripStarted = false;
  @override
  void initState() {
    addMarkers();
    rootBundle.loadString('assets/uber_style.txt').then((string) {
      _mapStyle = string;
    });
    pickUp = widget.pickUp;
    dropOff = widget.dropOff;
    getDriver(widget.request?.id);
    setPolylines();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )
      ..addStatusListener((AnimationStatus status) {
        setState(() {
          if (status == AnimationStatus.completed) {
          } else {}
        });
      })
      ..addListener(() {
        setState(() {});
      });
    controller!.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        GoogleMap(
          initialCameraPosition: CameraPosition(
              target:
                  LatLng(pickUp!.latLng.longitude, pickUp!.latLng.longitude)),
          mapType: MapType.normal,
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          markers: Set<Marker>.of(markers.values),
          polylines: Set<Polyline>.of(polylines.values),
        ),
        Positioned.fill(
          top: 40,
          // left: 40,
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
                      icon: Icon(Icons.arrow_back),
                      color: Color(0xff919AA3),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Center(
                        child: headingToDest
                            ? Text("Driving to destination")
                            : Text("Driver on the way")),
                  ],
                )),
          ),
        ),
        Positioned.fill(
          top: 70,
          // left: 40,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 170.h,
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            PointsWithColor(
                              colour: AppColors.cabyGrey,
                              margin: EdgeInsets.only(left: 3.w, top: 20.h),
                            ),
                            const Points(),
                            const Points(),
                            const Points(),
                            const Points(),
                            PointsWithColor(
                              colour: AppColors.cabyLightBlue,
                              margin: EdgeInsets.only(
                                  left: 3.w, top: 10.h, bottom: 40.h),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Column(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Pickup',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12.0, color: Colors.grey),
                                  ),
                                  // SizedBox(height: 10.h),
                                  Text(pickUp!.formattedAddress),
                                ],
                              ),
                              // Divider(),
                              SizedBox(
                                height: 20.h,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Destination',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12.0, color: Colors.grey),
                                  ),
                                  // SizedBox(height: 10.h),
                                  Text(widget.dropOff!.formattedAddress),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
            child: Align(
          alignment: Alignment.bottomCenter,
          child: BlocConsumer(
            bloc: getIt<TripCubit>(),
            listener: (context, state) {
              if (state is GetDriverLoading) {}
              if (state is GetDriverSuccess) {
                driverInfo = state.model;
              }

              if (state is GetDriverError) {}

              if (state is GetDriverArrivedLoading) {}
              if (state is GetDriverArrivedSuccess) {
                // driverInfo = state.model;
                driverArrived = true;
              }
              if (state is GetDriverArrivedError) {}

              if (state is StartTripSuccess) {
                tripStarted = true;
              }
              if (state is EndTripSuccess) {
                getIt<NavigationService>().toWithParameters(
                    routeName: HomeRoutes.rideSuccessful,
                    args: {"driverInfo": driverInfo});
              }
            },
            builder: (context, state) {
              if (state is GetDriverLoading) {
                return driverLoading();
              }
              if (state is GetDriverError) {
                return Text("An error has occurred");
              }

              return Container(
                height: 300.h,
                padding: EdgeInsets.only(
                    left: 20.h, top: 20.h, right: 10.h, bottom: 20.h),
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        driverArrived
                            ? "Your driver has arrived"
                            : tripStarted
                                ? "Your trip has started"
                                : "Your ride",
                        style: AppStyles.largeText.copyWith(fontSize: 17.sp)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.w,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 64.w,
                              width: 64.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.cabyGrey),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  driverInfo?.driverName ?? "",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 5.w,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text:
                                        '${driverInfo?.vehicleName} (${driverInfo?.vehicleColor})  -  ',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14.sp,
                                        color: AppColors.darkBlue),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              driverInfo?.vehiclePlateNumber ??
                                                  "",
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5.w,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 15.sp,
                                    ),
                                    Text(
                                      driverInfo?.rating ?? "",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    Spacer(),
                    headingToDest
                        ? Row(children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset(
                                            AssetResources.MASTERCARD),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text(
                                          "****",
                                          style: GoogleFonts.poppins(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text(
                                          "1000",
                                          style: GoogleFonts.poppins(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                  SizedBox(
                                    height: 5.w,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "12/33",
                                        style: AppStyles.smallText.copyWith(
                                          color: AppColors.cabyGrey,
                                          fontSize: 11.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      Text(
                                        "\$ 1,000",
                                        style: AppStyles.largeText
                                            .copyWith(fontSize: 14.sp),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: AppButton(
                                text: "Share ETA",
                                onPressed: () {
                                  getIt<NavigationService>()
                                      .to(routeName: HomeRoutes.rideSuccessful);
                                },
                              ),
                            )
                          ])
                        : Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: AppButton(
                                  text: "Call driver",
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: Container(
                                  // height: 50.w,
                                  // width: 30.w,
                                  padding: EdgeInsets.all(15.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6.r),
                                      border: Border.all(
                                          color: AppColors.darkBlue)),
                                  child: SvgPicture.asset(
                                    AssetResources.MESSAGE,
                                  ),
                                ),
                              )
                            ],
                          ),
                    SizedBox(
                      height: 20.w,
                    ),
                    Visibility(
                      visible: !tripStarted && driverArrived,
                      child: AppButton(
                        buttonType: ButtonType.tertiary,
                        text: "Cancel ride",
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        )),
      ],
    ));
  }

  addMarkers() async {
    markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      AssetResources.CARMARKER,
    );
    _addMarker(LatLng(pickUp!.latLng.latitude, pickUp!.latLng.longitude),
        "origin", markerbitmap!);

    _addMarker(LatLng(dropOff!.latLng.latitude, dropOff!.latLng.longitude),
        "destination", BitmapDescriptor.defaultMarkerWithHue(90));
    setState(() {});
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

    mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(pickUp!.latLng.latitude, pickUp!.latLng.longitude),
        zoom: 11.5)));
  }

  getDriver(id) {
    getIt<TripCubit>().getDriver(id);
  }

  driverLoading() {
    return Container(
      height: 300.h,
      padding:
          EdgeInsets.only(left: 20.h, top: 20.h, right: 10.h, bottom: 20.h),
      width: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Looking for available drivers",
              style: AppStyles.largeText.copyWith(fontSize: 17.sp)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.w,
              ),

              LinearProgressIndicator(
                value: controller!.value,
                color: AppColors.darkBlue,
              ),
              Center(
                child: Text(
                    "kindly hold on while we search for available drivers around you",
                    style: AppStyles.largeText.copyWith(fontSize: 12.sp)),
              ),

              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     ShimmerWidget.circle(
              //       height: 64.w,
              //       width: 64.w,
              //       borderRadius: 100.r,
              //     ),
              //     SizedBox(
              //       width: 10.w,
              //     ),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         ShimmerWidget.rectangle(
              //           height: 14.w,
              //           width: 84.w,
              //         ),
              //         SizedBox(
              //           height: 10.w,
              //         ),
              //         ShimmerWidget.rectangle(
              //           height: 14.w,
              //           width: 204.w,
              //         ),
              //         SizedBox(
              //           height: 10.w,
              //         ),
              //         ShimmerWidget.rectangle(
              //           height: 10.w,
              //           width: 24.w,
              //         ),
              //       ],
              //     ),
              //   ],
              // )
            ],
          ),
        ],
      ),
    );
  }
}
