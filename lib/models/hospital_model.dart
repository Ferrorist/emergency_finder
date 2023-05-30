class HospitalModel {
  final String name;
  final String address;
  final List<String> department;
  final int congestion;

  HospitalModel({
    required this.name,
    required this.address,
    required this.department,
    required this.congestion,
  });
}
