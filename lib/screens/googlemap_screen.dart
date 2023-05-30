import 'package:emergency_finder/widgets/googlemap_widget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../services/gps_service.dart';

class GoogleMapScreen extends StatelessWidget {
  GoogleMapScreen({super.key});
  final Future<Position> user_position = GPSService.getPosition();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: user_position,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return MyGoogleMap(userPosition: user_position);
        }
      },
    ));
  }
}
