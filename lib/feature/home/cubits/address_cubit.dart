import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_caby_rider/configs/app_startup.dart';
import 'package:go_caby_rider/shared/network/network_request.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../shared/Location/location_services.dart';
import '../model/place_coordinate.dart';
import '../model/prediction.dart';
import '../services/address_api_service.dart';

part 'address_state.dart';

ValueNotifier<bool> isFetchingCoordinate = ValueNotifier(false);
ValueNotifier<String> currentAddress = ValueNotifier("");

class AddressCubit extends Cubit<AddressState> {
  final AddressApiService apiService;
  AddressCubit({required this.apiService}) : super(AddressInitial());

  void getCoordinate(String address) async {
    emit(FetchingPickUpCoordinate());
    try {
      var res = await apiService.getCoordinate(address);

      if (res.isSuccessful) {
        var data = res.data;
        if (data["status"] == "OK") {
          var results = data["results"] as List;
          var coordObject = results[0];
          PlaceCoordinate placeCoordinate =
              PlaceCoordinate.fromJson(coordObject);

          emit(FetchedPickUpCoordinate(
            coordinate: placeCoordinate,
          ));
        }
      }
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  void getDropCoordinate(String address) async {
    emit(FetchingDropOffCoordinate());
    try {
      var res = await apiService.getCoordinate(address);

      if (res.isSuccessful) {
        var data = res.data;
        if (data["status"] == "OK") {
          var results = data["results"] as List;
          var coordObject = results[0];
          PlaceCoordinate placeCoordinate =
              PlaceCoordinate.fromJson(coordObject);

          emit(FetchedDropOffCoordinate(
            coordinate: placeCoordinate,
          ));
        }
      }
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  void fetchPlaces(String placeName) async {
    emit(FetchingPlaces());

    try {
      var res = await apiService.getPlace(placeName);

      if (res.isSuccessful) {
        var data = res.data;
        log(data.toString());
        if (data["status"] == "OK") {
          var predictions = data["predictions"] as List;
          List<Prediction> placePredictions =
              predictions.map((e) => Prediction.fromJson(e)).toList();

          emit(FetchedPlaces(predictions: placePredictions));
        }
      } else {
        debugPrint("failed");
      }
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  void findPickupCoordinateAddress() async {
    emit(FetchingPickUpCoordinate());
    try {
      Position? position = await getIt<LocationService>().determinePosition();
      if (position != null) {
        var res = await getIt<AddressApiService>()
            .getformattedAddress(LatLng(position.latitude, position.longitude));
        if (res.isSuccessful) {
          print(res.data);
          var data = res.data;
          if (data["status"] == "OK") {
            var results = data["results"] as List;
            var coordObject = results[0];
            isFetchingCoordinate.value = false;
            PlaceCoordinate placeCoordinate =
                PlaceCoordinate.fromJson(coordObject);
            // UserAddress Business Logic

            emit(FetchedPickUpCoordinate(coordinate: placeCoordinate));
          }
        }
      }
    } catch (ex) {
      isFetchingCoordinate.value = false;
    }
  }
}
