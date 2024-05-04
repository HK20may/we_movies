import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationServices {
  static String mainAddress = '';
  static String secondaryAddress = '';

  static Future<void> fetchUserLocation() async {
    try {
      // Request permission to access location
      LocationPermission permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        // Handle permission denied
        await Geolocator.openAppSettings();
        return;
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
    } catch (e) {
      log('Error: $e');
    }
  }
}
