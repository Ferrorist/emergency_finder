class HospitalModel {
  final String name;
  final String address;
  final List<String> department;
  final int congestion;
  final String? major;
  final double? fromtodistance;

  HospitalModel({
    required this.name,
    required this.address,
    required this.department,
    required this.congestion,
    required this.major,
    required this.fromtodistance,
  });
}
