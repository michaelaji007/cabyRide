import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Map<String, dynamic> result = {};
  Future<Position>? determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enableAd.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    // result["lat"] = position.latitude;
    // result["long"] = position.longitude;

    // List<Placemark> placemarks =
    //     await placemarkFromCoordinates(position.latitude, position.longitude);
    // result["placemarks"] = placemarks[0];
    //
    return position;
  }

  Future<Map<String, dynamic>> locationAddress(String address) async {
    Map<String, dynamic> result = {};
    List<Location> locations = await locationFromAddress(address);

    result["lat"] = locations[0].latitude;
    result["long"] = locations[0].longitude;
    return result;
  }
}
