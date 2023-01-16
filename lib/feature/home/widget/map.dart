import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_caby_rider/configs/app_startup.dart';
import 'package:go_caby_rider/feature/home/route/routes.dart';
import 'package:go_caby_rider/feature/home/widget/set_destination_2.dart';
import 'package:go_caby_rider/feature/home/widget/what_your_dest.dart';
import 'package:go_caby_rider/shared/utils/asset_images.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../shared/Location/location_services.dart';
import '../../../shared/navigation/navigation_service.dart';
import '../cubits/trip_cubit.dart';

class MapWidget extends StatefulWidget {
  final VoidCallback handleShowDrawer;

  const MapWidget({
    Key? key,
    required this.handleShowDrawer,
  }) : super(key: key);
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  String? _mapStyle;
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? mapController;

  BitmapDescriptor? markerbitmap;
  Set<Marker> _markers = {};

  LatLng? initial;
  Timer? timer;
  Set<Marker> markers = {};

  LatLng? currentPosition;

  Position? init;
  List<Marker> list = [];

  void initState() {
    addMarkers();
    getCurrentLocation();
    super.initState();

    rootBundle.loadString('assets/uber_style.txt').then((string) {
      _mapStyle = string;
    });
  }

  void _onMapCreated(controller) {
    mapController = controller;
    _controller.complete(controller);
    mapController!.setMapStyle(_mapStyle);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // getDriver("2f35b147-88de-4e31-9f6e-6cc4553d5454");

    return Scaffold(
        body: Stack(
      children: <Widget>[
        Stack(
          children: <Widget>[
            if (currentPosition != null)
              GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: currentPosition!, zoom: 12),
                mapType: MapType.normal,
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
                markers: _markers,
                myLocationButtonEnabled: true,
              ),
            Positioned(
              top: 50,
              left: 20,
              child: InkWell(
                  onTap: widget.handleShowDrawer,
                  child: Container(
                      width: 50.w,
                      height: 50.w,
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
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                          child: SvgPicture.asset(AssetResources.MENU)))),
            ),
            Positioned.fill(
              bottom: 100,
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: WhatYourDestination(
                    onTap: () {
                      getIt<NavigationService>().toWithParameters(
                        routeName: HomeRoutes.setDestination,
                        args: {"from": FromScreen.dashboard},
                      );
                    },
                  )),
            ),
          ],
        ),
      ],
    ));
  }

  addMarkers() async {
    markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      AssetResources.CARMARKER,
    );
    setState(() {});
  }

  getCurrentLocation() async {
    Position? position = await getIt<LocationService>().determinePosition();
    if (position != null) {
      currentPosition = LatLng(position.latitude, position.longitude);
      list.add(
        Marker(
            markerId: const MarkerId('currentPosition'),
            position: currentPosition!,
            infoWindow: const InfoWindow(
              title: 'My Position',
            )),
      );
      list.add(
        Marker(
            markerId: MarkerId('2'),
            position: LatLng(8.9642, 7.3814),
            infoWindow: InfoWindow(
              title: 'Location 1',
            ),
            icon: markerbitmap!),
      );

      list.add(
        Marker(
            markerId: MarkerId('3'),
            position: LatLng(8.9789477, 7.3765394),
            infoWindow: InfoWindow(
              title: 'Location 2',
            ),
            icon: markerbitmap!),
      );

      _markers.addAll(list);
      setState(() {});
    }
  }

  getDriver(id) {
    getIt<TripCubit>().getDriver(id);
  }
}
