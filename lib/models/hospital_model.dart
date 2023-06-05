import 'package:geolocator/geolocator.dart';

class HospitalModel {
  final String name;
  final String address;
  final List<String> department;
  final int congestion;
  final String? major;
  final double? fromtodistance;
  final String phonenumber;
  final double longitude;
  final double latitude;

  HospitalModel({
    required this.name,
    required this.address,
    required this.department,
    required this.congestion,
    this.major,
    this.fromtodistance,
    required this.phonenumber,
    required this.longitude,
    required this.latitude,
  });

  static Future<HospitalModel> fromJsonWithLocation(
      Map<String, dynamic> json) async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return HospitalModel(
      name: json['hospital_name'],
      address: json['address'],
      department: [],
      congestion: (json['bed_number'] != 0) ? ((json['bed_number_now'] / json['bed_number']) * 100).toInt() : 0
      ,
      major: '',
      fromtodistance: json['distance_km'],
      phonenumber: json['phone'],
      longitude: position.longitude,
      latitude: position.latitude,
    );
  }
}
