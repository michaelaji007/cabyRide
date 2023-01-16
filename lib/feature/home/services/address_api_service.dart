import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../configs/app_configs.dart';
import '../../../../shared/network/network_request.dart';

class AddressApiService {
  final HttpService http;
  AddressApiService({required this.http});

  Future<Response> getCoordinate(String address) {
    return HttpService(baseUrl: "", hasAuthorization: false).getRequest(
        "https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=${AppConfig.MAPAPIKEY}");
  }

  Future<Response> getPlace(String placeName) {
    return HttpService(baseUrl: "", hasAuthorization: false).getRequest(
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&components=country:ng&key=${AppConfig.MAPAPIKEY}");
  }

  Future<Response> getformattedAddress(LatLng latLng) async {
    return HttpService(baseUrl: "", hasAuthorization: false).getRequest(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${latLng.latitude},${latLng.longitude}&key=${AppConfig.MAPAPIKEY}");
  }
}
