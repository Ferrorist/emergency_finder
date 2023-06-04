import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';

import '../services/gps_service.dart';

class userMapWidget extends StatefulWidget {
  const userMapWidget({super.key, required this.ViewType});
  final String ViewType;
  @override
  State<userMapWidget> createState() => _userMapWidgetState();
}

class _userMapWidgetState extends State<userMapWidget> {
  static const platform = MethodChannel("UserNaverMap");
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
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserPosition(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          sendUserLatLng();
          return AndroidView(
            viewType: widget.ViewType,
            layoutDirection: TextDirection.ltr,
            creationParams: const <String, dynamic>{},
            creationParamsCodec: const StandardMessageCodec(),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
