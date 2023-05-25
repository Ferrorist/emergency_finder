import 'package:geolocator/geolocator.dart';

class GPSService {
  // 권한 요청
  static Future<bool> determinePermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.value(false);
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return Future.value(false);
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.value(false);
    }
    return Future.value(true);
  }

  static Future<Position> getPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    return position;
  }
}
