import 'package:flutter/material.dart';
import 'package:carcare/services/location_services.dart';
import 'package:location/location.dart';

class LocationProvider with ChangeNotifier {
  final LocationServices _locationServices = LocationServices();
  String? _locationString;

  String? get locationString => _locationString;

  LocationProvider() {
    fetchLocation();
  }

  Future<void> fetchLocation() async {
    LocationData? locationData = await _locationServices.getCurrentLocation();
    if (locationData != null) {
      String? address =
          await _locationServices.getAddressFromLatLng(locationData);
      _locationString = address ?? 'Could not get address';
    } else {
      _locationString = 'Could not get location';
    }
    notifyListeners(); // Notify all listeners that location has been updated
  }
}
