import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
class LocationServices {

  static Future<bool> handleLocationPermission(BuildContext context) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    PermissionStatus permission = await Permission.location.status;

    if (permission == PermissionStatus.denied) {
      permission = await Permission.location.request();

      if (permission == PermissionStatus.denied) {
        Navigator.of(context).pop();
        return false;
      }
    }

    if (permission == PermissionStatus.permanentlyDenied) {
      return false;
    }

    return true;
  }

  static Future<Position?> getCurrentPositionSafe() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      timeLimit: const Duration(seconds: 10),
    );
  }


  static Future<String?> getCurrentCityName(
      double latitude, double longitude) async {
    List<Placemark> placemarks =
    await placemarkFromCoordinates(latitude, longitude);

    if (placemarks.isNotEmpty) {
      final place = placemarks.first;
      return place.locality ??
          place.subAdministrativeArea ??
          place.administrativeArea;
    }
    return null;
  }

  static Future<String?> fetchCurrentCityWithPermission(
      BuildContext context) async {
    final hasPermission = await handleLocationPermission(context);

    if (!hasPermission) return null;

    final position = await getCurrentPositionSafe();
    if (position == null) return null;

    return await getCurrentCityName(
      position.latitude,
      position.longitude,
    );
  }

}