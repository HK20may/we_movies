import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wework_movies_app/core/helpers/logger/error_reporter.dart';

class LocationServices {
  static String mainAddress = '';
  static String secondaryAddress = '';

  static Future<bool> fetchUserLocation() async {
    try {
      // Request permission to access location
      LocationPermission permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        // Handle permission denied
        // await Geolocator.openAppSettings();
        return false;
      }

      // Get the current user's position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Reverse geocode the position to get the address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        mainAddress = '${placemark.street}, ${placemark.locality}';
        secondaryAddress =
            '${placemark.administrativeArea}, ${placemark.country}';
      }
      return true;
    } catch (e, st) {
      ErrorReporter.error(e, stackTrace: st, errorMsg: "❌ Error: ");
      return false;
    }
  }
}
