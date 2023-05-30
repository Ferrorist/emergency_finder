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
    required this.phonenumber,
    required this.address,
    required this.department,
    required this.congestion,
    required this.major,
    required this.fromtodistance,
    required this.longitude,
    required this.latitude,
  });
}
