import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';

class LocationServices {
  Future<loc.LocationData?> getCurrentLocation() async {
    loc.Location location = loc.Location();

    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;
    loc.LocationData locationData;

    // Check if location service is enabled
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    // Check if permission is granted
    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return null;
      }
    }

    // Get the current location
    locationData = await location.getLocation();
    return locationData;
  }

  Future<String?> getAddressFromLatLng(loc.LocationData locationData) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        locationData.latitude!,
        locationData.longitude!,
      );

      Placemark place = placemarks[0];
      String address = "${place.locality}, ${place.country}";
      return address;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
