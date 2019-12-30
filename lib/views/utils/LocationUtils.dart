import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationUtils {
  static Future<Position> getLocationByAddress(String address) async {
    List<Placemark> placeMarks =
        await Geolocator().placemarkFromAddress(address);

    if (placeMarks != null && placeMarks.isNotEmpty) {
      Placemark addressPoint = placeMarks[0];
      return addressPoint.position;
    }

    return Position(latitude: 0.0, longitude:  0.0);
  }

  static Future<String> getAddressByLocation(Position location) async {
    List<Placemark> placeMarks = await Geolocator().placemarkFromCoordinates(location.latitude, location.longitude);

    if (placeMarks != null && placeMarks.isNotEmpty) {
      Placemark addressPoint = placeMarks[0];
      String locationAddress = addressPoint.thoroughfare + ', ' + addressPoint.locality;
      print(locationAddress);

      return locationAddress;
    }

    return '';
  }

  static Future<void> moveToPosition(GeoPoint loc, GoogleMapController mapController) async {
    if (mapController == null) return;

    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(loc.latitude, loc.longitude),
      zoom: 20.0,
      bearing: 192.8334901395799,
    )));
  }
}

