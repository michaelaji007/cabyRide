import 'package:dio/dio.dart';

import '../../../../configs/app_configs.dart';
import '../../../../shared/network/network_request.dart';

class TripApiService {
  final HttpService http;
  TripApiService({required this.http});

  Future<Response> getTripHistory() async {
    return HttpService(baseUrl: AppURL.baseTripUrl, hasAuthorization: true)
        .getRequest("me");
  }

  Future<Response> requestforTrip(Object body) async {
    return HttpService(baseUrl: AppURL.baseRequestUrl, hasAuthorization: true)
        .post("", data: body);
  }

  Future<Response> find(Object body) async {
    return HttpService(baseUrl: AppURL.baseTrackerUrl, hasAuthorization: true)
        .post("find", data: body);
  }

  Future<Response> ratingTrip(Object body) async {
    return HttpService(baseUrl: AppURL.baseRatingUrl, hasAuthorization: true)
        .getRequest("");
  }

  Future<Response> confirmPickup(String id) async {
    return HttpService(baseUrl: AppURL.baseRequestUrl, hasAuthorization: true)
        .post("$id/confirm");
  }

  Future<Response> getTripDetails(String id) async {
    return HttpService(baseUrl: AppURL.baseRequestUrl, hasAuthorization: true)
        .post("$id/confirm");
  }
}
