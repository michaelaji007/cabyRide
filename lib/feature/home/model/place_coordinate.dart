import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceCoordinate {
  final List<AddressComponent>? addressComponents;
  final String formattedAddress;
  final String placeId;
  final LatLng latLng;
  PlaceCoordinate({
    this.addressComponents,
    required this.placeId,
    required this.formattedAddress,
    required this.latLng,
  });

  factory PlaceCoordinate.fromJson(Map<String, dynamic> json) {
    return PlaceCoordinate(
      addressComponents: List<AddressComponent>.from(
          json["address_components"].map((x) => AddressComponent.fromJson(x))),
      formattedAddress: json["formatted_address"],
      latLng: LatLng(json["geometry"]["location"]["lat"],
          json["geometry"]["location"]["lng"]),
      placeId: json["place_id"],
    );
  }
}

class AddressComponent {
  AddressComponent({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  String longName;
  String shortName;
  List<String> types;

  factory AddressComponent.initial() =>
      AddressComponent(longName: '', shortName: '', types: []);

  factory AddressComponent.fromJson(Map<String, dynamic> json) =>
      AddressComponent(
        longName: json["long_name"],
        shortName: json["short_name"],
        types: List<String>.from(json["types"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "long_name": longName,
        "short_name": shortName,
        "types": List<dynamic>.from(types.map((x) => x)),
      };
}
