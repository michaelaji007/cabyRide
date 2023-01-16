part of 'address_cubit.dart';

abstract class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

class AddressInitial extends AddressState {}

class FetchingPlaces extends AddressState {}

class FetchedPlaces extends AddressState {
  final List<Prediction> predictions;
  const FetchedPlaces({required this.predictions});
}

class FetchingPickUpCoordinate extends AddressState {}

class FetchedPickUpCoordinate extends AddressState {
  final PlaceCoordinate? coordinate;

  const FetchedPickUpCoordinate({this.coordinate});
}

class FetchingDropOffCoordinate extends AddressState {}

class FetchedDropOffCoordinate extends AddressState {
  final PlaceCoordinate? coordinate;

  const FetchedDropOffCoordinate({this.coordinate});
}
