import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
class LocationService {
  Future<Placemark?> getLocationName(Position? position) async {
    if (position != null) {
      try {
        final placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);

        if (placemarks.isNotEmpty) {
          print(placemarks);
          return placemarks[0];
        }
      } catch (e) {}
    }

    return null;
  }
}