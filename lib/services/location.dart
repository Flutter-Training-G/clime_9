import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  Future<void> getCurrentLocation() async {
    print('In Location.getCurrentLocation()');
    LocationPermission permission = await Geolocator.requestPermission();
    print(permission);
    print('Permission Requested');

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
      print('lat $latitude, lon $longitude');
    } catch (e) {
      // TODO
      print(e);
    }
  }
}
