import 'package:geolocator/geolocator.dart';

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
}

