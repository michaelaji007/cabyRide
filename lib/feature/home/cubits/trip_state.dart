part of 'trip_cubit.dart';

@immutable
abstract class TripState {}

class TripInitial extends TripState {}

class TripHistoryLoading extends TripState {}

class TripHistorySuccess extends TripState {
  final List<TripHistoryModel>? trips;
  TripHistorySuccess({this.trips});
}

class TripHistoryError extends TripState {
  final String message;
  TripHistoryError({required this.message});
}

class RequestTripLoading extends TripState {}

class RequestTripSuccess extends TripState {
  final RequestModel? model;
  RequestTripSuccess({this.model});
}

class RequestTripError extends TripState {
  final String message;
  RequestTripError({required this.message});
}

class ConfirmPickupLoading extends TripState {}

class ConfirmPickupSuccess extends TripState {
  final RequestModel? model;
  ConfirmPickupSuccess({this.model});
}

class ConfirmPickupError extends TripState {
  final String message;
  ConfirmPickupError({required this.message});
}

class RatingTripLoading extends TripState {}

class RatingTripSuccess extends TripState {}

class RatingTripError extends TripState {
  final String message;
  RatingTripError({required this.message});
}

class GetDriverLoading extends TripState {}

class GetDriverSuccess extends TripState {
  final DriverInfo? model;
  GetDriverSuccess({this.model});
}

class GetDriverError extends TripState {
  final String message;
  GetDriverError({required this.message});
}

class StartTripLoading extends TripState {}

class StartTripSuccess extends TripState {
  final DriverInfo? model;
  StartTripSuccess({this.model});
}

class StartTripError extends TripState {
  final String message;
  StartTripError({required this.message});
}

class FindLoading extends TripState {}

class FindSuccess extends TripState {
  final RequestModel? model;
  FindSuccess({this.model});
}

class FindError extends TripState {
  final String message;
  FindError({required this.message});
}

class GetDriverArrivedLoading extends TripState {}

class GetDriverArrivedSuccess extends TripState {
  final DriverInfo? model;
  GetDriverArrivedSuccess({this.model});
}

class GetDriverArrivedError extends TripState {
  final String message;
  GetDriverArrivedError({required this.message});
}

class EndTripLoading extends TripState {}

class EndTripSuccess extends TripState {
  final DriverInfo? model;
  EndTripSuccess({this.model});
}

class EndTripError extends TripState {
  final String message;
  EndTripError({required this.message});
}
