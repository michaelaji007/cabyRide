import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../../configs/app_configs.dart';
import '../../../../shared/network/network_request.dart';
import '../model/payloads/find_model.dart';
import '../model/payloads/rating_payload.dart';
import '../model/payloads/request_payload.dart';
import '../model/request_model.dart';
import '../model/trip_history_model.dart';
import '../services/api_service.dart';

part 'trip_state.dart';

class TripCubit extends Cubit<TripState> {
  final TripApiService apiService;
  TripCubit({required this.apiService}) : super(TripInitial());

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? tripCollectionStream;

  void getTripHistory() async {
    emit(TripHistoryLoading());
    try {
      var res = await apiService.getTripHistory();
      if (res.isSuccessful) {
        List<TripHistoryModel> trips = (res.data as List)
            .map((e) => TripHistoryModel.fromJson(e))
            .toList();

        emit(TripHistorySuccess(trips: trips));
      } else {
        emit(TripHistoryError(message: AppConstants.anErrorOccurred));
      }
    } catch (ex) {
      if (ex is DioError) {
        var errorMessage = networkErrorHandler(ex);

        emit(TripHistoryError(message: errorMessage));
      } else {
        emit(TripHistoryError(message: AppConstants.anErrorOccurred));
      }
    }
  }

  void requestTrip(RequestPayload request) async {
    emit(RequestTripLoading());
    try {
      var res = await apiService.requestforTrip(request.toJson());
      if (res.isSuccessful) {
        var req = RequestModel.fromJson(res.data);
        emit(RequestTripSuccess(model: req));
      } else {
        emit(RequestTripError(message: AppConstants.anErrorOccurred));
      }
    } catch (ex) {
      if (ex is DioError) {
        var errorMessage = networkErrorHandler(ex);
        emit(RequestTripError(message: errorMessage));
      } else {
        emit(RequestTripError(message: AppConstants.anErrorOccurred));
      }
    }
  }

  void find(FindPayload payload) async {
    emit(FindLoading());
    try {
      var res = await apiService.find(payload.toJson());
      if (res.isSuccessful) {
        var req = RequestModel.fromJson(res.data);
        emit(FindSuccess(model: req));
      } else {
        emit(FindError(message: AppConstants.anErrorOccurred));
      }
    } catch (ex) {
      if (ex is DioError) {
        var errorMessage = networkErrorHandler(ex);
        emit(FindError(message: errorMessage));
      } else {
        emit(FindError(message: AppConstants.anErrorOccurred));
      }
    }
  }

  void rating(RatingPayload payload) async {
    emit(RequestTripLoading());
    ;
    try {
      var res = await apiService.ratingTrip(payload.toJson());
      if (res.isSuccessful) {
        emit(RatingTripSuccess());
      } else {
        emit(RatingTripError(message: AppConstants.anErrorOccurred));
      }
    } catch (ex) {
      if (ex is DioError) {
        var errorMessage = networkErrorHandler(ex);

        emit(RatingTripError(message: errorMessage));
      } else {
        emit(RatingTripError(message: AppConstants.anErrorOccurred));
      }
    }
  }

  void confirmPickup(id) async {
    print(id);
    emit(ConfirmPickupLoading());

    try {
      var res = await apiService.confirmPickup(id);
      print(res.isSuccessful);

      if (res.isSuccessful) {
        emit(ConfirmPickupSuccess());
      } else {
        emit(ConfirmPickupError(message: AppConstants.anErrorOccurred));
      }
    } catch (ex) {
      if (ex is DioError) {
        var errorMessage = networkErrorHandler(ex);
        emit(ConfirmPickupError(message: errorMessage));
      } else {
        emit(ConfirmPickupError(message: AppConstants.anErrorOccurred));
      }
    }
  }

  // 1dbb9365-9617-464f-abf6-352d2b656445
  void getDriver(id) async {
    emit(GetDriverLoading());
    // firebaseFirestore.collection("requests").doc().get().then((value) {
    //   print(value.data());
    // });
    try {
      tripCollectionStream = firebaseFirestore
          .collection("requests")
          .where("id", isEqualTo: id)
          // .where("status", isEqualTo: "accepted")
          .snapshots(includeMetadataChanges: true)
          .listen((event) {
        // print(event.docs);
      });

      tripCollectionStream!.onData((event) {
        print(event.docs);
        if (event.docs.isNotEmpty) {
          event.docs.map((e) {
            print(e.data());
            if (e.data()["status"] == "accepted") {
              return emit(GetDriverSuccess(
                  model: DriverInfo.fromJson(
                e.data(),
              )));
            } else if (e.data()["status"] == "arrived") {
              return emit(GetDriverArrivedSuccess(
                  model: DriverInfo.fromJson(
                e.data(),
              )));
            } else if (e.data()["status"] == "trip_started") {
              return emit(StartTripSuccess(
                  model: DriverInfo.fromJson(
                e.data(),
              )));
            } else if (e.data()["status"] == "end_trip") {
              return emit(EndTripSuccess(
                  model: DriverInfo.fromJson(
                e.data(),
              )));
            }
          }).toList();
        }
      });
    } catch (ex) {
      if (ex is DioError) {
        var errorMessage = networkErrorHandler(ex);
        emit(GetDriverError(message: errorMessage));
      } else {
        emit(GetDriverError(message: AppConstants.anErrorOccurred));
      }
    }
  }
}

class DriverInfo {
  String? driverName;
  String? driverRating;
  String? distanceInKm;
  String? vehicleColor;
  String? vehicleName;
  String? vehiclePlateNumber;
  String? rating;
  String? status;
  String? id;
  List<String?>? drivers;
  DriverInfo(
      {this.driverName,
      this.driverRating,
      this.distanceInKm,
      this.vehiclePlateNumber,
      this.vehicleName,
      this.rating,
      this.status,
      this.id,
      this.drivers,
      this.vehicleColor});
  DriverInfo.fromJson(Map<String, dynamic> json) {
    distanceInKm = json['distanceInKm'].toString();
    driverRating = json['driverRating'];
    driverName = json['driverName'];
    vehicleColor = json["vehicleColor"];
    vehiclePlateNumber = json["vehiclePlateNumber"];
    vehicleName = json["vehicleModel"];
    rating = json["rating"];
    status = json["status"];
    id = json["id"];
    drivers = json["drivers"].cast<String>();
  }
}
