import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

import '../services/gps_service.dart';

class MyNaverMap extends StatefulWidget {
  const MyNaverMap({
    super.key,
    required this.ViewType,
  });

  final String ViewType;

  @override
  State<MyNaverMap> createState() => _MyNaverMapState();
}

class _MyNaverMapState extends State<MyNaverMap> {
  static const platform = MethodChannel("UserTmap");
  late Position user_position;
  late double latitude, longitude;

  Future<void> sendUserLatLng() async {
    try {
      await platform.invokeMethod(
          'sendUserLatLng', {'latitude': latitude, 'longitude': longitude});
    } on PlatformException catch (e) {
      log('Error: $e');
    }
  }

  Future<void> getUserPosition() async {
    user_position = await GPSService.getPosition();
    latitude = user_position.latitude;
    longitude = user_position.longitude;
    sendUserLatLng();
  }

  @override
  Widget build(BuildContext context) {
    return const Text("Not Widget"); // return FutureBuilder(
  }
}
